#!/bin/bash

export ORACLE_HOME=/inventory/OracleClient/instantclient_23_9
export TNS_ADMIN=/inventory/OracleClient/instantclient_23_9/network
export LD_LIBRARY_PATH=$ORACLE_HOME
export PATH=$PATH:$ORACLE_HOME

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

while getopts :m:t:u:p:w:c:f:q:e: OPTION
        do
         case "$OPTION" in
          m) export MODE=$OPTARG
             ;;
          t) export CON_TNS=$OPTARG
             ;;
          u) export USR_DB=$OPTARG
             ;;
          p) export PWD_DB=$OPTARG
             ;;
          w) export WARNING_THRESHOLD=$OPTARG
             ;;
          c) export CRITICAL_THRESHOLD=$OPTARG
             ;;
          f) export FS_NAME=$OPTARG
             ;;
          q) export QUERY=$OPTARG
             ;;
          e) export EXCLUDE=$OPTARG
             ;;
          :) echo "$0: $OPTARG option missing argument!"
             exit 2 ;;
          ?)  echo Invalid Option $"Usage: "
                        echo "-m check_connect -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_connect_oud -t easy_connect_format -u USERNAME -p PASSWORD -f USERNAME_OUD -q PASSWORD_OUD -e EXCLUDE_DB"
                        echo "-m check_uptime -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_process_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_recyclebin_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (Go Used)"
                        echo "-m check_session_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_fast_recovery_usage -t easy_connect_format -u USERNAME --p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_pga_usage -t easy_connect_format -u USERNAME --p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_sga_usage -t easy_connect_format -u USERNAME --p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_tbs_freespace -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (GB Free)"
                        echo "-m check_sequence_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (%USAGE)"
                        echo "-m check_remaining_day_tbs -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (number days before reach full)"
                        echo "-m check_numberofdatafile -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (number of datafiles possible)"
                        echo "-m check_backup_full -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number hours since last backup)"
                        echo "-m check_backup_inc -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number hours since last backup)"
                        echo "-m check_backup_arch -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number hours since last backup)"
                        echo "-m check_invalidobjects -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_corruptedblock -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_dataguard_latency -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_oracle_queue -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_table_stats_locked -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_db_alertlog (only locally with oracle user)"
                        echo "-m check_db_cpu_usage (only locally with oracle user)"
                        echo "-m check_asm_disk_state (only locally with oracle user)"
                        echo "-m check_asm_disk_space -w WARNING -c CRITICAL (GB Free) (only locally with oracle user)"
                        echo "-m check_asm_instance_state (only locally with oracle user)"
                        echo "-m check_asm_alert_log (only locally with oracle user)"
                        echo "-m check_asm_diskgroup_state (only locally with oracle user)"
                        echo "-m check_asm_diskgroup_directory_size (only locally with oracle user)"
                        echo "-m check_archivelog_on -t easy_connect_format -u USERNAME -p PASSWORD -w {ARCHIVE/NOARCHIVELOG, default ARCHIVELOG}"
                        echo "-m check_datafile_state -t easy_connect_format -u USERNAME -p PASSWORD (Check that all datafiles and tempfile are online and available)"
                        echo "-m check_account_config_state -t easy_connect_format -u USERNAME -p PASSWORD (Check that all service account have service_profile and state is OPEN)"
                        echo "-m check_restore_point_date -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (number hours of restore point guarantee)"
                        echo "-m check_fs_from_db -t easy_connect_format -u USERNAME -p PASSWORD -f FS_NAME -c CRITICAL (number of MB Free)"
                        echo "-m check_job_state -t easy_connect_format -u USERNAME -p PASSWORD -w OWNER:JOB_NAME -f PDB_NAME"
                        echo "-m check_singleton_service -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_long_query -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (Number of hours)"
                        echo "-m check_lock_session -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (Number of seconds)"
                        echo "-m check_oratab"
                        #AIX Legacy
                        echo "-m check_table_alertlog -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_log_destination_state -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_nas_archivelog_mounted -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_fs_data -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number of GB Free)"
                        echo "-m check_fs_archivelog -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number of GB Free)"
                        echo "-m check_fs_home -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number of MB Free)"
                        echo "-m check_query_result -t easy_connect_format -u USERNAME -p PASSWORD -q QUERY(Return Critical if result <> 0)"
                        #Other Check
                        echo "-m check_dg_gap [-t easy_connect_format -u USERNAME -p PASSWORD] (Archivelog Diff warning if diff > 5)"
                        echo "-m check_broker_state -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_broker_standby_enable -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_pdb_open -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_pdb_save_state -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_orabasetab_exist"
                        echo "-m check_database_grows -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_cpu_usage_pdb -t easy_connect_format -u USERNAME -p PASSWORD"
                        exit 1
         esac
done

fct_main(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' FROM v\\$instance WHERE status='MOUNTED' or status='OPEN';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `

             if [ `echo ${USAGE} | grep "OK" | wc -l` -ne 1 ]; then
                                echo "CRITICAL - can't connect to databases ${CON_TNS}"
                                exit $STATE_CRITICAL
               else
                        $1
             fi
}

fct_check_connect(){
loginchk=`sqlplus dummy/user@${CON_TNS} < /dev/null`
loginchk2=` echo  $loginchk | grep -c ORA-01017`
if [ ${loginchk2} -eq 1 ] ; then
        echo "OK - dummy login connected"
        exit $STATE_OK
else
        loginchk3=` echo "$loginchk" | grep "ORA-" | head -1`
        if [ `echo ${loginchk3} | grep "ORA-01033" | wc -l` -eq 1 ]; then
          USAGE=`echo "set feedback off;
          set heading off;
          SELECT select 'OK' from v\\$database a, v\\$instance b where a.DATABASE_ROLE='PHYSICAL STANDBY' and b.status='MOUNTED';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
                        if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                        echo "OK - Physical Standby database mounted"
                                        exit $STATE_OK
                        else
                                           echo "CRITICAL - $loginchk3"
                                           exit $STATE_CRITICAL
                        fi
        else
           echo "CRITICAL - $loginchk3"
           exit $STATE_CRITICAL
        fi
fi
}
fct_check_uptime(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||count(*) FROM v\\$instance WHERE startup_time > sysdate-20/(24*60);" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

RESTART_TIME=`echo "set feedback off;
             set heading off;
             alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
             SELECT 'VALUE'||startup_time FROM v\\$instance;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -ne 0 ]]; then
        echo "WARNING - database has been restart at ${RESTART_TIME}"
        exit $STATE_WARNING
else
        echo "OK - no restart of database detected: Uptime since ${RESTART_TIME}"
        exit $STATE_OK
fi
}
fct_check_process_usage(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||ROUND(current_utilization/limit_value*100) FROM v\\$resource_limit WHERE resource_name LIKE '%processes%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -gt "$CRITICAL_THRESHOLD" ]]; then
        echo "CRITICAL - process usage ${USAGE}% |'process_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL

elif [[ "$USAGE" -gt "$WARNING_THRESHOLD" ]]; then
        echo "WARNING - process usage ${USAGE}% |'process_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
else
        echo "OK - process usage ${USAGE}% |'process_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
fi
}
fct_check_session_usage(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||ROUND(current_utilization/limit_value*100) FROM v\\$resource_limit WHERE resource_name = 'sessions';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -gt "$CRITICAL_THRESHOLD" ]]; then
        echo "CRITICAL - session usage ${USAGE}% |'session_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL

elif [[ "$USAGE" -gt "$WARNING_THRESHOLD" ]]; then
        echo "WARNING - session usage ${USAGE}% |'session_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
else
        echo "OK - session usage ${USAGE}% |'session_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
fi
}
fct_check_fast_recovery_usage(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||ROUND(SUM(PERCENT_SPACE_USED)-SUM(PERCENT_SPACE_RECLAIMABLE)) FROM V\\$FLASH_RECOVERY_AREA_USAGE;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -gt "$CRITICAL_THRESHOLD" ]]; then
        echo "CRITICAL - flash recovery usage ${USAGE}% |'fast_recovery_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL

elif [[ "$USAGE" -gt "$WARNING_THRESHOLD" ]]; then
        echo "WARNING - flash recovery usage ${USAGE}% |'fast_recovery_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
else
        echo "OK - flash recovery usage ${USAGE}% |'fast_recovery_usage'=${USAGE}%;${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
fi
}
fct_check_pga_usage(){
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
      USAGE1=`echo "set feedback off;
                    set heading off;
                    select 'VALUE'||(ROUND(a.VALUE/1024/1024)-ROUND(b.VALUE/1024/1024))||':'||ROUND(c.VALUE/1024/1024)||':'||ROUND(((ROUND(a.VALUE/1024/1024)-ROUND(b.VALUE/1024/1024))*100)/ROUND(c.VALUE/1024/1024))
                                from  (select NAME,VALUE from  V\\$PGASTAT where NAME in ('total PGA inuse')) a,
                               (select NAME,VALUE from  V\\$PGASTAT where NAME in ('total freeable PGA memory')) b,
                                   (select NAME,VALUE from v\\$parameter where lower(NAME) like 'pga_aggregate_limit') c;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
           for line in `echo $USAGE1`
                do
                export PGA_USED=`echo $line | cut -d ":" -f1`
                export PGA_MAX_SIZE=`echo $line | cut -d ":" -f2`
                export PGA_PERCENT_USED=`echo $line | cut -d ":" -f3`
                PERF=`echo "${PERF} 'PGA_USED'=${PGA_USED} 'PGA_MAX_SIZE'=${PGA_MAX_SIZE}MB"`

                if [[ "${PGA_PERCENT_USED}" -gt "$PGA_PERCENT_USED" ]]; then
                                PGA_CRITICAL=`echo ${PGA_CRITICAL} ${line} /`
                elif [[ "${PGA_PERCENT_USED}" -gt "$PGA_PERCENT_USED" ]]; then
                                PGA_WARNING=`echo ${PGA_WARNING} ${line} /`
                else
                                PGA_OK=`echo ${PGA_OK} ${line} /`
                fi
                done

                if [ ! -z "${PGA_CRITICAL}" ]
                        then
                                echo "CRITICAL - PGA usage critical ${PGA_PERCENT_USED}%: ${PGA_CRITICAL} |${PERF};"
                                exit $STATE_CRITICAL
                        else
                                if [ -z "${PGA_WARNING}" ]
                                        then
                                                echo "OK - PGA usage ok ${PGA_PERCENT_USED}%|${PERF};"
                                                exit $STATE_OK
                                        else
                                                echo "WARNING - PGA usage warning ${PGA_PERCENT_USED}%: ${PGA_WARNING} |${PERF};"
                                                exit $STATE_WARNING
                                fi
                fi
        else
                echo "OK - PGA Aggregate limit can't be monitor on this Oracle Version"
                exit $STATE_OK
fi
}
fct_check_sga_usage(){
STANDBY=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${STANDBY} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of query required"
                                exit $STATE_OK
              fi

CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='DBA_HIST_RSRC_PDB_METRIC'and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
      USAGE1=`echo "set feedback off;
                    set heading off;
                    SELECT 'VALUE'||sga_used||':'||sga_allocated||':'||round((100/sga_allocated)*sga_used) FROM (
SELECT round(sum(r.sga_bytes/1024/1024)) as sga_used
FROM   dba_hist_rsrc_pdb_metric r,
       cdb_pdbs p,
           v\\$instance i
WHERE  r.con_id = p.con_id
AND    r.INSTANCE_NUMBER = i.INSTANCE_NUMBER
group by r.begin_time,i.INSTANCE_NUMBER
ORDER BY r.begin_time DESC) a, (select round(sum(value)/1024/1024) as sga_allocated FROM v\\$sga)
WHERE rownum=1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

           for line in `echo $USAGE1`
                do
                export SGA_USED=`echo $line | cut -d ":" -f1`
                export SGA_ALLOCATED=`echo $line | cut -d ":" -f2`
                export SGA_USAGE=`echo $line | cut -d ":" -f3`
                PERF=`echo "${PERF} 'SGA_USED'=${SGA_USED}MB 'SGA_MAX_SIZE'=${SGA_ALLOCATED}MB 'SGA_USAGE'=${SGA_USAGE}%"`

                if [[ "${SGA_USAGE}" -gt "$CRITICAL_THRESHOLD" ]]; then
                                SGA_CRITICAL=`echo ${PGA_CRITICAL} ${line} /`
                elif [[ "${SGA_USAGE}" -gt "$WARNING_THRESHOLD" ]]; then
                                SGA_WARNING=`echo ${PGA_WARNING} ${line} /`
                else
                                SGA_OK=`echo ${SGA_OK} ${line} /`
                fi
                done

                if [ ! -z "${SGA_CRITICAL}" ]
                        then
                                echo "CRITICAL - SGA usage critical ${SGA_USAGE}%: ${SGA_USED}MB used ${SGA_ALLOCATED}MB allocated |${PERF};"
                                exit $STATE_CRITICAL
                        else
                                if [ -z "${SGA_WARNING}" ]
                                        then
                                                echo "OK - SGA usage ok ${SGA_USAGE}%: ${SGA_USED}MB used ${SGA_ALLOCATED}MB allocated |${PERF};"
                                                exit $STATE_OK
                                        else
                                                echo "WARNING - SGA usage warning ${SGA_USAGE}%: ${SGA_USED}MB used ${SGA_ALLOCATED}MB allocated |${PERF};"
                                                exit $STATE_WARNING
                                fi
                fi
        else
                echo "OK - NONCDB/Compatible Container detected, PDB SGA usage limit can't be monitor"
                exit $STATE_OK
fi
}
fct_check_tbs_freespace(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of tablespace required"
                                exit $STATE_OK
                else
#IF NOT A STANDBY CHECK VERSION
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi


if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
###IF CONTAINER
               USAGE1=`echo "set feedback off;
                             set heading off;
                             select 'VALUE'||b.NAME||'_'||a.tablespace_name||':'||ROUND(sum(a.MAXBYTES/1024/1024/1024)-sum(a.bytes/1024/1024/1024)) from cdb_data_files a, v\\$pdbs b where a.CON_ID = b.CON_ID and a.tablespace_name not like '%UNDO%' group by a.tablespace_name,b.NAME order by 1;"| sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
                else

####ELSE NON CONTAINER
                USAGE1=`echo "set feedback off;
                              set heading off;
                              select 'VALUE'||tablespace_name||':'||ROUND(sum(MAXBYTES/1024/1024/1024)-sum(bytes/1024/1024/1024)) from dba_data_files where tablespace_name not like '%UNDO%' group by tablespace_name;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
fi

for line in `echo $USAGE1`
do
        export TBS=`echo $line | cut -d ":" -f1`
        export SIZE_FREE=`echo $line | cut -d ":" -f2`
        PERF=`echo ${PERF} \'${TBS}\'=${SIZE_FREE}GB`

        if [[ "${SIZE_FREE}" -lt "$CRITICAL_THRESHOLD" ]]; then
                        TBS_CRITICAL=`echo ${TBS_CRITICAL} ${line} /`
                elif [[ "${SIZE_FREE}" -lt "$WARNING_THRESHOLD" ]]; then
                        TBS_WARNING=`echo ${TBS_WARNING} ${line} /`
                else
                        TBS_OK=`echo ${TBS_OK} ${line} /`
        fi
done

if [ ! -z "${TBS_CRITICAL}" ]
then
        echo "CRITICAL - Tablespace usage critical: ${TBS_CRITICAL} Warning:${TBS_WARNING} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${TBS_WARNING}" ]
                        then
                                echo "OK - Tablespace usage ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Tablespace usage warning: ${TBS_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
fi
}
fct_check_remaining_day_tbs(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
                else
#ELSE / IF NOT A STANDBY
#CHECK_MV_EXIST
CHECK_MV=`echo "set feedback off;
                set heading off;
                SELECT 'OK' from dba_objects where object_name='OPSVIEW_REMAINING_DAYS_MV';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
             if [ `echo ${CHECK_MV} | grep "OK" | wc -l` -ne 1 ]; then
                                echo "WARNING - MV Does not exist - You must create MV"
                                exit $STATE_WARNING
                else
                         USAGE1=`echo "set feedback off;
                                       set heading off;
                                       select * from OPSVIEW_REMAINING_DAYS_MV;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g' | grep -v "UNDO"`

for line in `echo $USAGE1`
do
        export TBS=`echo $line | cut -d ":" -f1`
        export REMAINING_DAYS=`echo $line | cut -d ":" -f2`
        export INCR_MB=`echo $line | cut -d ":" -f3`
        PERF=`echo ${PERF} \'${TBS}_Incr_MB\'=${INCR_MB}MB`

        if [[ "${REMAINING_DAYS}" -lt "$CRITICAL_THRESHOLD" ]]; then
                        TBS_CRITICAL=`echo ${TBS_CRITICAL} ${TBS}:${REMAINING_DAYS}_days:${INCR_MB}Mb_per_days /`
                elif [[ "${REMAINING_DAYS}" -lt "$WARNING_THRESHOLD" ]]; then
                        TBS_WARNING=`echo ${TBS_WARNING} ${TBS}:${REMAINING_DAYS}_days:${INCR_MB}Mb_per_days /`
                else
                        TBS_OK=`echo ${TBS_OK} ${TBS}:${REMAINING_DAYS}_days:${INCR_MB}Mb_per_days /`
        fi
done

if [ ! -z "${TBS_CRITICAL}" ]
then
        echo "CRITICAL - Tablespace remaining days: ${TBS_CRITICAL} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${TBS_WARNING}" ]
                        then
                                echo "OK - Tablespace remaining days ok according to threshold |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Tablespace remaining days: ${TBS_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
            fi
fi
}
fct_check_db_alertlog(){
export ORACLE_HOME=`cat /etc/oratab | grep dbhome | cut -d ":" -f2 | grep -v "#" | head -1`
export PATH=${ORACLE_HOME}/bin:${PATH}
export CHECK_ERROR=0
for adrci_home in `adrci exec="show homes" | grep -e rdbms`;
        do
        CHECK_ERROR=($(adrci exec="set home ${adrci_home}; show alert -p \\\"message_text like '%ORA-%' and originating_timestamp > systimestamp-1/24\\\"" -term | egrep -i "ora-0600|ora-04030|ora-04031|ora-07445|ora-01555|ora-16038|ora-01652|ora-28311" | cut -d ":" -f1 | sort -u | wc -l))
        if [[ "$CHECK_ERROR" -ne "0" ]]; then
                export GET_ALERT=($(adrci exec="set home ${adrci_home}; show alert -p \\\"message_text like '%ORA-%' and originating_timestamp > systimestamp-1/24\\\"" -term | egrep -i "ora-0600|ora-04030|ora-04031|ora-07445|ora-01555|ora-16038|ora-01652|ora-28311" | cut -d ":" -f1 | sort -u |tr '\n' '/'))
                export ALERT_FOUND=`echo ${ALERT_FOUND} ${adrci_home}:${GET_ALERT}`
        fi
done

CHECK_ALERT=`echo ${ALERT_FOUND} | grep -i "ora-" | wc -l`
if [[ "$CHECK_ALERT" -eq "0" ]]; then
        echo "OK - No ORA-% alert found on server"
        exit $STATE_OK
    else
        echo "WARNING - Some alerts found: ${ALERT_FOUND}"
        exit $STATE_WARNING
fi
}
fct_check_corruptedblock(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||count(BLOCKS) FROM v\\$database_block_corruption;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
if [[ "$USAGE" -ne 0 ]]; then
        echo "CRITICAL - corrupted block detected!"
        exit $STATE_CRITICAL
else
        echo "OK - no corrupted block detected"
        exit $STATE_OK
fi
}
fct_check_numberofdatafile(){
USAGE=`echo "set feedback off;
             set heading off;
             select 'VALUE'||ROUND(p.VALUE-count(f.NAME)) from V\\$PARAMETER p, V\\$DATAFILE f where p.NAME='db_files' group by p.value;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

USAGE2=`echo "set feedback off;
             set heading off;
             select 'VALUE'||ROUND(p.VALUE) from V\\$PARAMETER p where p.NAME='db_files';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -lt "$CRITICAL_THRESHOLD" ]]; then
        echo "CRITICAL - free db files ${USAGE} Free / ${USAGE2} Max |'db_files_free'=${USAGE};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD}; 'db_files_max'=${USAGE2};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL

elif [[ "$USAGE" -lt "$WARNING_THRESHOLD" ]]; then
        echo "WARNING - free db files ${USAGE} Free / ${USAGE2} Max |'db_files_free'=${USAGE};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD}; 'db_files_max'=${USAGE2};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
else
        echo "OK - free db files ${USAGE} Free / ${USAGE2} Max |'db_files_free'=${USAGE};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD}; 'db_files_max'=${USAGE2};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
fi
}
fct_check_backup_full(){
CHECK_ARCHIVELOG=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where LOG_MODE='ARCHIVELOG';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF ARCHIVELOG
              if [ `echo ${CHECK_ARCHIVELOG} | grep "OK" | wc -l` -eq 1 ]; then
                     USAGE=0
                     USAGE=`echo "set feedback off;
                                  set heading off;
                                  SELECT 'VALUE'||sum(count(*))
                                  FROM v\\$backup_datafile b, v\\$tablespace ts, v\\$datafile f
                                  WHERE b.incremental_level = 0
                                  AND INCLUDED_IN_DATABASE_BACKUP='YES'
                                  AND f.file#=b.file#
                                  AND f.ts#=ts.ts#
                                  AND b.CHECKPOINT_TIME > SYSDATE -(${CRITICAL_THRESHOLD}/24)
                                  GROUP BY b.checkpoint_time
                                  ORDER BY 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -eq "0" ]]; then
        echo "CRITICAL - Last full backup date is oldest than ${CRITICAL_THRESHOLD} hours"
        exit $STATE_CRITICAL
else
        echo "OK - Last full backup date don't reach threshold"
        exit $STATE_OK
fi
else
        echo "OK - Database is in noarchivelog mode"
        exit $STATE_OK
fi
}
fct_check_backup_inc(){
CHECK_ARCHIVELOG=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where LOG_MODE='ARCHIVELOG';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF ARCHIVELOG
              if [ `echo ${CHECK_ARCHIVELOG} | grep "OK" | wc -l` -eq 1 ]; then
USAGE=`echo "set feedback off;
             set heading off;
             alter session set optimizer_mode=RULE;
             SELECT 'VALUE'||count(*) from v\\$rman_status
             where start_time > SYSDATE -(${CRITICAL_THRESHOLD}/24)
             and operation = 'BACKUP'
             and object_type = 'DB INCR'
             and status like 'COMPLETE%'
             order by start_time desc;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -eq "0" ]]; then
        echo "CRITICAL - Last incremental backup date is oldest than ${CRITICAL_THRESHOLD} hours"
        exit $STATE_CRITICAL
else
        echo "OK - Last incremental backup date don't reach threshold"
        exit $STATE_OK
fi
else
        echo "OK - Database is in noarchivelog mode"
        exit $STATE_OK
fi
}
fct_check_backup_arch(){
CHECK_ARCHIVELOG=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where LOG_MODE='ARCHIVELOG';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF ARCHIVELOG
              if [ `echo ${CHECK_ARCHIVELOG} | grep "OK" | wc -l` -eq 1 ]; then
USAGE=`echo "set feedback off;
             set heading off;
             alter session set optimizer_mode=RULE;
             SELECT 'VALUE'||count(*) from v\\$rman_status
             where start_time > SYSDATE -(${CRITICAL_THRESHOLD}/24)
             and operation = 'BACKUP'
             and object_type = 'ARCHIVELOG'
             and status like 'COMPLETE%'
             order by start_time desc;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [[ "$USAGE" -eq "0" ]]; then
        echo "CRITICAL - Last archivelog backup date is oldest than ${CRITICAL_THRESHOLD} hours"
        exit $STATE_CRITICAL
else
        echo "OK - Last archivelog backup date don't reach threshold"
        exit $STATE_OK
fi
else
        echo "OK - Database is in noarchivelog mode"
        exit $STATE_OK
fi
}
fct_check_invalidobjects(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No invalid objects"
                                exit $STATE_OK
              fi
#ELSE / IF NOT A STANDBY
                         USAGE1=`echo "set feedback off;
                                       set heading off;
                                       SELECT 'VALUE'||COUNT(*) FROM dba_objects WHERE status = 'INVALID' AND object_name NOT LIKE 'BIN$%' and OWNER in ('SYS','SYSTEM','SYSAUX','DBSNMP','XDB','MDSYS');" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

                         USAGE2=`echo "set feedback off;
                                       set heading off;
                                       SELECT 'VALUE'||COUNT(*) FROM dba_registry WHERE status not in ('VALID','OPTION OFF');" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

                         USAGE3=`echo "set feedback off;
                                       set heading off;
                                       SELECT 'VALUE'||COUNT(*) FROM
                                       (
                                        SELECT INDEX_OWNER,INDEX_NAME,STATUS FROM DBA_IND_PARTITIONS WHERE STATUS NOT IN ('VALID','N/A','USABLE')
                                        UNION ALL
                                        SELECT INDEX_OWNER,INDEX_NAME,STATUS FROM DBA_IND_SUBPARTITIONS WHERE STATUS NOT IN ('VALID','N/A','USABLE')
                                        UNION ALL
                                        SELECT OWNER, INDEX_NAME,STATUS FROM dba_indexes WHERE status <> 'VALID' AND status <> 'N/A'
                                       );" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

                        CHECK_VERSION=`echo "set feedback off;
                                             set heading off;
                                             select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

                                if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
                                CHECK_CONTAINER=`echo "set feedback off;
                                                       set heading off;
                                                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

                                                if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                                                                 export USAGE4=`echo "set feedback off;
                                                                                      set heading off;
                                                                                      select 'VALUE'||pdb.pdb_name||':'||count(reg.status) from cdb_registry reg, cdb_pdbs pdb where pdb.pdb_id = reg.con_id and reg.status not in ('VALID','OPTION OFF') group by pdb.pdb_name;
                                " | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/ //g'`
                                                                 export USAGE5=`echo "set feedback off;
                                                                                      set heading off;
                                                                                      SELECT 'VALUE'||pdb.pdb_name||':'||count(obj.status) FROM cdb_objects obj, cdb_pdbs pdb  where pdb.pdb_id = obj.con_id and obj.status = 'INVALID' AND obj.object_name NOT LIKE 'BIN$%' and obj.OWNER in ('SYS','SYSTEM','SYSAUX','DBSNMP','XDB','MDSYS') group by pdb.pdb_name;
                                " | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/ //g'`

                                                                 export USAGE6=`echo "set feedback off;
                                                                                      set heading off;
                                                                                      SELECT 'VALUE'||pdb_name||':'||NUM_INDEX FROM
                                                                                                 (
                                                                                                        SELECT pdb.pdb_name,count(*) as "NUM_INDEX" FROM CDB_IND_PARTITIONS idxpart,  cdb_pdbs pdb where pdb.pdb_id = idxpart.con_id and idxpart.STATUS NOT IN ('VALID','N/A','USABLE') and pdb.pdb_name not like '%CODS%' group by pdb.pdb_name
                                                                                                        UNION ALL
                                                                                                        SELECT pdb.pdb_name,count(*) as "NUM_INDEX"  FROM CDB_IND_SUBPARTITIONS idxsubpart,  cdb_pdbs pdb where pdb.pdb_id = idxsubpart.con_id and idxsubpart.STATUS NOT IN ('VALID','N/A','USABLE') and pdb.pdb_name not like '%CODS%' group by pdb.pdb_name
                                                                                                        UNION ALL
                                                                                                        SELECT pdb.pdb_name,count(*) as "NUM_INDEX"  FROM CDB_indexes idx,  cdb_pdbs pdb where pdb.pdb_id = idx.con_id and idx.status <> 'VALID' AND idx.status <> 'N/A' and pdb.pdb_name not like '%CODS%'  group by pdb.pdb_name
                                                                                                  );" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/ //g'`

                                                                if [ `echo ${USAGE5} | grep "VALUE" | wc -l` -eq 0 ]; then
                                                                                export PDB_OBJECTS=0
                                                                                export USAGE5=0
                                                                                else
                                                                                export PDB_OBJECTS=1
                                                                fi
                                                                if [ `echo ${USAGE4} | grep "VALUE" | wc -l` -eq 0 ]; then
                                                                                export PDB_REGISTRY=0
                                                                                export USAGE4=0
                                                                                else
                                                                                export PDB_REGISTRY=1
                                                                fi
                                                                if [ `echo ${USAGE6} | grep "VALUE" | wc -l` -eq 0 ]; then
                                                                                export PDB_INDEXES=0
                                                                                export USAGE6=0
                                                                                else
                                                                                export PDB_INDEXES=1
                                                                fi

if [[ "$PDB_OBJECTS" -ne 0 ]] || [[ "$PDB_REGISTRY" -ne 0 ]] || [[ "$PDB_INDEXES" -ne 0 ]]; then

export PDB_INVALIDS_STATUS="
SYS PDB_DBA_Objects:
`echo ${USAGE5} | sed 's/VALUE//g'`;

PDB_Registry:
`echo ${USAGE4} | sed 's/VALUE//g'`;

PDB_Indexes:
`echo ${USAGE6} | sed 's/VALUE//g'`"
fi
                                                fi
                                        else
                                                export PDB_INVALIDS_STATUS=""
                                                export PDB_INDEXES=0
                                                export PDB_REGISTRY=0
                                                export PDB_OBJECTS=0
                                fi

if [[ "$USAGE1" -ne 0 ]] || [[ "$USAGE2" -ne 0 ]] || [[ "$USAGE3" -ne 0 ]] || [[ "$PDB_OBJECTS" -ne 0 ]] || [[ "$PDB_REGISTRY" -ne 0 ]] || [[ "$PDB_INDEXES" -ne 0 ]]; then
echo "CRITICAL - some invalids objetcs detected! -
Container/NON Container:  SYS DBA_Objects:${USAGE1}; Registry: ${USAGE2}; Indexes:${USAGE3};
${PDB_INVALIDS_STATUS}"
                exit $STATE_CRITICAL
        else
                echo "OK - no invalids objects detected"
                exit $STATE_OK
fi
}
fct_check_asm_disk_state(){
CHECK_ASM_ORATAB=`cat /etc/oratab |grep "+ASM" | wc -l`
if [ ${CHECK_ASM_ORATAB} -ne 0 ] ; then
                export ORACLE_SID=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f1`
                export ORACLE_HOME=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f2`
                export PATH=${ORACLE_HOME}/bin:${PATH}
        else
                export ORACLE_SID=`ps -ef | grep pmon | grep "+ASM" | cut -d "_" -f3`
                if [ -d "/u01/app/18.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/18.0.0/grid"
                        export ORACLE_HOME
                        else
                        ORACLE_HOME="/u01/app/18.0.0.0/grid"
                        export ORACLE_HOME
                fi
                if [ -d "/u01/app/19.0.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/19.0.0.0/grid"
                        export ORACLE_HOME
                fi
fi

CHECK_ERROR=0
USAGE1=`echo "set feedback off;
             set heading off;
             select 'VALUE'||PATH||','||MODE_STATUS from v\\$asm_disk;" |  sqlplus -s / as sysasm | grep "VALUE" | sed 's/VALUE//g'`

for line in `echo $USAGE1`
do
        export DISK_PATH=`echo $line | cut -d "," -f1`
        export STATE=`echo $line | cut -d "," -f2`

        if [ `echo ${STATE} | grep "ONLINE" | wc -l` -ne 1 ]; then
                        export CHECK_ERROR=1
                        export MESSAGE=`echo "${MESSAGE} (${DISK_PATH}: ${STATE})"`
                else
                        export MESSAGE=`echo "${MESSAGE} (${DISK_PATH}: ${STATE})"`
        fi
done

if [ ${CHECK_ERROR} -eq 0 ]; then
     echo "OK -  All asm disks are ONLINE"
     exit $STATE_OK
else
     echo "CRITICAL - ASM Disk state: ${MESSAGE}"
     exit $STATE_CRITICAL
fi
}
fct_check_asm_disk_space(){
CHECK_ASM_ORATAB=`cat /etc/oratab |grep "+ASM" | wc -l`
if [ ${CHECK_ASM_ORATAB} -ne 0 ] ; then
                export ORACLE_SID=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f1`
                export ORACLE_HOME=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f2`
                export PATH=${ORACLE_HOME}/bin:${PATH}
        else
                export ORACLE_SID=`ps -ef | grep pmon | grep "+ASM" | cut -d "_" -f3`
                if [ -d "/u01/app/18.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/18.0.0/grid"
                        export ORACLE_HOME
                        else
                        ORACLE_HOME="/u01/app/18.0.0.0/grid"
                        export ORACLE_HOME
                fi
                if [ -d "/u01/app/19.0.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/19.0.0.0/grid"
                        export ORACLE_HOME
                fi
fi

USAGE1=`echo "set feedback off;
             set heading off;
             select 'VALUE'||NAME||':'||ROUND(TOTAL_MB/1024)||':'||ROUND((total_mb - free_mb)/1024)||':'||ROUND(USABLE_FILE_MB/1024) from v\\$asm_diskgroup;" |  sqlplus -s / as sysasm | grep "VALUE" | sed 's/VALUE//g'`

for line in `echo $USAGE1`
do
        export DISKGROUP=`echo $line | cut -d ":" -f1`
        export TOTALMB=`echo $line | cut -d ":" -f2`
        export USEDMB=`echo $line | cut -d ":" -f3`
        export FREEMB=`echo $line | cut -d ":" -f4`

        PERF=`echo ${PERF} \'${DISKGROUP}\'=${FREEMB}GB`

        if [[ "${FREEMB}" -lt "$CRITICAL_THRESHOLD" ]]; then
                       DISKGROUP_CRITICAL=`echo ${DISKGROUP_CRITICAL} ${DISKGROUP}:${FREEMB}GB Free /`
                elif [[ "${FREEMB}" -lt "$WARNING_THRESHOLD" ]]; then
                        DISKGROUP_WARNING=`echo ${DISKGROUP_WARNING} ${DISKGROUP}:${FREEMB}GB Free /`
                else
                        DISKGROUP_OK=`echo ${DISKGROUP_OK} ${DISKGROUP}:${FREEMB}GB Free /`
        fi
done


if [ ! -z "${DISKGROUP_CRITICAL}" ]
then
        echo "CRITICAL - Diskgroup usage critical: ${DISKGROUP_CRITICAL} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${DISKGROUP_WARNING}" ]
                        then
                                echo "OK - Diskgroup usage ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Diskgroup usage warning: ${DISKGROUP_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
}
fct_check_asm_instance_state(){
CHECK_ASM_ORATAB=`cat /etc/oratab |grep "+ASM" | wc -l`
if [ ${CHECK_ASM_ORATAB} -ne 0 ] ; then
                export ORACLE_SID=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f1`
                export ORACLE_HOME=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f2`
                export PATH=${ORACLE_HOME}/bin:${PATH}
        else
                export ORACLE_SID=`ps -ef | grep pmon | grep "+ASM" | cut -d "_" -f3`
                if [ -d "/u01/app/18.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/18.0.0/grid"
                        export ORACLE_HOME
                        else
                        ORACLE_HOME="/u01/app/18.0.0.0/grid"
                        export ORACLE_HOME
                fi
                if [ -d "/u01/app/19.0.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/19.0.0.0/grid"
                        export ORACLE_HOME
                fi
fi

USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$instance where status='STARTED';" | sqlplus -s / as sysasm`

if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
     echo "OK - ASM Instance started"
     exit $STATE_OK
else
     echo "CRITICAL - ASM Instance down"
     exit $STATE_CRITICAL
fi
}
fct_check_asm_alert_log(){
export CHECK_ERROR=0
for adrci_home in `adrci exec="show homes" | grep -e "+asm"`;
        do
        CHECK_ERROR=($(adrci exec="set home ${adrci_home}; show alert -p \\\"message_text like '%ORA-%' and originating_timestamp > systimestamp-1/24\\\"" -term | grep -i "ora-" | cut -d ":" -f1 | sort -u | wc -l))
        if [[ "$CHECK_ERROR" -ne "0" ]]; then
                export GET_ALERT=($(adrci exec="set home ${adrci_home}; show alert -p \\\"message_text like '%ORA-%' and originating_timestamp > systimestamp-1/24\\\"" -term | grep -i "ora-" | cut -d ":" -f1 | sort -u |tr '\n' '/'))
                export ALERT_FOUND=`echo ${ALERT_FOUND} ${adrci_home}:${GET_ALERT}`
        fi
done

CHECK_ALERT=`echo ${ALERT_FOUND} | grep -i "ora-" | wc -l`
if [[ "$CHECK_ALERT" -eq "0" ]]; then
        echo "OK - No ORA-% alert found on server"
        exit $STATE_OK
    else
        echo "WARNING - Some alerts found: ${ALERT_FOUND}"
        exit $STATE_WARNING
fi
}
fct_check_asm_diskgroup_state(){
CHECK_ASM_ORATAB=`cat /etc/oratab |grep "+ASM" | wc -l`
if [ ${CHECK_ASM_ORATAB} -ne 0 ] ; then
                export ORACLE_SID=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f1`
                export ORACLE_HOME=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f2`
                export PATH=${ORACLE_HOME}/bin:${PATH}
        else
                export ORACLE_SID=`ps -ef | grep pmon | grep "+ASM" | cut -d "_" -f3`
                if [ -d "/u01/app/18.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/18.0.0/grid"
                        export ORACLE_HOME
                else
                        ORACLE_HOME="/u01/app/18.0.0.0/grid"
                        export ORACLE_HOME
        fi
                if [ -d "/u01/app/19.0.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/19.0.0.0/grid"
                        export ORACLE_HOME
                fi
fi

CHECK_ERROR=0
USAGE1=`echo "set feedback off;
             set heading off;
             select 'VALUE'||NAME||':'||STATE||':'||OFFLINE_DISKS from v\\$asm_diskgroup;" |  sqlplus -s / as sysasm | grep "VALUE" | sed 's/VALUE//g'`

for line in `echo $USAGE1`
do
        export DISKGROUP=`echo $line | cut -d ":" -f1`
        export STATE=`echo $line | cut -d ":" -f2`
        export OFFLINE_DISKS=`echo $line | cut -d ":" -f3`

        if [ ${OFFLINE_DISKS} -ne 0 ]; then
                export CHECK_ERROR=1
                export MESSAGE=`echo "${MESSAGE} (${DISKGROUP} have ${OFFLINE_DISKS} offline disks)"`
        fi

        if [ `echo ${STATE} | grep "MOUNTED" | wc -l` -ne 1 ]; then
                        export CHECK_ERROR=1
                        export MESSAGE=`echo "${MESSAGE} (${DISKGROUP}: ${STATE})"`
                else
                        export MESSAGE=`echo "${MESSAGE} (${DISKGROUP}: ${STATE})"`
        fi
done

if [ ${CHECK_ERROR} -eq 0 ]; then
     echo "OK -  Diskgroup state: ${MESSAGE}"
     exit $STATE_OK
else
     echo "CRITICAL - Diskgroup state: ${MESSAGE}"
     exit $STATE_CRITICAL
fi
}
fct_check_asm_diskgroup_directory_size(){
CHECK_ASM_ORATAB=`cat /etc/oratab |grep "+ASM" | wc -l`
if [ ${CHECK_ASM_ORATAB} -ne 0 ] ; then
                export ORACLE_SID=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f1`
                export ORACLE_HOME=`cat /etc/oratab | grep "+ASM" | cut -d ":" -f2`
                export PATH=${ORACLE_HOME}/bin:${PATH}
        else
                export ORACLE_SID=`ps -ef | grep pmon | grep "+ASM" | cut -d "_" -f3`
                if [ -d "/u01/app/18.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/18.0.0/grid"
                        export ORACLE_HOME
                else
                        ORACLE_HOME="/u01/app/18.0.0.0/grid"
                        export ORACLE_HOME
        fi
                if [ -d "/u01/app/19.0.0.0/grid" ]; then
                        ORACLE_HOME="/u01/app/19.0.0.0/grid"
                        export ORACLE_HOME
                fi
fi
USAGE1=`echo "set feedback off;
              set heading off;
              select 'VALUE'||directory||':'||round(sum(allocated_mb)/1024) FROM (
                                                SELECT  d.name||'_'||rootname directory,space / 1048576 allocated_mb
                                                FROM (SELECT CONNECT_BY_ISLEAF, group_number, file_number, name,
                                                                        CONNECT_BY_ROOT name rootname, reference_index,
                                                                        parent_index
                                                                FROM v\\$asm_alias a
                                                        CONNECT BY PRIOR reference_index = parent_index) a
                                                JOIN (SELECT DISTINCT name
                                                                FROM v\\$asm_alias
                                                                WHERE parent_index = group_number * POWER(2, 24)) b
                                                                ON (a.rootname = b.name)
                                                JOIN v\\$asm_file f
                                                        ON (a.group_number = f.group_number
                                                                AND a.file_number = f.file_number)
                                                JOIN v\\$asm_diskgroup d
                                                        ON (f.group_number = d.group_number)
                                                WHERE a.CONNECT_BY_ISLEAF = 1)
                                                group by directory
                                                order by 1;" |  sqlplus -s / as sysasm | grep "VALUE" | sed 's/VALUE//g'`
for line in `echo $USAGE1`
do
        export DIRECTORY_NAME=`echo $line | cut -d ":" -f1`
        export DIRECTORY_SIZE=`echo $line | cut -d ":" -f2`
        export PERF=`echo "${PERF}'${DIRECTORY_NAME}'=${DIRECTORY_SIZE}GB "`
done

echo "OK - Monitoring space usage per ASM DATA directory |${PERF}"
exit $STATE_OK
}
fct_check_log_destination_state(){
USAGE=`echo "set feedback off;
             set heading off;
             select 'VALUE'||d.status from v\\$archive_dest d, v\\$instance i where destination is not null and i.version like '9%' and d.dest_name='LOG_ARCHIVE_DEST_1' and d.status ='VALID'
                         union
                         select 'VALUE'||d.status from v\\$archive_dest d, v\\$instance i where destination is not null and i.version like '1%' and d.dest_name='LOG_ARCHIVE_DEST_1' and d.status ='VALID';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [ `echo ${USAGE} | grep "VALID" | wc -l` -eq 0 ]; then
        echo "CRITICAL - NAS archivelog destination is active!"
        exit $STATE_CRITICAL
else
        echo "OK - Local archivelog destination is active"
        exit $STATE_OK
fi
}
fct_check_table_alertlog(){
CHECK_VERSION=`echo "set feedback off;
                set heading off;
                select 'OK' from v\\$version where banner like '%10.2%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
        echo "OK - 10G database detected - metric can't be monitor"
        exit $STATE_OK
fi

USAGE=`echo "set feedback off;
             set heading off;
             select originating_timestamp||':'||message_text "error"
             from sys.vw_x\\$dbgalertext
             where originating_timestamp > (sysdate - 2/24)
             and (message_text like '%ORA-%600%'
             OR message_text like '%ORA-04030%'
             OR message_text like '%ORA-%700%'
             OR message_text like '%ORA-04031%'
             OR message_text like '%ORA-07445%'
             OR message_text like '%ORA-01555%'
             OR message_text like '%ORA-16038%'
             OR message_text like '%ORA-01652%'
             OR message_text like '%ORA-21856%'
             OR message_text like '%ORA-28311%')
             AND message_text not like '%kzckmubuf%'
             AND message_text not like '%Patch Description%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${USAGE} | grep -i "ora-" | wc -l` -ne 0 ]; then
        echo "CRITICAL - Some alerts found: ${USAGE}"
        exit $STATE_CRITICAL
else
        echo "OK - No ORA-% alert found on database"
        exit $STATE_OK
fi
}
fct_check_archivelog_on(){
CHECK_ARCHIVELOG=`echo "set feedback off;
                        set heading off;
                        SELECT 'OK' from v\\$database where LOG_MODE='ARCHIVELOG';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_ARCHIVELOG} | grep "OK" | wc -l` -eq 1 ]; then
         if [ `echo ${WARNING_THRESHOLD} | grep "NOARCHIVELOG" | wc -l` -eq 1 ]; then
                echo "WARNING - Database is in archivelog mode!"
                exit $STATE_WARNING
           else
                echo "OK - Database is in archivelog mode"
                exit $STATE_OK
         fi
        else
          if [ `echo ${WARNING_THRESHOLD} | grep "NOARCHIVELOG" | wc -l` -eq 1 ]; then
                echo "OK - Database is in noarchivelog mode"
                exit $STATE_OK
            else
                echo "WARNING - Database is in noarchivelog mode!"
                exit $STATE_WARNING
          fi
fi
}
check_nas_archivelog_mounted(){
CHECK_VERSION=`echo "set feedback off;
                set heading off;
                select 'OK' from v\\$version where banner like '%10.2%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
        echo "OK - 10G database detected - metric can't be monitor"
        exit $STATE_OK
fi

CHECK_TABLE=`echo "set feedback off;
                set heading off;
                SELECT 'OK' from dba_objects where object_name='OPSVIEW_FILESYSTEM';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_TABLE} | grep "OK" | wc -l` -ne 1 ]; then
        echo "WARNING - External Table OPSVIEW_FILESYSTEM does not exist"
        exit $STATE_WARNING
     else
        USAGE=`echo "set feedback off;
                     set heading off;
                     SELECT MOUNT FROM DBA_TOOLS.OPSVIEW_FILESYSTEM WHERE MOUNT='/NAS_ARCHIVELOG';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep -v "SELECT" | grep -v "OPSVIEW"`
        if [ `echo ${USAGE} | grep "/NAS_ARCHIVELOG" | wc -l` -ne 1 ]; then
            echo "WARNING - NAS_ARCHIVELOG not mounted!"
            exit $STATE_WARNING
          else
            echo "OK - NAS_ARCHIVELOG mount on database server"
            exit $STATE_OK
        fi
fi
}
fct_check_fs_data(){
CHECK_VERSION=`echo "set feedback off;
                set heading off;
                select 'OK' from v\\$version where banner like '%10.2%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
        echo "OK - 10G database detected - metric can't be monitor"
        exit $STATE_OK
fi

CHECK_TABLE=`echo "set feedback off;
                set heading off;
                SELECT 'OK' from dba_objects where object_name='OPSVIEW_FILESYSTEM';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_TABLE} | grep "OK" | wc -l` -ne 1 ]; then
        echo "WARNING - External Table OPSVIEW_FILESYSTEM does not exist"
        exit $STATE_WARNING
     else
                ALIAS=`echo ${CON_TNS} | cut -d "/" -f 1 | cut -d ":" -f1 | sed 's/.bil.lu//g'`
                USAGE=`echo "set feedback off;
                             set heading off;
                             SELECT 'VALUE'||MOUNT||':'||ROUND(AVAILABLE) FROM DBA_TOOLS.OPSVIEW_FILESYSTEM WHERE MOUNT like '%${ALIAS}/%part%' and MOUNT not like '%archivelog%' and MOUNT not like '%redolog%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
for line in `echo $USAGE`
do
        export MOUNT=`echo $line | cut -d ":" -f1`
        export SIZE_FREE=`echo $line | cut -d ":" -f2`
        PERF=`echo ${PERF} \'${MOUNT}\'=${SIZE_FREE}GB`

        if [[ "${SIZE_FREE}" -lt "$CRITICAL_THRESHOLD" ]]; then
                        FS_CRITICAL=`echo "${FS_CRITICAL} ${line}GB Free /"`
                elif [[ "${SIZE_FREE}" -lt "$WARNING_THRESHOLD" ]]; then
                        FS_WARNING=`echo "${FS_WARNING} ${line}GB Free /"`
                else
                        FS_OK=`echo "${FS_OK} ${line}GB Free /"`
        fi
done

if [ ! -z "${FS_CRITICAL}" ]
then
        echo "CRITICAL - Filesystem freespace critical: ${FS_CRITICAL} ${FS_WARNING} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${FS_WARNING}" ]
                        then
                                echo "OK - Filesystem freespace ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Filesystem freespace warning: ${FS_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
fi
}
fct_check_fs_archivelog(){
CHECK_VERSION=`echo "set feedback off;
                set heading off;
                select 'OK' from v\\$version where banner like '%10.2%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
        echo "OK - 10G database detected - metric can't be monitor"
        exit $STATE_OK
fi

CHECK_TABLE=`echo "set feedback off;
                set heading off;
                SELECT 'OK' from dba_objects where object_name='OPSVIEW_FILESYSTEM';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_TABLE} | grep "OK" | wc -l` -ne 1 ]; then
        echo "WARNING - External Table OPSVIEW_FILESYSTEM does not exist"
        exit $STATE_WARNING
     else
                ALIAS=`echo ${CON_TNS} | cut -d "/" -f 1 | cut -d ":" -f1 | sed 's/.bil.lu//g'`
                USAGE=`echo "set feedback off;
                             set heading off;
                             SELECT 'VALUE'||MOUNT||':'||ROUND(AVAILABLE) FROM DBA_TOOLS.OPSVIEW_FILESYSTEM WHERE MOUNT like '%${ALIAS}/%part%' and MOUNT like '%archivelog%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
for line in `echo $USAGE`
do
        export MOUNT=`echo $line | cut -d ":" -f1`
        export SIZE_FREE=`echo $line | cut -d ":" -f2`
        PERF=`echo ${PERF} \'${MOUNT}\'=${SIZE_FREE}GB`

        if [[ "${SIZE_FREE}" -lt "$CRITICAL_THRESHOLD" ]]; then
                        FS_CRITICAL=`echo "${FS_CRITICAL} ${line}GB Free /"`
                elif [[ "${SIZE_FREE}" -lt "$WARNING_THRESHOLD" ]]; then
                        FS_WARNING=`echo "${FS_WARNING} ${line}GB Free /"`
                else
                        FS_OK=`echo "${FS_OK} ${line}GB Free /"`
        fi
done

if [ ! -z "${FS_CRITICAL}" ]
then
        echo "CRITICAL - Filesystem freespace critical: ${FS_CRITICAL} ${FS_WARNING} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${FS_WARNING}" ]
                        then
                                echo "OK - Filesystem freespace ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Filesystem freespace warning: ${FS_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
fi
}
fct_check_fs_home(){
CHECK_VERSION=`echo "set feedback off;
                set heading off;
                select 'OK' from v\\$version where banner like '%10.2%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
        echo "OK - 10G database detected - metric can't be monitor"
        exit $STATE_OK
fi

CHECK_TABLE=`echo "set feedback off;
                set heading off;
                SELECT 'OK' from dba_objects where object_name='OPSVIEW_FILESYSTEM';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_TABLE} | grep "OK" | wc -l` -ne 1 ]; then
        echo "WARNING - External Table OPSVIEW_FILESYSTEM does not exist"
        exit $STATE_WARNING
     else
                ALIAS=`echo ${CON_TNS} | cut -d "/" -f 1 | cut -d ":" -f1 | sed 's/.bil.lu//g'`
                USAGE=`echo "set feedback off;
                             set heading off;
                             SELECT 'VALUE'||MOUNT||':'||ROUND(AVAILABLE*1204) FROM DBA_TOOLS.OPSVIEW_FILESYSTEM WHERE MOUNT like '%${ALIAS}/ora%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
for line in `echo $USAGE`
do
        export MOUNT=`echo $line | cut -d ":" -f1`
        export SIZE_FREE=`echo $line | cut -d ":" -f2`
        PERF=`echo ${PERF} \'${MOUNT}\'=${SIZE_FREE}MB`

        if [[ "${SIZE_FREE}" -lt "$CRITICAL_THRESHOLD" ]]; then
                        FS_CRITICAL=`echo "${FS_CRITICAL} ${line}MB Free /"`
                elif [[ "${SIZE_FREE}" -lt "$WARNING_THRESHOLD" ]]; then
                        FS_WARNING=`echo "${FS_WARNING} ${line}MB Free /"`
                else
                        FS_OK=`echo "${FS_OK} ${line}MB Free /"`
        fi
done

if [ ! -z "${FS_CRITICAL}" ]
then
        echo "CRITICAL - Filesystem freespace critical: ${FS_CRITICAL} ${FS_WARNING} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${FS_WARNING}" ]
                        then
                                echo "OK - Filesystem freespace ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Filesystem freespace warning: ${FS_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
fi
}
fct_check_datafile_state(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of datafile state required"
                                exit $STATE_OK
                else

DATAFILE_STATE=`echo "set feedback off;
                      set heading off;
                      SELECT 'VALUE'||count(*) from v\\$datafile where status not in ('SYSTEM','ONLINE') UNION ALL select 'VALUE'||count(*) from v\\$tempfile where status <> 'ONLINE';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
for line in `echo $DATAFILE_STATE`
do
        if [ ${line} -ne 0 ]; then
                        DATAFILE_CRITICAL=`echo "NOK"`
                else
                        DATAFILE_OK=`echo "OK"`
        fi
done

if [ ! -z "${DATAFILE_CRITICAL}" ]
then
                        echo "CRITICAL - Some datafiles or tempfiles are not online / check view v\$datafile and v\$tempfile"
                        exit $STATE_CRITICAL
        else
                        echo "OK - No invalids state for datafiles or tempfiles detected"
                        exit $STATE_OK
fi
fi
}
fct_check_account_config_state(){
##CHECK ENV
ENV_FIRST_CHAR=`echo ${CON_TNS} | cut -d "/" -f2  | head -c 1`
ENV_LAST_CHAR=`echo ${CON_TNS} |  awk '{print substr($0,length,1)}'`

if [ `echo ${ENV_FIRST_CHAR} | egrep "D|T|Q" | wc -l` -ne 0 ]; then
       echo "OK - Dev/Test environement detected - No monitoring of users state are required"
       exit $STATE_OK
fi

if [ `echo ${ENV_LAST_CHAR} | egrep "D|T|Q" | wc -l` -ne 0 ]; then
       echo "OK - Dev/Test environement detected - No monitoring of users state are required"
       exit $STATE_OK
fi


###
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of users state are required"
                                exit $STATE_OK
              fi
#CHECK CONTAINER
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                 export USAGE1=`echo "set feedback off;
                               set heading off;
                               select 'VALUE'||pdb.PDB_NAME||':'||usr.USERNAME||':'||usr.PROFILE||':'||usr.ACCOUNT_STATUS from cdb_users usr, cdb_pdbs pdb where pdb.pdb_id=usr.con_id and usr.oracle_maintained = 'N' and usr.username not like 'C##%' and usr.username not like 'AUDIT_MGMT' and usr.username not like 'ADMIN_PDB%' and NOT REGEXP_LIKE(usr.USERNAME,'^tech_[e|x|cn]|^tt16f|^prd_iku_[e|x]|^dataiku_|^dba_|^opr_|^di|^e|^x|^qn|^cr|^qr|^kr|^wq|^cpg|^[rdo_[e|x]]|^prd_[e|x]','i') and (usr.profile !='SERVICE_PROFILE' or ACCOUNT_STATUS <> 'OPEN') and usr.username not like 'RDO%' and usr.username not like 'CN%' and usr.username not in ('SYSTEMDBA','DDIPS','DBA_TOOLBOX','DBA_TOOLS','DBMSOEM','DBASECU','DBAREPORT','DVF','ORDS_METADATA','ORDS_PUBLIC_USER','DBSNMP','FLOWS_FILES','AUDSYS','APPQOSSYS','DVSYS','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYSBACKUP','SYSDG','SYSKM','WMSYS','XS$NULL','MDDATA','OJVMSYS','ORDDATA','OLAPSYS','SYS','SYSTEM','OUTLN','ANONYMOUS','AWR_STAGE','CSMIG','CTXSYS','DIP','DMSYS','DSSYS','EXFSYS','LBACSYS','MDSYS','ORACLE_OCM','ORDPLUGINS','ORDSYS','PERFSTAT','TRACESVR','TSMSYS','XDB','SYSMAN','MGMT_VIEW','SQLTXADMIN','SQLTXPLAIN','VPCBIL','SYSADMIN','SYSMONITOR','DBAREPORT','DBASECU','DBMSOEM','OWBSYS','OWBSYS_AUDIT','CLOUD_ENGINE_USER','CLOUD_SWLIB_USER','SYSMAN_RO','RASADM') union all select 'VALUE'||pdb.PDB_NAME||':'||usr.NAME||':'||usr.PROFILE||':'||usr.ACCOUNT_STATUS from cdb_xs_users usr, cdb_pdbs pdb where pdb.pdb_id=usr.con_id and usr.name like 'APPL%' and (usr.profile !='SERVICE_PROFILE' or usr.ACCOUNT_STATUS <> 'OPEN') union all select 'VALUE'||pdb.PDB_NAME||':'||usr.username||':'||usr.PROFILE||':'||usr.ACCOUNT_STATUS from cdb_users usr, cdb_pdbs pdb where pdb.pdb_id=usr.con_id and usr.username in ('SYSTEMDBA') and usr.ACCOUNT_STATUS = 'OPEN' order by 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g' | sed 's/EXPIRED & LOCKED/EXPIRED_AND_LOCKED/g' | sed 's/ //g'`
                else
                 export USAGE1=`echo "set feedback off;
                               set heading off;
                               select 'VALUE'||inst.instance_name||':'||usr.USERNAME||':'||usr.PROFILE||':'||usr.ACCOUNT_STATUS from cdb_users usr, v\\$instance inst where usr.oracle_maintained = 'N' and usr.username not like 'C##%' and usr.username not like 'AUDIT_MGMT' and usr.username not like 'ADMIN_PDB%' and NOT REGEXP_LIKE(usr.USERNAME,'^tech_[e|x|cn]|^tt16f|^prd_iku_[e|x]|^dataiku_|^dba_|^opr_|^di|^e|^x|^qn|^cr|^qr|^kr|^wq|^cpg|^[rdo_[e|x]]|^prd_[e|x]','i') and (usr.profile !='SERVICE_PROFILE' or ACCOUNT_STATUS <> 'OPEN') and usr.username not like 'RDO%' and usr.username not like 'CN%' and usr.username not in ('DDIPS','DBA_TOOLBOX','DBA_TOOLS','DBMSOEM','DBASECU','DBAREPORT','DVF','ORDS_METADATA','ORDS_PUBLIC_USER','DBSNMP','FLOWS_FILES','AUDSYS','APPQOSSYS','DVSYS','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYSBACKUP','SYSDG','SYSKM','WMSYS','XS$NULL','MDDATA','OJVMSYS','ORDDATA','OLAPSYS','SYS','SYSTEM','OUTLN','ANONYMOUS','AWR_STAGE','CSMIG','CTXSYS','DIP','DMSYS','DSSYS','EXFSYS','LBACSYS','MDSYS','ORACLE_OCM','ORDPLUGINS','ORDSYS','PERFSTAT','TRACESVR','TSMSYS','XDB','SYSMAN','MGMT_VIEW','SQLTXADMIN','SQLTXPLAIN','VPCBIL','SYSADMIN','SYSMONITOR','DBAREPORT','DBASECU','DBMSOEM','OWBSYS','OWBSYS_AUDIT','CLOUD_ENGINE_USER','CLOUD_SWLIB_USER','SYSMAN_RO') order by 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g' | sed 's/EXPIRED & LOCKED/EXPIRED_AND_LOCKED/g' | sed 's/ //g'`
        fi
else
        export USAGE1=`echo "set feedback off;
                              set heading off;
                              select 'VALUE'||inst.instance_name||':'||usr.USERNAME||':'||usr.PROFILE||':'||usr.ACCOUNT_STATUS from dba_users usr, v\\$instance inst where usr.username not in ('DDIPS','DBA_TOOLBOX','DBA_TOOLS','DBMSOEM','DBASECU','DBAREPORT','DVF','ORDS_METADATA','ORDS_PUBLIC_USER','DBSNMP','FLOWS_FILES','AUDSYS','APPQOSSYS','DVSYS','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYSBACKUP','SYSDG','SYSKM','WMSYS','XS$NULL','MDDATA','OJVMSYS','ORDDATA','OLAPSYS','SYS','SYSTEM','OUTLN','ANONYMOUS','AWR_STAGE','CSMIG','CTXSYS','DIP','DMSYS','DSSYS','EXFSYS','LBACSYS','MDSYS','ORACLE_OCM','ORDPLUGINS','ORDSYS','PERFSTAT','TRACESVR','TSMSYS','XDB','SYSMAN','MGMT_VIEW','SQLTXADMIN','SQLTXPLAIN','VPCBIL','SYSADMIN','SYSMONITOR','DBAREPORT','DBASECU','DBMSOEM','OWBSYS','OWBSYS_AUDIT','CLOUD_ENGINE_USER','CLOUD_SWLIB_USER','SYSMAN_RO') and NOT REGEXP_LIKE(usr.USERNAME,'^tech_[e|x|cn]|^tt16f|^prd_iku_[e|x]|^dataiku_|^dba_|^opr_|^di|^e|^x|^qn|^cr|^qr|^kr|^wq|^cpg|^[rdo_[e|x]]|^prd_[e|x]','i') and (usr.profile !='SERVICE_PROFILE' or ACCOUNT_STATUS <> 'OPEN') and usr.username not like 'RDO%' and usr.username not like 'CN%' and usr.username not like '%ROVIEW%' and usr.username not like 'AUDIT_MGMT' order by 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g' | sed 's/EXPIRED & LOCKED/EXPIRED_AND_LOCKED/g' | sed 's/ //g'`
fi

for line in `echo $USAGE1`
do
        export DB_NAME=`echo $line | cut -d ":" -f1`
        export USERNAME=`echo $line | cut -d ":" -f2`
        export PROFILE=`echo $line | cut -d ":" -f3`
        export ACCOUNT_STATUS=`echo $line | cut -d ":" -f4`
        export MESSAGE=`echo "${MESSAGE} :: ${DB_NAME}/USER:${USERNAME}/PROFILE:${PROFILE}/STATE:${ACCOUNT_STATUS}"`
done

if [ ! -z "${MESSAGE}" ]
then
        echo "WARNING - Check configuration for users:"
        echo "${MESSAGE}"
        exit $STATE_WARNING
     else
        echo "OK - No invalid users configuration detected"
        exit $STATE_OK
fi
}
fct_check_restore_point_date(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||NAME||':'||to_char(TIME,'YYYY-MM-DD') FROM v\\$restore_point WHERE TIME < SYSDATE-(${WARNING_THRESHOLD}/24) and GUARANTEE_FLASHBACK_DATABASE='YES';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

for line in `echo $USAGE`
do
        export RESTOREPOINT_NAME=`echo $line | cut -d ":" -f1`
        export DATE_RESTOREPOINT=`echo $line | cut -d ":" -f2`
        export MESSAGE=`echo "${MESSAGE} ${RESTOREPOINT_NAME}: ${DATE_RESTOREPOINT} // "`
done

if [ ! -z "${MESSAGE}" ]
      then
        echo "WARNING - Restore point older than ${WARNING_THRESHOLD} hours detected:"
        echo "${MESSAGE}"
        exit $STATE_WARNING
else
        echo "OK - No Restore point guarantee older than ${WARNING_THRESHOLD} hours"
        exit $STATE_OK
fi
}
fct_check_db_cpu_usage(){
for dbname in `ps -ef|grep pmon|awk '{print $8}'|grep -v grep|grep pmon|sed s/ora_pmon_// | grep -v "+ASM" | grep -v APX`
      do
        CPU_USAGE=`ps -eo pcpu,args|grep -i ${dbname}|awk '{ sum+=$1} END {print sum}'`
        PERF=`echo ${PERF} \'${dbname}\'=${CPU_USAGE}s`
done

echo "OK - Check CPU usage per databases | $PERF"
exit $STATE_OK
}
fct_check_fs_from_db(){
CHECK_VERSION=`echo "set feedback off;
                set heading off;
                select 'OK' from v\\$version where banner like '%10.2%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
        echo "OK - 10G database detected - metric can't be monitor"
        exit $STATE_OK
fi

####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
fi

CHECK_TABLE=`echo "set feedback off;
                set heading off;
                SELECT 'OK' from dba_objects where object_name='OPSVIEW_FILESYSTEM';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
if [ `echo ${CHECK_TABLE} | grep "OK" | wc -l` -ne 1 ]; then
        echo "WARNING - External Table OPSVIEW_FILESYSTEM does not exist"
        exit $STATE_WARNING
     else
                ALIAS=`echo ${CON_TNS} | cut -d "/" -f 1 | cut -d ":" -f1 | sed 's/.bil.lu//g'`
                USAGE=`echo "set feedback off;
                             set heading off;
                             SELECT 'VALUE'||MOUNT||':'||ROUND(AVAILABLE*1204) FROM DBA_TOOLS.OPSVIEW_FILESYSTEM WHERE MOUNT like '%${FS_NAME}%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
for line in `echo $USAGE`
do
        export MOUNT=`echo $line | cut -d ":" -f1`
        export SIZE_FREE=`echo $line | cut -d ":" -f2`
        PERF=`echo ${PERF} \'${MOUNT}\'=${SIZE_FREE}MB`

        if [[ "${SIZE_FREE}" -lt "$CRITICAL_THRESHOLD" ]]; then
                        FS_CRITICAL=`echo "${FS_CRITICAL} ${line}MB Free /"`
                elif [[ "${SIZE_FREE}" -lt "$WARNING_THRESHOLD" ]]; then
                        FS_WARNING=`echo "${FS_WARNING} ${line}MB Free /"`
                else
                        FS_OK=`echo "${FS_OK} ${line}MB Free /"`
        fi
done

if [ ! -z "${FS_CRITICAL}" ]
then
        echo "CRITICAL - Filesystem freespace critical: ${FS_CRITICAL} ${FS_WARNING} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${FS_WARNING}" ]
                        then
                                echo "OK - Filesystem freespace ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Filesystem freespace warning: ${FS_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi
fi
}
fct_check_job_state(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY

              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
              fi

##IF PDB in parameter
if [ "${FS_NAME}" ]
then
      export CON_TNS=`echo ${CON_TNS} | cut -d "/" -f1`
      export CON_TNS=`echo ${CON_TNS}/${FS_NAME}`
fi

JOB_OWNER=`echo $WARNING_THRESHOLD | cut -d ":" -f1`
JOB_NAME=`echo $WARNING_THRESHOLD | cut -d ":" -f2`

USAGE=`echo "set feedback off;
             set heading off;
             alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
             SELECT 'VALUE'||STATE||':'||LAST_START_DATE FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME='${JOB_NAME}' AND OWNER='${JOB_OWNER}' and LAST_START_DATE > sysdate -1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [ `echo ${USAGE} | egrep -v "SCHEDULED|RUNNING|SUCCEEDED|COMPLETED" | wc -l` -ne 0 ]; then
          echo "WARNING - JOB $WARNING_THRESHOLD: ${USAGE}  - Check inside db with select STATE,LAST_START_DATE FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME='${JOB_NAME}' AND OWNER='${JOB_OWNER}';"
          exit $STATE_WARNING
        else
           echo "OK - JOB $WARNING_THRESHOLD: ${USAGE}"
           exit $STATE_OK
fi
}
fct_check_long_query(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
fi

USAGE=`echo "set feedback off;
             set heading off;
             select  'VALUE'||'Username:'||USERNAME||' Module:'||MODULE||' SID:'||SID||' SERIAL#:'||SESSION_SERIAL#||' SQLID:'||SQL_ID||' STARTUP_TIME:'||SQL_EXEC_START from V\\$SQL_MONITOR where status='EXECUTING' and SQL_EXEC_START < sysdate-${WARNING_THRESHOLD}/24 and lower(SQL_TEXT) not like '%server_dequeue%' and lower(SQL_TEXT) not like '%begin%main%';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [ `echo ${USAGE} | grep "Username:" | wc -l` -ne 0 ]; then
          echo "WARNING - Query running since more than ${WARNING_THRESHOLD} hours: ${USAGE}"
          exit $STATE_WARNING
        else
           echo "OK - No query running since ${WARNING_THRESHOLD} hours"
           exit $STATE_OK
fi
}
fct_check_lock_session(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
fi

CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `


if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi

#IF CONTAINER
if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
USAGE=`echo "set feedback off;
             set heading off;
             set linesize 999;
             set long 10000;
             SELECT 'VALUE'||'SID: '||pdbs.pdb_name||'@'||sess.BLOCKING_SESSION||' is block by SID:'||pdbs.pdb_name||'@'||sess.SID||' Serial:'||sess.SERIAL#||' Since '||sess.SECONDS_IN_WAIT||' Seconds'
                         FROM GV\\$SESSION sess, dba_pdbs pdbs
                         WHERE sess.con_id=pdbs.pdb_id
                         and sess.BLOCKING_SESSION_STATUS ='VALID'
                         and sess.SECONDS_IN_WAIT > 3600
                         UNION ALL
             SELECT 'VALUE'||'SID: CONTAINER_SESSION@'||sess.BLOCKING_SESSION||' is block by SID: CONTAINER_SESSION@'||sess.SID||' Serial:'||sess.SERIAL#||' Since '||sess.SECONDS_IN_WAIT||' Seconds'
                         FROM GV\\$SESSION sess
                         WHERE sess.BLOCKING_SESSION_STATUS ='VALID'
                         and sess.SECONDS_IN_WAIT > 3600
                         ORDER BY 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
else
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||'SID: '||BLOCKING_SESSION||' is block by SID:'||SID||' Serial:'||SERIAL#||' Since '||SECONDS_IN_WAIT||' Seconds' FROM GV\\$SESSION WHERE BLOCKING_SESSION_STATUS ='VALID' and SECONDS_IN_WAIT > ${WARNING_THRESHOLD} ORDER BY BLOCKING_SESSION;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
fi
if [ `echo ${USAGE} | grep "SID:" | wc -l` -ne 0 ]; then
          echo "WARNING - Session locked since more than ${WARNING_THRESHOLD} seconds:
${USAGE}"
          exit $STATE_WARNING
        else
           echo "OK - No locked session  reach thresholds ${WARNING_THRESHOLD} seconds"
           exit $STATE_OK
fi
}
fct_check_dg_gap(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 0 ]; then
                                echo "OK - Primary database detected - no check required"
                                exit $STATE_OK
fi

export CHECK_RESULT_DB=`echo "
set feedback off;
set heading off;
SET SERVEROUTPUT ON
DECLARE
    L_CNT_ROLE    NUMBER;
    L_CNT_ARCH_DIFF    NUMBER;
BEGIN
SELECT COUNT(*) INTO L_CNT_ROLE from V\\$DATABASE WHERE DATABASE_ROLE='PHYSICAL STANDBY';
IF (L_CNT_ROLE = 0)
THEN
    DBMS_OUTPUT.PUT_LINE('OK - DATABASE_ROLE: PRIMARY');
ELSE
SELECT SUM((ARCH.SEQUENCE# - APPL.SEQUENCE#)) INTO L_CNT_ARCH_DIFF
FROM
(SELECT THREAD# ,SEQUENCE# FROM V\\$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V\\$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
(SELECT THREAD# ,SEQUENCE# FROM V\\$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V\\$LOG_HISTORY GROUP BY THREAD#)) APPL
WHERE
ARCH.THREAD# = APPL.THREAD#
ORDER BY 1;
IF (L_CNT_ARCH_DIFF > 5)
  THEN
    DBMS_OUTPUT.PUT_LINE('- WARNING - DATABASE_ROLE: STANDBY '||L_CNT_ARCH_DIFF||' ARCHIVELOG DIFF');
   ELSE
    DBMS_OUTPUT.PUT_LINE('- OK - DATABASE_ROLE: STANDBY '||L_CNT_ARCH_DIFF||' ARCHIVELOG DIFF');
END IF;
END IF;
END;
/" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | egrep "DATABASE_ROLE" | sed 's/SQL>//g' | cut -d "-" -f2,3`

NB_DIFF_ARCH=`echo "set feedback off;
             set heading off;
             SELECT 'VALUE'||SUM((ARCH.SEQUENCE# - APPL.SEQUENCE#))
             FROM
                (SELECT THREAD# ,SEQUENCE# FROM V\\$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V\\$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
                (SELECT THREAD# ,SEQUENCE# FROM V\\$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V\\$LOG_HISTORY GROUP BY THREAD#)) APPL
             WHERE
             ARCH.THREAD# = APPL.THREAD#
             ORDER BY 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

if [ `echo ${CHECK_RESULT_DB} | grep "WARNING" | wc -l` -eq 1 ]; then
                echo "${CHECK_RESULT_DB} | 'archivelog_not_apply'=${NB_DIFF_ARCH}"
                exit $STATE_WARNING
                        else
                echo "${CHECK_RESULT_DB} | 'archivelog_not_apply'=${NB_DIFF_ARCH}"
                exit $STATE_OK
fi
}
fct_check_broker_state(){
BROKER_STATE=`echo "show configuration;" | dgmgrl ${USR_DB}/${PWD_DB}@${CON_TNS} | grep "SUCCESS" | sed 's/VALUE//g' | wc -l`

if [ ${BROKER_STATE} -eq 1 ]; then
                ## DATAGUARD BROKER OK
                echo "OK - Broker have SUCCESS State"
                exit 0
        else
                ## DATAGUARD BROKER CRITICAL
                echo "CRITICAL - DATABASE HAVE BROKER IN INVALID STATE `echo "show configuration;" | dgmgrl ${USR_DB}/${PWD_DB}@${CON_TNS}`"
                exit 2
fi
}
fct_check_broker_standby_enable(){
BROKER_STATE=`echo "show configuration;" | dgmgrl ${USR_DB}/${PWD_DB}@${CON_TNS} | grep -i "physical" | grep "disabled"| sed 's/VALUE//g' | wc -l`

if [ ${BROKER_STATE} -eq 0 ]; then
                ## DATAGUARD BROKER OK
                echo "OK - All standby are enable"
                exit 0
        else
                ## DATAGUARD BROKER CRITICAL
                echo "CRITICAL - Standby Database disabled detected `echo "show configuration;" | dgmgrl ${USR_DB}/${PWD_DB}@${CON_TNS}`"
                exit 2
fi
}
fct_check_query_result(){
QUERY=`echo ${QUERY} | sed 's/_dollar_/$/g'`
STANDBY=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${STANDBY} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of query required"
                                exit $STATE_OK
                else
USAGE=`echo "set feedback off;
             set heading off;
             ${QUERY};" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE_" | sed 's/VALUE_//g'`
if [ `echo ${USAGE} | grep "RESULT:0"| wc -l` -eq 0 ]; then
          echo "CRITCAL - Query return result <> 0: ${USAGE}"
          exit $STATE_CRITICAL
        else
           echo "OK - Query return 0"
           exit $STATE_OK
fi
fi
}
fct_check_pdb_open(){
#CHECK_DATAGUARD
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of pdbs needed"
                                exit $STATE_OK
              fi

###CHECK VERSION
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

##CHECK CONTAINER
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi

#IF CONTAINER
export TIME2=`date '+%y%m'`
if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
   export CHECK_PDBS_VIEW=`echo "desc dba_pdbs;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep REFRESH_MODE | wc -l`
        if [ `echo ${CHECK_PDBS_VIEW}` -ne 0 ]; then
                export CHECK_PDB_STATE=`echo "select count(*) from v\\$pdbs where (OPEN_MODE <> 'READ WRITE' or RESTRICTED <> 'NO') and NAME not like '%SEED%' and NAME not like 'PDBS_%' and NAME not like 'PDB%_T24CB%_BDWH' and NAME not in (select PDB_NAME from dba_pdbs where REFRESH_MODE <>'NONE') and NAME not like 'PDB%_${TIME2}%';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "0" | wc -l`
                else
                export CHECK_PDB_STATE=`echo "select count(*) from v\\$pdbs where (OPEN_MODE <> 'READ WRITE' or RESTRICTED <> 'NO') and NAME not like '%SEED%' and NAME not like 'PDBS_%' and NAME not like 'PDB%_T24CB%_BDWH' and NAME not like 'PDB%_${TIME2}%';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "0" | wc -l`
        fi
   if [ ${CHECK_PDB_STATE} -ne 1 ]; then
           export GET_PDB_NAME=`echo "set heading off;
                                      set pages 0;
                                      set feedback off;
                                      select NAME from v\\$pdbs where (OPEN_MODE <> 'READ WRITE' or RESTRICTED <> 'NO') and NAME not like '%SEED%' and NAME not like 'PDBS_%' and NAME not like 'PDB%_T24CB%_BDWH' and NAME not in (select PDB_NAME from dba_pdbs where REFRESH_MODE <>'NONE') and NAME not like 'PDB%_${TIME2}%';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `
                        PDB_ALERT=`echo ${GET_PDB_NAME}`
                        export STATE_CHECK=1
                else
                        export STATE_CHECK=0
   fi
        else
#ELSE NON CONTAINER
           echo "OK - Non Container detected - No monitoring of pdbs needed"
           exit $STATE_OK
fi

#RETURN PDB STATE
if [ ${STATE_CHECK} -eq 0 ]; then
                echo "OK - All pdbs are open"
                exit $STATE_OK
        else
                echo "CRITICAL - PDB not open or in restricted mode: ${PDB_ALERT}"
                exit $STATE_CRITICAL
fi
}
fct_check_pdb_save_state(){
#CHECK_DATAGUARD
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of pdbs needed"
                                exit $STATE_OK
              fi

###CHECK VERSION
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

##CHECK CONTAINER
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi

#IF CONTAINER
if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
   export CHECK_PDB_STATE=`echo "select COUNT(NAME) from v\\$pdbs where NAME not in (select a.name from v\\$pdbs a , dba_pdb_saved_states b where a.con_id = b.con_id and b.STATE = 'OPEN') and NAME not like '%SEED%' and NAME not like 'PDBS_%' and NAME not like 'PDB%_T24CB%_BDWH' and NAME not in (select PDB_NAME from dba_pdbs where REFRESH_MODE <>'NONE');" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "0" | wc -l`
   if [ ${CHECK_PDB_STATE} -ne 1 ]; then
                        export GET_PDB_NAME=`echo "set heading off;
                                               set pages 0;
                                               set feedback off;
                                               select NAME from v\\$pdbs where NAME not in (select a.name from v\\$pdbs a , dba_pdb_saved_states b where a.con_id = b.con_id and b.STATE = 'OPEN') and NAME not like '%SEED%' and NAME not like 'PDBS_%' and NAME not like 'PDB%_T24CB%_BDWH' and NAME not in (select PDB_NAME from dba_pdbs where REFRESH_MODE <>'NONE');" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `
                        PDB_ALERT=`echo ${GET_PDB_NAME}`
                        export STATE_CHECK=1
                else
                        export STATE_CHECK=0
   fi
        else
#ELSE NON CONTAINER
           echo "OK - Non Container detected - No monitoring of pdbs needed"
           exit $STATE_OK
fi

#RETURN PDB STATE
if [ ${STATE_CHECK} -eq 0 ]; then
                echo "OK - All pdbs have autostart configure"
                exit $STATE_OK
        else
                echo "WARNING - Autostart for some pdbs is not configure: ${PDB_ALERT}"
                exit $STATE_WARNING
fi
}
fct_check_orabasetab_exist(){
STATE_CHECK="0"
for file in `cat /etc/oratab  | grep ":N"  | cut -d ":" -f2 | grep -v "grid"i | sort -u`
do
if [ ! -f ${file}/install/orabasetab ]; then
    STATE_CHECK="1"
        ENGINE=`echo "${ENGINE}:${file}"`
fi
if [ ${STATE_CHECK} -eq 0 ]; then
                echo "OK - orabasetab exist on all oracle_home"
                exit $STATE_OK
        else
                echo "WARNING - orabasetab does not exist on homes: ${ENGINE}"
                exit $STATE_WARNING
fi
done
}
fct_check_database_grows(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `

#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of users state are required"
                                exit $STATE_OK
              fi
#CHECK CONTAINER
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
     export USAGE1=`echo "set feedback off;
                          set heading off;
                          select 'VALUE'||a.dbsize||':'||b.dbsize
from (select round(sum(bytes/1024/1024/1024)) as dbsize from cdb_data_files) a,
(select round(sum(TABLESPACE_USEDSIZE*tbs.BLOCK_SIZE)/1024/1024/1024)  as dbsize
from CDB_HIST_TBSPC_SPACE_USAGE hist, CDB_tablespaces tbs, v\\$tablespace systbs
where systbs.NAME = tbs.TABLESPACE_NAME
AND hist.TABLESPACE_ID = systbs.TS#
AND systbs.CON_ID = tbs.CON_ID
and hist.CON_ID = systbs.CON_ID
and hist.snap_id in (select max(SNAP_ID) from CDB_HIST_TBSPC_SPACE_USAGE)) b;
" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g' | sed 's/ //g'`

                        else
     export USAGE1=`echo "set feedback off;
                          set heading off;
                          select 'VALUE'||a.dbsize||':'||b.dbsize
from (select round(sum(bytes/1024/1024/1024)) as dbsize from dba_data_files) a,
(select round(sum(TABLESPACE_USEDSIZE*tbs.BLOCK_SIZE)/1024/1024/1024)  as dbsize
from DBA_HIST_TBSPC_SPACE_USAGE hist, dba_tablespaces tbs, v\\$tablespace systbs
where systbs.NAME = tbs.TABLESPACE_NAME
AND hist.TABLESPACE_ID = systbs.TS#
and hist.snap_id in (select max(SNAP_ID) from DBA_HIST_TBSPC_SPACE_USAGE)) b;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g' | sed 's/ //g'`

fi

export DB_SIZE=`echo $USAGE1 | cut -d ":" -f1`
export SEG_SIZE=`echo $USAGE1 | cut -d ":" -f2`

export PERF=`echo 'db_size'=${DB_SIZE}GB 'seg_size'=${SEG_SIZE}GB`

echo "OK - Database Usage: DBSize=${DB_SIZE}GB SegmentSize=${SEG_SIZE}GB |${PERF}"
exit $STATE_OK
}
fct_check_oratab(){
CHECK_ORATAB=`cat /etc/oratab  | grep ":" | grep "/u01" | egrep -v "MGMTDB|+ASM|PRD|INT|UAT|DEV|TST" | wc -l`
if [ ${CHECK_ORATAB} -eq 0 ]; then
                ## CHECK ORATAB OK
                echo "OK - All databases in oratab are correctly defined"
                exit 0
        else
                ## CHECK ORATAB WARNING
                echo "WARNING - Some database are not correctly defined : `cat /etc/oratab  | grep ":" | grep "/u01" | egrep -v "MGMTDB|+ASM|PRD|INT|UAT|DEV|TST"`"
                exit 1
fi
}
fct_check_oracle_queue(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of queue needed"
                                exit $STATE_OK
              fi
#CHECK CONTAINER
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        USAGE=`echo "set feedback off;
                                     set heading off;
                                     select 'VALUE'||sum(a.result) from (
                                     select count(*) as result FROM cdb_queue_schedules where schedule_disabled='Y'
                                     UNION ALL
                                     select count(*)  as result from cdb_queue_schedules where process_name is null
                                     and instance= (select instance_number from v\\$instance)) a;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

                        if [ `echo ${USAGE}` -ne 0 ]; then
                                echo "CRITICAL - Some Oracle queue are stop"
                                exit $STATE_CRITICAL
                        else
                                echo "OK - All Oracle queue running"
                                exit $STATE_OK
                        fi
                else
                   echo "OK - NON Container database detected - monitoring of queue disable"
                   exit $STATE_OK
        fi

     else
                                echo "OK - NON Container database detected - monitoring of queue disable"
                                exit $STATE_OK
fi
}

fct_check_connect_oud(){
export OUD_USER=`echo ${FS_NAME}`
export OUD_PASSWORD=`echo ${QUERY}`
export ERROR_DETECTED=0
export EXCLUDE_DB=`echo ${EXCLUDE}`

##CHECK EMPTY EXCLUSION
if [ -z "${EXCLUDE_DB}" ]
then
        EXCLUDE_DB="EMPTY_VARIABLE"
fi


#CHECK_DATAGUARD
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of OUD needed"
                                exit $STATE_OK
              fi

###CHECK VERSION
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from v\\$instance where substr(version,1,2) >= 18;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

#IF version < 18
              if [ `echo ${CHECK_VERSION} | grep -v "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Oracle Version underder 18c - No monitoring of OUD needed"
                                exit $STATE_OK
              fi

##EXCLUDE CONTAINER
CONTAINER_DB_TO_CHECK=`echo ${CON_TNS} | cut -d "/" -f2`

              if [ `echo ${EXCLUDE_DB} | grep ${CONTAINER_DB_TO_CHECK} | wc -l` -eq 1 ]; then
                                echo "OK - Oracle Container exclude - No monitoring of OUD needed"
                                exit $STATE_OK
              fi


##CHECK CONTAINER
if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi

#IF CONTAINER
if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
   export CHECK_PDB_LIST=`echo "set feedback off;
                                set heading off;
                                select name||';' from v\\$pdbs where name not like '%SEED' and open_mode like '%READ%WRITE%';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `
   export CHECK_PDB_LIST=`echo ${CHECK_PDB_LIST} | tr -d ";"`
   for pdb in ${CHECK_PDB_LIST}; do
                TNS_PDB=`echo ${CON_TNS} | cut -d "/" -f1`
                TNS_PDB=`echo ${TNS_PDB}/${pdb}`
                USER_CONNECTED=`echo "set pages 0;
                                      set feedback off;
                                      set heading off;
                                      select 'CHECK_OUD:'||user from dual;" | sqlplus ${OUD_USER}/${OUD_PASSWORD}@${TNS_PDB} | grep "CHECK_OUD" | cut -d ":" -f2`

                OUD_LDAP_USER_TRANSFORM=`echo ${OUD_USER} | cut -d "_" -f2`

                ##EXCLUDE PDB
                CONTAINER_DB_TO_CHECK=`echo ${CON_TNS} | cut -d "/" -f2`

                if [ `echo ${EXCLUDE_DB} | grep -i ${pdb} | wc -l` -eq 0 ]; then
                   if [ `echo ${USER_CONNECTED} | grep "${OUD_LDAP_USER_TRANSFORM}" | wc -l` -ne 1 ]; then
                        export PDB_ERROR_LIST=`echo ${pdb}:${PDB_ERROR_LIST}`
                        export ERROR_DETECTED=1
                   fi
                fi
   done

###CHECK CONTAINER
                USER_CONNECTED=`echo "set pages 0;
                                      set feedback off;
                                      set heading off;
                                      select 'CHECK_OUD:'||user from dual;" | sqlplus ${OUD_USER}/${OUD_PASSWORD}@${CON_TNS} | grep "CHECK_OUD" | cut -d ":" -f2`

                OUD_LDAP_USER_TRANSFORM=`echo ${OUD_USER} | cut -d "_" -f2`
                export CONTAINER_NAME=`echo ${CON_TNS} | cut -d "/" -f2`
                if [ `echo ${USER_CONNECTED} | grep "${OUD_LDAP_USER_TRANSFORM}" | wc -l` -ne 1 ]; then
                        export PDB_ERROR_LIST=`echo ${CONTAINER_NAME}:${PDB_ERROR_LIST}`
                        export ERROR_DETECTED=1
                fi

        else
#ELSE NON CONTAINER
                USER_CONNECTED=`echo "set pages 0;
                                      set feedback off;
                                      set heading off;
                                      select 'CHECK_OUD:'||user from dual;" | sqlplus ${OUD_USER}/${OUD_PASSWORD}@${CON_TNS} | grep "CHECK_OUD" | cut -d ":" -f2`

                OUD_LDAP_USER_TRANSFORM=`echo ${OUD_USER} | cut -d "_" -f2`
                export CONTAINER_NAME=`echo ${CON_TNS} | cut -d "/" -f2`
                if [ `echo ${USER_CONNECTED} | grep "${OUD_LDAP_USER_TRANSFORM}" | wc -l` -ne 1 ]; then
                        export PDB_ERROR_LIST=`echo ${CONTAINER_NAME}:${PDB_ERROR_LIST}`
                        export ERROR_DETECTED=1
                fi
fi

#RETURN PDB STATE
if [ ${ERROR_DETECTED} -eq 0 ]; then
                echo "OK - All PDB/Container are accessible with ${OUD_USER}"
                exit $STATE_OK
        else
                echo "CRITICAL - Some PDB/Container not accessible with user ${OUD_USER}: ${PDB_ERROR_LIST}"
                exit $STATE_CRITICAL
fi
}

fct_check_cpu_usage_pdb(){
STANDBY=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${STANDBY} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of query required"
                                exit $STATE_OK
              fi

DB=`echo ${CON_TNS} |cut -d "/" -f2`
USEDCPU="Getting CPU_USED per PDB| "
GET_CPU=`echo "
        set heading off;
        set pages 0;
        select
            LISTAGG(''''||NVL(p.name, 'CDB\\$ROOT') || '''='||rtrim(to_char(sum(tot.CPU_CONSUMED_TIME_ABS), 'FM99990.0999')) || '' , ' ')
            WITHIN GROUP (ORDER BY NVL(p.name, 'CDB\\$ROOT')) as CPU_CONSUMED
        FROM (
            SELECT ss.con_id
                  , round(AVG(ss.CPU_CONSUMED_TIME),2) AS CPU_CONSUMED_TIME
                  , round(AVG(ss.CPU_CONSUMED_TIME)/AVG(ss.INTSIZE_CSEC*10),2) AS CPU_CONSUMED_TIME_ABS
                  , round(AVG(ss.CPU_WAIT_TIME),2) AS CPU_WAIT_TIME
                  , round(AVG(ss.INTSIZE_CSEC*10),2) AS INTSIZE_CSEC --the default is in centi seconds (converted in milliseconds)
                  , round(AVG(ss.running_sessions_limit),2) as running_session_limit
                  , round(AVG(ss.avg_running_sessions),2) as avg_running_sessions
                  , round(AVG(ss.avg_waiting_sessions),2) as avg_waiting_sessions
                  , round(AVG(ss.avg_cpu_utilization),2) as avg_cpu_utilization
                  , to_char(min(ss.begin_time),'DD/MM/RRRR HH24:MI:SS') as min_time
                  , to_char(max(ss.begin_time),'DD/MM/RRRR HH24:MI:SS') as max_time
            FROM (
                SELECT rmh.con_id
                      , SUM(rmh.CPU_CONSUMED_TIME) as CPU_CONSUMED_TIME
                      , AVG(rmh.INTSIZE_CSEC) as INTSIZE_CSEC
                      , SUM(rmh.CPU_WAIT_TIME) as CPU_WAIT_TIME
                      , AVG(rmh.running_sessions_limit) as running_sessions_limit
                      , SUM(rmh.avg_running_sessions) as avg_running_sessions
                      , SUM(rmh.avg_waiting_sessions) as avg_waiting_sessions
                      , SUM(rmh.avg_cpu_utilization) as avg_cpu_utilization
                      , begin_time
                FROM V\\$RSRCMGRMETRIC_history rmh
                WHERE rmh.begin_time between (sysdate - 11/1440) and (sysdate - 1/1440)
                GROUP BY rmh.con_id, begin_time
            ) ss
            GROUP BY ss.con_id
        ) TOT
        left outer join v\\$pdbs p
        on p.con_id = tot.con_id
        group by p.name;
" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

USEDCPU+=" $GET_CPU"
echo $USEDCPU
}


fct_check_sequence_usage(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
         echo "OK - Physical Standby database detected - no check required"
         exit $STATE_OK
fi

CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `


if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi


###IF CONTAINER
if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
               USAGE1=`echo "set feedback off;
                             set heading off;
                             select 'VALUE'||pdbs.PDB_NAME||'_'||SEQUENCE_OWNER||'_'||SEQUENCE_NAME||'_'||round((LAST_NUMBER/MAX_VALUE)*100) as \"%USAGE\" from cdb_sequences seq, dba_pdbs pdbs where pdbs.con_id=seq.con_id and SEQUENCE_OWNER not in ('CTXSYS','DBA_DEPLOY','DBA_TOOLBOX','DBSNMP','DVSYS','GSMADMIN_INTERNAL','LBACSYS','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','SYS','SYSTEM','WMSYS','XDB','SYSMAN') and CYCLE_FLAG <>'Y' and (LAST_NUMBER/MAX_VALUE)*100 > ${WARNING_THRESHOLD};"| sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE"`
                else
####ELSE NON CONTAINER
                USAGE1=`echo "set feedback off;
                              set heading off;
                              select 'VALUE'||SEQUENCE_OWNER||'_'||SEQUENCE_NAME||'_'||round((LAST_NUMBER/MAX_VALUE)*100) as \"%USAGE\" from dba_sequences where SEQUENCE_OWNER not in ('CTXSYS','DBA_DEPLOY','DBA_TOOLBOX','DBSNMP','DVSYS','GSMADMIN_INTERNAL','LBACSYS','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','SYS','SYSTEM','WMSYS','XDB','SYSMAN') and CYCLE_FLAG <>'Y' and (LAST_NUMBER/MAX_VALUE)*100 > ${WARNING_THRESHOLD};" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE"`
fi

if [[ `echo ${USAGE1} | grep VALUE | wc -l ` -ne 0 ]]; then
        echo "WARNING - Some sequence reach usage limit ${WARNING_THRESHOLD}%: ${USAGE1}" | sed 's/VALUE//g'
        exit $STATE_WARNING
else
        echo "OK - no sequence reach usage limit ${WARNING_THRESHOLD}%"
        exit $STATE_OK
fi
}

fct_check_table_stats_locked(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
         echo "OK - Physical Standby database detected - no check required"
         exit $STATE_OK
fi

CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi

###IF CONTAINER
if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
               USAGE1=`echo "set feedback off;
                             set heading off;
                             select distinct 'VALUE'||b.pdb_name||','||a.owner||','||a.table_name||','||stattype_locked
                             from cdb_tab_statistics a, dba_pdbs b
                             where a.con_id=b.pdb_id
                             and a.stattype_locked is not null
                             and a.owner in (select username from cdb_users where profile='SERVICE_PROFILE' and username!='SYSMAN')
                             and a.table_name not like 'BIN$%'
                             order by 1;"| sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE"`
                else
####ELSE NON CONTAINER
                echo "OK - no container detected - database was exclude from monitoring"
                exit $STATE_OK
fi

if [[ `echo ${USAGE1} | grep VALUE | wc -l ` -ne 0 ]]; then
        echo "WARNING - Some tables with statistics locked detected:
${USAGE1}" | sed 's/VALUE//g'
        exit $STATE_WARNING
else
        echo "OK - All table have statistics enabled"
        exit $STATE_OK
fi
}

fct_check_singleton_service(){
####CHECK STANDBY DATABASE
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY

              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
              fi

USAGE=`echo "set feedback off;
             set heading off;
             select 'NOK:'||count(*),NAME from gv\\$active_services where lower(name) not like 'pdb%' group by name having count(*) > 1;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${USAGE} | grep "NOK:" | wc -l` -ne 0 ]; then
          echo "CRITICAL - SOME SERVICES RUNNING ON MULTIPLE NODES - PLEASE CHECK URGENTLY - APPLICATION DOES NOT SUPPORT MULTIPLE INSTANCE SERVICES"
          exit $STATE_CRITICAL
        else
           echo "OK - ALL Services running only on one cluster node"
           exit $STATE_OK
fi
}
fct_check_recyclebin_usage(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - No monitoring of tablespace required"
                                exit $STATE_OK
                else
#IF NOT A STANDBY CHECK VERSION
CHECK_VERSION=`echo "set feedback off;
                     set heading off;
                     select 'OK' from dba_objects where object_name='CDB_DATA_FILES' and object_type='VIEW';" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

if [ `echo ${CHECK_VERSION} | grep "OK" | wc -l` -eq 1 ]; then
CHECK_CONTAINER=`echo "set feedback off;
                       set heading off;
                       select distinct ('OK') from v\\$pdbs where CON_ID > 1;" | sqlplus -s ${USR_DB}/${PWD_DB}@${CON_TNS} `

        if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
                        CHECK_CONTAINER="OK"
                else
                        CHECK_CONTAINER="WRONG"
        fi
else
        CHECK_CONTAINER="WRONG"
fi


if [ `echo ${CHECK_CONTAINER} | grep "OK" | wc -l` -eq 1 ]; then
###IF CONTAINER
USAGE=`echo "set feedback off;
             set heading off;
             select 'VALUE'||round(sum(SPACE*8)/1024/1024) FROM cdb_recyclebin;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
                else
####ELSE NON CONTAINER
USAGE=`echo "set feedback off;
             set heading off;
             select 'VALUE'||round(sum(SPACE*8)/1024/1024) FROM dba_recyclebin;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`
fi

if [[ "$USAGE" -gt "$CRITICAL_THRESHOLD" ]]; then
        echo "CRITICAL - recyclebin usage reach threshold (check which pdb consume): ${USAGE} |'recyclebin_usage'=${USAGE};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_CRITICAL

elif [[ "$USAGE" -gt "$WARNING_THRESHOLD" ]]; then
        echo "WARNING - recyclebin usage reach threshold (check which pdb consume): ${USAGE} |'recyclebin_usage'=${USAGE};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_WARNING
else
        echo "OK - recyclebin usage under threshold: ${USAGE} |'recyclebin_usage'=${USAGE};${WARNING_THRESHOLD};${CRITICAL_THRESHOLD};"
        exit $STATE_OK
fi
fi
}

fct_check_dataguard_latency(){
USAGE=`echo "set feedback off;
             set heading off;
             SELECT 'OK' from v\\$database where DATABASE_ROLE='PHYSICAL STANDBY';" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS} `
#IF STANDBY
              if [ `echo ${USAGE} | grep "OK" | wc -l` -eq 1 ]; then
                                echo "OK - Physical Standby database detected - no check required"
                                exit $STATE_OK
fi

USAGE=`echo "set feedback off;
             set heading off;
             select 'VALUE'||a.max_value||':'||substr(b.avg_value,1,4)||':'||substr(c.avg_value,1,4) from
(select max(WAIT_TIME_MILLI) as max_value from gv\\$event_histogram where event = 'Redo Transport MISC' and to_timestamp(substr(LAST_UPDATE_TIME,1,17)) > sysdate-8/(24*60)) a,
(select sum(a.total_lantency)/sum(a.WAIT_COUNT) as avg_value from (
select WAIT_TIME_MILLI,WAIT_COUNT,sum(WAIT_TIME_MILLI*WAIT_COUNT) as total_lantency
from gv\\$event_histogram
where event = 'Redo Transport MISC'
and to_timestamp(substr(LAST_UPDATE_TIME,1,17)) > sysdate-8/(24*60)
group by WAIT_TIME_MILLI,WAIT_COUNT
order by WAIT_TIME_MILLI,WAIT_COUNT) a) b,
(select sum(a.total_lantency)/sum(a.WAIT_COUNT) as avg_value from (
select WAIT_TIME_MILLI,WAIT_COUNT,sum(WAIT_TIME_MILLI*WAIT_COUNT) as total_lantency
from DBA_HIST_EVENT_HISTOGRAM
where event_name = 'Redo Transport MISC'
and snap_id = (select max(snap_id) from dba_hist_snapshot)
group by WAIT_TIME_MILLI,WAIT_COUNT
order by WAIT_TIME_MILLI,WAIT_COUNT) a) c;" | sqlplus ${USR_DB}/${PWD_DB}@${CON_TNS}  | grep "VALUE" | sed 's/VALUE//g'`

                   MAX_VALUE=`echo ${USAGE} | cut -d ":" -f1`
                   AVG_STARTUP=`echo ${USAGE} | cut -d ":" -f2`
                   AVG_LAST_HOUR=`echo ${USAGE} | cut -d ":" -f3`
           echo "OK - Dataguard Latency: Last 5 minutes: ${MAX_VALUE}ms AVG Since Startup: ${AVG_STARTUP}ms AVG Last Hour: ${AVG_LAST_HOUR}ms | 'max_last_5_min'=${MAX_VALUE}ms 'avg_since_startup'=${AVG_STARTUP}ms 'avg_last_hour'=${AVG_LAST_HOUR}ms"
           exit $STATE_OK
}

case "${MODE}" in
        check_connect)
                fct_check_connect
                ;;
        check_connect_oud)
                fct_check_connect_oud
                ;;
        check_uptime)
                fct_main fct_check_uptime
                ;;
        check_process_usage)
                fct_main fct_check_process_usage
                ;;
        check_recyclebin_usage)
                fct_main fct_check_recyclebin_usage
                ;;
        check_session_usage)
                fct_main fct_check_session_usage
                ;;
        check_fast_recovery_usage)
                fct_main fct_check_fast_recovery_usage
                ;;
        check_pga_usage)
                fct_main fct_check_pga_usage
                ;;
        check_sga_usage)
                fct_main fct_check_sga_usage
                ;;
        check_tbs_freespace)
                fct_main fct_check_tbs_freespace
                ;;
        check_sequence_usage)
                fct_main fct_check_sequence_usage
                ;;
        check_remaining_day_tbs)
                fct_main fct_check_remaining_day_tbs
                ;;
        check_db_alertlog)
                fct_check_db_alertlog
                ;;
        check_corruptedblock)
                fct_main fct_check_corruptedblock
                ;;
        check_numberofdatafile)
                fct_main fct_check_numberofdatafile
                ;;
        check_backup_full)
                fct_main fct_check_backup_full
                ;;
        check_backup_inc)
                fct_main fct_check_backup_inc
                ;;
        check_backup_arch)
                fct_main fct_check_backup_arch
                ;;
        check_invalidobjects)
                fct_main fct_check_invalidobjects
                ;;
        check_asm_disk_state)
                fct_check_asm_disk_state
                ;;
        check_asm_disk_space)
                fct_check_asm_disk_space
                ;;
        check_asm_instance_state)
                fct_check_asm_instance_state
                ;;
        check_asm_alert_log)
                fct_check_asm_alert_log
                ;;
        check_asm_diskgroup_state)
                fct_check_asm_diskgroup_state
                ;;
        check_asm_diskgroup_directory_size)
                fct_check_asm_diskgroup_directory_size
                ;;
        check_log_destination_state)
                fct_main fct_check_log_destination_state
                ;;
        check_table_alertlog)
                fct_main fct_check_table_alertlog
                ;;
        check_archivelog_on)
                fct_main fct_check_archivelog_on
                ;;
        check_nas_archivelog_mounted)
                fct_main check_nas_archivelog_mounted
                ;;
        check_fs_data)
                fct_main fct_check_fs_data
                ;;
        check_fs_archivelog)
                fct_main fct_check_fs_archivelog
                ;;
        check_fs_home)
                fct_main fct_check_fs_home
                ;;
        check_datafile_state)
                fct_main fct_check_datafile_state
                ;;
        check_account_config_state)
                fct_main fct_check_account_config_state
                ;;
        check_restore_point_date)
                fct_main fct_check_restore_point_date
                ;;
        check_fs_from_db)
                fct_main fct_check_fs_from_db
                ;;
        check_job_state)
                fct_main fct_check_job_state
                ;;
        check_long_query)
                fct_main fct_check_long_query
                ;;
        check_lock_session)
                fct_main fct_check_lock_session
                ;;
        check_db_cpu_usage)
                fct_check_db_cpu_usage
                ;;
        check_dg_gap)
                fct_main fct_check_dg_gap
                ;;
        check_query_result)
                fct_main fct_check_query_result
                ;;
        check_broker_state)
                fct_main fct_check_broker_state
                ;;
        check_broker_standby_enable)
                fct_main fct_check_broker_standby_enable
                ;;
        check_pdb_open)
                fct_main fct_check_pdb_open
                ;;
        check_pdb_save_state)
                fct_main fct_check_pdb_save_state
                ;;
        check_orabasetab_exist)
                fct_check_orabasetab_exist
                ;;
        check_database_grows)
                fct_main fct_check_database_grows
                ;;
        check_oratab)
                fct_check_oratab
                ;;
        check_oracle_queue)
                fct_check_oracle_queue
                ;;
        check_table_stats_locked)
                fct_check_table_stats_locked
                ;;
        check_cpu_usage_pdb)
                fct_check_cpu_usage_pdb
                ;;
        check_singleton_service)
                fct_check_singleton_service
                ;;
        check_dataguard_latency)
                fct_check_dataguard_latency
                ;;
        *)
                echo Invalid Option $"Usage: "
                        echo "-m check_connect -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_connect_oud -t easy_connect_format -u USERNAME -p PASSWORD -f USERNAME_OUD -q PASSWORD_OUD -e EXCLUDE_DB"
                        echo "-m check_uptime -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_process_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_recyclebin_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (Go Used)"
                        echo "-m check_session_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_fast_recovery_usage -t easy_connect_format -u USERNAME --p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_pga_usage -t easy_connect_format -u USERNAME --p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_sga_usage -t easy_connect_format -u USERNAME --p PASSWORD -w WARNING -c CRITICAL (%Used)"
                        echo "-m check_tbs_freespace -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (GB Free)"
                        echo "-m check_sequence_usage -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (%USAGE)"
                        echo "-m check_remaining_day_tbs -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (number days before reach full)"
                        echo "-m check_numberofdatafile -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING -c CRITICAL (number of datafiles possible)"
                        echo "-m check_backup_full -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number hours since last backup)"
                        echo "-m check_backup_inc -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number hours since last backup)"
                        echo "-m check_backup_arch -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number hours since last backup)"
                        echo "-m check_invalidobjects -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_corruptedblock -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_dataguard_latency -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_oracle_queue -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_table_stats_locked -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_db_alertlog (only locally with oracle user)"
                        echo "-m check_db_cpu_usage (only locally with oracle user)"
                        echo "-m check_asm_disk_state (only locally with oracle user)"
                        echo "-m check_asm_disk_space -w WARNING -c CRITICAL (GB Free) (only locally with oracle user)"
                        echo "-m check_asm_instance_state (only locally with oracle user)"
                        echo "-m check_asm_alert_log (only locally with oracle user)"
                        echo "-m check_asm_diskgroup_state (only locally with oracle user)"
                        echo "-m check_asm_diskgroup_directory_size (only locally with oracle user)"
                        echo "-m check_archivelog_on -t easy_connect_format -u USERNAME -p PASSWORD -w {ARCHIVE/NOARCHIVELOG, default ARCHIVELOG}"
                        echo "-m check_datafile_state -t easy_connect_format -u USERNAME -p PASSWORD (Check that all datafiles and tempfile are online and available)"
                        echo "-m check_account_config_state -t easy_connect_format -u USERNAME -p PASSWORD (Check that all service account have service_profile and state is OPEN)"
                        echo "-m check_restore_point_date -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (number hours of restore point guarantee)"
                        echo "-m check_fs_from_db -t easy_connect_format -u USERNAME -p PASSWORD -f FS_NAME -c CRITICAL (number of MB Free)"
                        echo "-m check_job_state -t easy_connect_format -u USERNAME -p PASSWORD -w OWNER:JOB_NAME -f PDB_NAME"
                        echo "-m check_singleton_service -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_long_query -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (Number of hours)"
                        echo "-m check_lock_session -t easy_connect_format -u USERNAME -p PASSWORD -w WARNING (Number of seconds)"
                        echo "-m check_oratab"
                        #AIX Legacy
                        echo "-m check_table_alertlog -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_log_destination_state -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_nas_archivelog_mounted -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_fs_data -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number of GB Free)"
                        echo "-m check_fs_archivelog -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number of GB Free)"
                        echo "-m check_fs_home -t easy_connect_format -u USERNAME -p PASSWORD -c CRITICAL (number of MB Free)"
                        #Other Check
                        echo "-m check_dg_gap [-t easy_connect_format -u USERNAME -p PASSWORD] (Archivelog Diff warning if diff > 5)"
                        echo "-m check_query_result -t easy_connect_format -u USERNAME -p PASSWORD -q QUERY (Return Critical if result <> 0)"
                        echo "-m check_broker_state -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_broker_standby_enable -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_pdb_open -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_pdb_save_state -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_database_grows -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_cpu_usage_pdb  -t easy_connect_format -u USERNAME -p PASSWORD"
                        echo "-m check_orabasetab_exist"

            exit 1
esac
