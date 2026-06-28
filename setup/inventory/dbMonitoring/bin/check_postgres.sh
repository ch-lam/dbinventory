#!/bin/bash
# check_postgres.sh - PostgreSQL monitoring checks
# Requires: psql client, PostgreSQL 9.6+ (pg_blocking_pids), PostgreSQL 10+ (pg_sequences, pg_current_logfile)
# Monitoring user needs: pg_monitor role (or CONNECT + SELECT on pg_catalog views)

export RETCODE=0
export WARNING_MSG="WARNING - "
export CRITICAL_MSG="CRITICAL - "
export OK_MSG="OK - "

#DEFAULT EXIT CODE
export STATE_OK=0
export STATE_CRITICAL=2
export STATE_WARNING=1

#DEFAULT THRESHOLD
export WARNING_THRESHOLD=80
export CRITICAL_THRESHOLD=90

#DEFAULT CONNECTION PARAMS
export PORT=5432
export DBNAME="postgres"

while getopts :m:h:u:p:w:c:d:P:q: OPTION
  do
   case "$OPTION" in
    m) export MODE=$OPTARG ;;
    h) export HOST_NAME_TO_CHECK=$OPTARG ;;
    u) export USR_DB=$OPTARG ;;
    p) export PWD_DB=$OPTARG ;;
    w) export WARNING_THRESHOLD=$OPTARG ;;
    c) export CRITICAL_THRESHOLD=$OPTARG ;;
    d) export DBNAME=$OPTARG ;;
    P) export PORT=$OPTARG ;;
    q) export QUERY=$OPTARG ;;
    :) echo "$0: $OPTARG option missing argument!"
       exit 2 ;;
    ?) print_usage ; exit 1 ;;
   esac
done

print_usage(){
    echo "Invalid Option"
    echo "Usage:"
    echo "-m check_connect           -h HOST -u USER -p PWD [-d DB] [-P PORT]"
    echo "-m check_uptime            -h HOST -u USER -p PWD [-d DB] [-P PORT]"
    echo "-m check_connection_usage  -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING -c CRITICAL (%Used of max_connections)"
    echo "-m check_database_size     -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING -c CRITICAL (MB per database)"
    echo "-m check_replication_state -h HOST -u USER -p PWD [-d DB] [-P PORT]"
    echo "-m check_replication_lag   -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING -c CRITICAL (seconds, standby only)"
    echo "-m check_wal_archiving     -h HOST -u USER -p PWD [-d DB] [-P PORT] -c CRITICAL (hours since last successful archive)"
    echo "-m check_backup            -h HOST -u USER -p PWD [-d DB] [-P PORT] -c CRITICAL (hours since last WAL archive)"
    echo "-m check_invalid_indexes   -h HOST -u USER -p PWD [-d DB] [-P PORT]"
    echo "-m check_long_query        -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING (number of hours)"
    echo "-m check_locks             -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING (seconds blocked, requires PG 9.6+)"
    echo "-m check_bloat             -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING -c CRITICAL (%dead tuples per table)"
    echo "-m check_sequences_usage   -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING (%usage, requires PG 10+)"
    echo "-m check_autovacuum        -h HOST -u USER -p PWD [-d DB] [-P PORT] -w WARNING -c CRITICAL (number of dead tuples)"
    echo "-m check_db_alertlog       (only locally as postgres user - scans log for FATAL/PANIC errors)"
    echo "-m check_query_result      -h HOST -u USER -p PWD [-d DB] [-P PORT] -q QUERY (CRITICAL if result != 0)"
}

fct_psql(){
    PGPASSWORD="${PWD_DB}" psql -h "${HOST_NAME_TO_CHECK}" -p "${PORT}" -U "${USR_DB}" -d "${DBNAME}" -t -A -c "$1" 2>/dev/null
}

fct_main(){
    RESULT=$(fct_psql "SELECT 'OK'")
    if [ "$(echo "${RESULT}" | grep '^OK$' | wc -l)" -ne 1 ]; then
        echo "CRITICAL - Cannot connect to PostgreSQL ${HOST_NAME_TO_CHECK}:${PORT}/${DBNAME}"
        exit $STATE_CRITICAL
    else
        $1
    fi
}

fct_check_connect(){
    if PGPASSWORD="${PWD_DB}" psql -h "${HOST_NAME_TO_CHECK}" -p "${PORT}" -U "${USR_DB}" -d "${DBNAME}" -t -A -c "SELECT 'OK'" 2>/dev/null | grep -q '^OK$'; then
        echo "OK - Successfully connected to PostgreSQL ${HOST_NAME_TO_CHECK}:${PORT}/${DBNAME}"
        exit $STATE_OK
    else
        ERRMSG=$(PGPASSWORD="${PWD_DB}" psql -h "${HOST_NAME_TO_CHECK}" -p "${PORT}" -U "${USR_DB}" -d "${DBNAME}" -t -A -c "SELECT 'OK'" 2>&1 | grep -iE "error|fatal|could not|password" | head -1)
        echo "CRITICAL - Failed to connect to PostgreSQL ${HOST_NAME_TO_CHECK}:${PORT}/${DBNAME}: ${ERRMSG}"
        exit $STATE_CRITICAL
    fi
}

fct_check_uptime(){
    RESTART_DETECTED=$(fct_psql "SELECT CASE WHEN pg_postmaster_start_time() > now() - interval '20 minutes' THEN 'VALUE1' ELSE 'VALUE0' END")
    RESTART_TIME=$(fct_psql "SELECT to_char(pg_postmaster_start_time(), 'DD/MM/YYYY HH24:MI:SS')")

    if echo "${RESTART_DETECTED}" | grep -q "VALUE1"; then
        echo "WARNING - PostgreSQL has been restarted at ${RESTART_TIME}"
        exit $STATE_WARNING
    else
        echo "OK - No recent restart detected - Uptime since ${RESTART_TIME}"
        exit $STATE_OK
    fi
}

fct_check_connection_usage(){
    USAGE=$(fct_psql "SELECT round(count(*)::numeric / current_setting('max_connections')::numeric * 100)::int FROM pg_stat_activity")
    MAX_CONN=$(fct_psql "SELECT current_setting('max_connections')")
    ACTIVE_CONN=$(fct_psql "SELECT count(*) FROM pg_stat_activity")

    if [[ "${USAGE}" -gt "${CRITICAL_THRESHOLD}" ]]; then
        echo "CRITICAL - Connection usage ${USAGE}% (${ACTIVE_CONN}/${MAX_CONN}) |'connection_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL
    elif [[ "${USAGE}" -gt "${WARNING_THRESHOLD}" ]]; then
        echo "WARNING - Connection usage ${USAGE}% (${ACTIVE_CONN}/${MAX_CONN}) |'connection_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
    else
        echo "OK - Connection usage ${USAGE}% (${ACTIVE_CONN}/${MAX_CONN}) |'connection_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
    fi
}

fct_check_database_size(){
    USAGE1=$(fct_psql "SELECT 'VALUE'||datname||':'||round(pg_database_size(datname)/1024/1024)::int FROM pg_database WHERE datname NOT IN ('template0','template1') ORDER BY 1")

    for line in $(echo $USAGE1 | sed 's/VALUE//g'); do
        export DB=$(echo $line | cut -d ":" -f1)
        export SIZE_MB=$(echo $line | cut -d ":" -f2)
        PERF=$(echo ${PERF} \'${DB}\'=${SIZE_MB}MB)

        if [[ "${SIZE_MB}" -gt "${CRITICAL_THRESHOLD}" ]]; then
            DB_CRITICAL=$(echo ${DB_CRITICAL} ${DB}:${SIZE_MB}MB /)
        elif [[ "${SIZE_MB}" -gt "${WARNING_THRESHOLD}" ]]; then
            DB_WARNING=$(echo ${DB_WARNING} ${DB}:${SIZE_MB}MB /)
        else
            DB_OK=$(echo ${DB_OK} ${DB}:${SIZE_MB}MB /)
        fi
    done

    if [ ! -z "${DB_CRITICAL}" ]; then
        echo "CRITICAL - Database size critical: ${DB_CRITICAL} Warning:${DB_WARNING} |${PERF};"
        exit $STATE_CRITICAL
    else
        if [ -z "${DB_WARNING}" ]; then
            echo "OK - All database sizes within threshold |${PERF};"
            exit $STATE_OK
        else
            echo "WARNING - Database size warning: ${DB_WARNING} |${PERF};"
            exit $STATE_WARNING
        fi
    fi
}

fct_check_replication_state(){
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")

    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        # Standby side: check WAL receiver
        RECV_STATE=$(fct_psql "SELECT 'VALUE'||status||':'||to_char(last_msg_receipt_time,'DD/MM/YYYY HH24:MI:SS') FROM pg_stat_wal_receiver")
        if echo "${RECV_STATE}" | grep -q "VALUE"; then
            STATUS=$(echo "${RECV_STATE}" | sed 's/VALUE//g' | cut -d ":" -f1)
            LAST_MSG=$(echo "${RECV_STATE}" | sed 's/VALUE//g' | cut -d ":" -f2-)
            if echo "${STATUS}" | grep -q "streaming"; then
                echo "OK - PostgreSQL STANDBY in streaming replication - last message: ${LAST_MSG}"
                exit $STATE_OK
            else
                echo "WARNING - PostgreSQL STANDBY WAL receiver state is: ${STATUS} - last message: ${LAST_MSG}"
                exit $STATE_WARNING
            fi
        else
            echo "CRITICAL - PostgreSQL STANDBY but WAL receiver is not running"
            exit $STATE_CRITICAL
        fi
    else
        # Primary side: check connected standbys
        NB_STREAMING=$(fct_psql "SELECT count(*) FROM pg_stat_replication WHERE state='streaming'")
        NB_TOTAL=$(fct_psql "SELECT count(*) FROM pg_stat_replication")

        if [[ "${NB_TOTAL}" -eq 0 ]]; then
            echo "OK - PostgreSQL PRIMARY with no standby configured"
            exit $STATE_OK
        elif [[ "${NB_STREAMING}" -lt "${NB_TOTAL}" ]]; then
            NOT_STREAMING=$(fct_psql "SELECT 'VALUE'||coalesce(client_addr::text,'local')||':'||state FROM pg_stat_replication WHERE state!='streaming'")
            DETAILS=$(echo "${NOT_STREAMING}" | sed 's/VALUE//g' | tr '\n' ' ')
            echo "WARNING - PostgreSQL PRIMARY: ${NB_STREAMING}/${NB_TOTAL} standbys streaming. Issues: ${DETAILS}"
            exit $STATE_WARNING
        else
            STANDBYS=$(fct_psql "SELECT string_agg(coalesce(client_addr::text,'local')||'('||sync_state||')',', ') FROM pg_stat_replication")
            echo "OK - PostgreSQL PRIMARY: ${NB_STREAMING} standby(s) streaming - ${STANDBYS}"
            exit $STATE_OK
        fi
    fi
}

fct_check_replication_lag(){
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")

    if echo "${IS_STANDBY}" | grep -q '^f$'; then
        echo "OK - PostgreSQL is PRIMARY - no replication lag to monitor"
        exit $STATE_OK
    fi

    LAG_SECONDS=$(fct_psql "SELECT CASE WHEN pg_last_xact_replay_timestamp() IS NULL THEN -1 ELSE round(extract(epoch FROM (now()-pg_last_xact_replay_timestamp())))::int END")

    if [[ "${LAG_SECONDS}" -eq -1 ]]; then
        echo "WARNING - PostgreSQL STANDBY: no replay timestamp available (no WAL replayed yet?)"
        exit $STATE_WARNING
    elif [[ "${LAG_SECONDS}" -gt "${CRITICAL_THRESHOLD}" ]]; then
        echo "CRITICAL - Replication lag ${LAG_SECONDS}s |'replication_lag'=${LAG_SECONDS}s;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL
    elif [[ "${LAG_SECONDS}" -gt "${WARNING_THRESHOLD}" ]]; then
        echo "WARNING - Replication lag ${LAG_SECONDS}s |'replication_lag'=${LAG_SECONDS}s;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
    else
        echo "OK - Replication lag ${LAG_SECONDS}s |'replication_lag'=${LAG_SECONDS}s;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
    fi
}

fct_check_wal_archiving(){
    ARCHIVING=$(fct_psql "SELECT setting FROM pg_settings WHERE name='archive_mode'")
    if ! echo "${ARCHIVING}" | grep -qE '^(on|always)$'; then
        echo "OK - WAL archiving is disabled (archive_mode=${ARCHIVING:-off})"
        exit $STATE_OK
    fi

    RESULT=$(fct_psql "SELECT 'VALUE'||failed_count||':'||COALESCE(last_failed_wal,'none')||':'||CASE WHEN last_failed_time IS NOT NULL AND (last_archived_time IS NULL OR last_failed_time > last_archived_time) THEN 'RECENT_FAILURE' ELSE 'OK' END||':'||CASE WHEN last_archived_time IS NULL THEN -1 ELSE round(extract(epoch FROM (now()-last_archived_time))/3600)::int END FROM pg_stat_archiver")

    FAILED_COUNT=$(echo "${RESULT}" | sed 's/VALUE//g' | cut -d ":" -f1)
    LAST_FAILED_WAL=$(echo "${RESULT}" | sed 's/VALUE//g' | cut -d ":" -f2)
    ARCH_STATUS=$(echo "${RESULT}" | sed 's/VALUE//g' | cut -d ":" -f3)
    HOURS_SINCE=$(echo "${RESULT}" | sed 's/VALUE//g' | cut -d ":" -f4)

    if echo "${ARCH_STATUS}" | grep -q "RECENT_FAILURE"; then
        echo "CRITICAL - WAL archiving has recent failure(s) (total: ${FAILED_COUNT}), last failed WAL: ${LAST_FAILED_WAL} |'hours_since_archive'=${HOURS_SINCE}h;;${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL
    elif [[ "${HOURS_SINCE}" -gt "${CRITICAL_THRESHOLD}" ]]; then
        echo "CRITICAL - No WAL successfully archived since ${HOURS_SINCE} hours |'hours_since_archive'=${HOURS_SINCE}h;;${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL
    else
        echo "OK - WAL archiving OK, last archive ${HOURS_SINCE} hours ago |'hours_since_archive'=${HOURS_SINCE}h;;${CRITICAL_THRESHOLD};"
        exit $STATE_OK
    fi
}

fct_check_backup(){
    # Monitors backup freshness based on last successful WAL archive (pg_stat_archiver)
    # For physical backups (pg_basebackup/barman/pgbackrest), use check_query_result with a custom query
    ARCHIVING=$(fct_psql "SELECT setting FROM pg_settings WHERE name='archive_mode'")
    if ! echo "${ARCHIVING}" | grep -qE '^(on|always)$'; then
        echo "OK - WAL archiving disabled - backup via WAL archive cannot be monitored"
        exit $STATE_OK
    fi

    HOURS_SINCE=$(fct_psql "SELECT CASE WHEN last_archived_time IS NULL THEN 9999 ELSE round(extract(epoch FROM (now()-last_archived_time))/3600)::int END FROM pg_stat_archiver")

    if [[ "${HOURS_SINCE}" -gt "${CRITICAL_THRESHOLD}" ]]; then
        echo "CRITICAL - No WAL archived since ${HOURS_SINCE} hours (threshold: ${CRITICAL_THRESHOLD}h)"
        exit $STATE_CRITICAL
    else
        echo "OK - Last WAL archive was ${HOURS_SINCE} hours ago (threshold: ${CRITICAL_THRESHOLD}h)"
        exit $STATE_OK
    fi
}

fct_check_invalid_indexes(){
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")
    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        echo "OK - PostgreSQL STANDBY detected - no monitoring of invalid indexes required"
        exit $STATE_OK
    fi

    USAGE=$(fct_psql "SELECT 'VALUE'||n.nspname||'.'||t.relname||' INDEX:'||i.relname FROM pg_class t JOIN pg_namespace n ON n.oid=t.relnamespace JOIN pg_index idx ON idx.indrelid=t.oid JOIN pg_class i ON i.oid=idx.indexrelid WHERE idx.indisvalid=false AND n.nspname NOT IN ('pg_catalog','information_schema','pg_toast') ORDER BY 1")

    if echo "${USAGE}" | grep -q "VALUE"; then
        INVALIDS=$(echo "${USAGE}" | sed 's/VALUE//g' | tr '\n' '; ')
        echo "CRITICAL - Invalid indexes detected: ${INVALIDS}"
        exit $STATE_CRITICAL
    else
        echo "OK - No invalid indexes detected"
        exit $STATE_OK
    fi
}

fct_check_long_query(){
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")
    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        echo "OK - PostgreSQL STANDBY detected - no monitoring of long queries required"
        exit $STATE_OK
    fi

    USAGE=$(fct_psql "SELECT 'VALUE'||datname||':PID:'||pid||':USER:'||usename||':SINCE:'||to_char(query_start,'DD/MM/YYYY HH24:MI:SS')||':QUERY:'||left(query,80) FROM pg_stat_activity WHERE state='active' AND query_start < now()-interval '${WARNING_THRESHOLD} hours' AND query NOT LIKE '%pg_stat_activity%' AND pid!=pg_backend_pid() ORDER BY query_start")

    if echo "${USAGE}" | grep -q "VALUE"; then
        LONG_QUERIES=$(echo "${USAGE}" | sed 's/VALUE//g' | tr '\n' ' | ')
        echo "WARNING - Queries running since more than ${WARNING_THRESHOLD} hours: ${LONG_QUERIES}"
        exit $STATE_WARNING
    else
        echo "OK - No query running since more than ${WARNING_THRESHOLD} hours"
        exit $STATE_OK
    fi
}

fct_check_locks(){
    # Requires PostgreSQL 9.6+ (pg_blocking_pids function)
    USAGE=$(fct_psql "SELECT 'VALUE'||blocked.datname||': PID '||blocked.pid||'('||blocked.usename||') blocked by PID '||blocking.pid||'('||blocking.usename||') since '||round(extract(epoch FROM (now()-blocked.query_start)))||'s' FROM pg_stat_activity blocked JOIN pg_stat_activity blocking ON blocking.pid=ANY(pg_blocking_pids(blocked.pid)) WHERE cardinality(pg_blocking_pids(blocked.pid))>0 AND extract(epoch FROM (now()-blocked.query_start))>${WARNING_THRESHOLD} ORDER BY 1")

    if echo "${USAGE}" | grep -q "VALUE"; then
        LOCKED=$(echo "${USAGE}" | sed 's/VALUE//g' | tr '\n' ' | ')
        echo "WARNING - Locked sessions since more than ${WARNING_THRESHOLD} seconds:
${LOCKED}"
        exit $STATE_WARNING
    else
        echo "OK - No locked session reaching threshold of ${WARNING_THRESHOLD} seconds"
        exit $STATE_OK
    fi
}

fct_check_bloat(){
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")
    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        echo "OK - PostgreSQL STANDBY detected - no monitoring of table bloat required"
        exit $STATE_OK
    fi

    USAGE1=$(fct_psql "SELECT 'VALUE'||schemaname||'.'||relname||':'||round(100.0*n_dead_tup/(n_live_tup+n_dead_tup))::int FROM pg_stat_user_tables WHERE n_live_tup+n_dead_tup>1000 AND n_dead_tup>0 AND round(100.0*n_dead_tup/(n_live_tup+n_dead_tup))>=${WARNING_THRESHOLD} ORDER BY n_dead_tup DESC")

    for line in $(echo $USAGE1 | sed 's/VALUE//g'); do
        TABLE=$(echo $line | cut -d ":" -f1)
        PCT=$(echo $line | cut -d ":" -f2)
        TABLE_METRIC=$(echo ${TABLE} | tr '.' '_')
        PERF=$(echo ${PERF} \'${TABLE_METRIC}_bloat\'=${PCT}%)

        if [[ "${PCT}" -gt "${CRITICAL_THRESHOLD}" ]]; then
            BLOAT_CRITICAL=$(echo ${BLOAT_CRITICAL} ${TABLE}:${PCT}% /)
        elif [[ "${PCT}" -ge "${WARNING_THRESHOLD}" ]]; then
            BLOAT_WARNING=$(echo ${BLOAT_WARNING} ${TABLE}:${PCT}% /)
        fi
    done

    if [ ! -z "${BLOAT_CRITICAL}" ]; then
        echo "CRITICAL - Table bloat critical (VACUUM FULL needed): ${BLOAT_CRITICAL} |${PERF};"
        exit $STATE_CRITICAL
    else
        if [ -z "${BLOAT_WARNING}" ]; then
            echo "OK - Table bloat within threshold |${PERF:-'no_significant_bloat'=0%};"
            exit $STATE_OK
        else
            echo "WARNING - Table bloat warning (VACUUM recommended): ${BLOAT_WARNING} |${PERF};"
            exit $STATE_WARNING
        fi
    fi
}

fct_check_sequences_usage(){
    # Requires PostgreSQL 10+ (pg_sequences view with last_value)
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")
    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        echo "OK - PostgreSQL STANDBY detected - no check required"
        exit $STATE_OK
    fi

    USAGE1=$(fct_psql "SELECT 'VALUE'||schemaname||'.'||sequencename||':'||round(last_value::numeric/max_value::numeric*100)::int FROM pg_sequences WHERE last_value IS NOT NULL AND schemaname NOT IN ('pg_catalog','information_schema') AND is_cycled=false AND round(last_value::numeric/max_value::numeric*100)>=${WARNING_THRESHOLD} ORDER BY 1")

    if echo "${USAGE1}" | grep -q "VALUE"; then
        SEQ_LIST=$(echo "${USAGE1}" | sed 's/VALUE//g' | tr '\n' ' ')
        echo "WARNING - Some sequences near usage limit (>${WARNING_THRESHOLD}%): ${SEQ_LIST}"
        exit $STATE_WARNING
    else
        echo "OK - No sequence near usage limit ${WARNING_THRESHOLD}%"
        exit $STATE_OK
    fi
}

fct_check_autovacuum(){
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")
    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        echo "OK - PostgreSQL STANDBY detected - no monitoring of autovacuum required"
        exit $STATE_OK
    fi

    USAGE_CRIT=$(fct_psql "SELECT 'VALUE'||schemaname||'.'||relname||':'||n_dead_tup FROM pg_stat_user_tables WHERE n_dead_tup>${CRITICAL_THRESHOLD} ORDER BY n_dead_tup DESC")
    USAGE_WARN=$(fct_psql "SELECT 'VALUE'||schemaname||'.'||relname||':'||n_dead_tup FROM pg_stat_user_tables WHERE n_dead_tup>${WARNING_THRESHOLD} AND n_dead_tup<=${CRITICAL_THRESHOLD} ORDER BY n_dead_tup DESC")

    for line in $(echo $USAGE_CRIT | sed 's/VALUE//g'); do
        TABLE=$(echo $line | cut -d ":" -f1)
        DEAD=$(echo $line | cut -d ":" -f2)
        TABLE_METRIC=$(echo ${TABLE} | tr '.' '_')
        PERF=$(echo ${PERF} \'${TABLE_METRIC}_dead\'=${DEAD})
        TABLES_CRITICAL=$(echo ${TABLES_CRITICAL} ${TABLE}:${DEAD}_dead_tuples /)
    done

    for line in $(echo $USAGE_WARN | sed 's/VALUE//g'); do
        TABLE=$(echo $line | cut -d ":" -f1)
        DEAD=$(echo $line | cut -d ":" -f2)
        TABLE_METRIC=$(echo ${TABLE} | tr '.' '_')
        PERF=$(echo ${PERF} \'${TABLE_METRIC}_dead\'=${DEAD})
        TABLES_WARNING=$(echo ${TABLES_WARNING} ${TABLE}:${DEAD}_dead_tuples /)
    done

    if [ ! -z "${TABLES_CRITICAL}" ]; then
        echo "CRITICAL - Tables requiring urgent VACUUM (>${CRITICAL_THRESHOLD} dead tuples): ${TABLES_CRITICAL} |${PERF};"
        exit $STATE_CRITICAL
    elif [ ! -z "${TABLES_WARNING}" ]; then
        echo "WARNING - Tables requiring VACUUM (>${WARNING_THRESHOLD} dead tuples): ${TABLES_WARNING} |${PERF};"
        exit $STATE_WARNING
    else
        echo "OK - No tables requiring urgent vacuum (threshold: ${CRITICAL_THRESHOLD} dead tuples)"
        exit $STATE_OK
    fi
}

fct_check_db_alertlog(){
    # Local check only - must run as postgres user or with log file read access
    # Requires PostgreSQL 10+ for pg_current_logfile()
    LOGFILE=$(psql -U postgres -t -A -c "SELECT pg_current_logfile()" 2>/dev/null)
    if [ -z "${LOGFILE}" ]; then
        echo "WARNING - Cannot determine PostgreSQL log file path (check pg_current_logfile() or run as postgres user)"
        exit $STATE_WARNING
    fi

    DATADIR=$(psql -U postgres -t -A -c "SHOW data_directory" 2>/dev/null)
    if [[ "${LOGFILE}" != /* ]]; then
        LOGFILE="${DATADIR}/${LOGFILE}"
    fi

    if [ ! -f "${LOGFILE}" ]; then
        echo "WARNING - PostgreSQL log file not found: ${LOGFILE}"
        exit $STATE_WARNING
    fi

    # Look for FATAL or PANIC errors in the last hour (assumes default log_line_prefix with timestamp)
    THIS_HOUR=$(date '+%Y-%m-%d %H')
    LAST_HOUR=$(date -d '1 hour ago' '+%Y-%m-%d %H' 2>/dev/null || date -v-1H '+%Y-%m-%d %H' 2>/dev/null)

    CHECK_ERROR=$(grep -E "^(${THIS_HOUR}|${LAST_HOUR})[^|]*(FATAL|PANIC)" "${LOGFILE}" 2>/dev/null | wc -l)

    if [[ "${CHECK_ERROR}" -gt 0 ]]; then
        ERROR_MSGS=$(grep -E "^(${THIS_HOUR}|${LAST_HOUR})[^|]*(FATAL|PANIC)" "${LOGFILE}" 2>/dev/null | tail -5)
        echo "WARNING - FATAL/PANIC errors found in PostgreSQL log:
${ERROR_MSGS}"
        exit $STATE_WARNING
    else
        echo "OK - No FATAL/PANIC errors found in recent PostgreSQL log (${LOGFILE})"
        exit $STATE_OK
    fi
}

fct_check_query_result(){
    QUERY_ESC=$(echo ${QUERY} | sed 's/_dollar_/$/g')
    IS_STANDBY=$(fct_psql "SELECT pg_is_in_recovery()::text")
    if echo "${IS_STANDBY}" | grep -q '^t$'; then
        echo "OK - PostgreSQL STANDBY detected - no monitoring of query required"
        exit $STATE_OK
    fi

    USAGE=$(PGPASSWORD="${PWD_DB}" psql -h "${HOST_NAME_TO_CHECK}" -p "${PORT}" -U "${USR_DB}" -d "${DBNAME}" -t -A -c "${QUERY_ESC}" 2>/dev/null | grep "RESULT:")

    if ! echo "${USAGE}" | grep -q "RESULT:0"; then
        echo "CRITICAL - Query returned result != 0: ${USAGE}"
        exit $STATE_CRITICAL
    else
        echo "OK - Query returned 0"
        exit $STATE_OK
    fi
}

case "${MODE}" in
    check_connect)
        fct_check_connect
        ;;
    check_uptime)
        fct_main fct_check_uptime
        ;;
    check_connection_usage)
        fct_main fct_check_connection_usage
        ;;
    check_database_size)
        fct_main fct_check_database_size
        ;;
    check_replication_state)
        fct_main fct_check_replication_state
        ;;
    check_replication_lag)
        fct_main fct_check_replication_lag
        ;;
    check_wal_archiving)
        fct_main fct_check_wal_archiving
        ;;
    check_backup)
        fct_main fct_check_backup
        ;;
    check_invalid_indexes)
        fct_main fct_check_invalid_indexes
        ;;
    check_long_query)
        fct_main fct_check_long_query
        ;;
    check_locks)
        fct_main fct_check_locks
        ;;
    check_bloat)
        fct_main fct_check_bloat
        ;;
    check_sequences_usage)
        fct_main fct_check_sequences_usage
        ;;
    check_autovacuum)
        fct_main fct_check_autovacuum
        ;;
    check_db_alertlog)
        fct_check_db_alertlog
        ;;
    check_query_result)
        fct_main fct_check_query_result
        ;;
    *)
        print_usage
        exit 1
esac
