#!/bin/bash
# =============================================================================
# get_info_oracle_client_version — collecte versions clients Oracle connectés
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=get_info_oracle_common
source "${SCRIPT_DIR}/get_info_oracle_common"

init_temps client_info
rm -f "${LIST_DIR}/error_db.lst"

while IFS=';' read -r db_env lic db; do
    [[ -z "${db:-}" ]] && continue
    log "Connexion : ${db} [${db_env}/${lic}]"

    status_raw=$(status_check "${db}") || { log_err "${db}"; continue; }
    status=$(printf '%s\n' "${status_raw}" | grep -E '^(PRIMARY|PHYSICAL)' | head -1)
    [[ -z "${status}" ]] && { log_err "${db}"; continue; }

    IFS=',' read -r db_role _ _ <<< "${status}"

    # Clients actifs : primaire uniquement
    [[ "${db_role}" == *STANDBY* ]] && continue

    # db_name et db_version extraits de la base cible (plus fiable que le fichier liste)
    sql_run "${db}" <<SQL >> "${LIST_DIR}/client_info_temp.csv"
SELECT '"'||dbs.name||'","'||(SELECT version FROM v\$instance)||'","${db_env}","'||
       NVL(pdbs.pdb_name,'NON_CONTAINER')||'","'||
       REPLACE(inf.CLIENT_VERSION,'"','')||'","'||REPLACE(inf.CLIENT_DRIVER,'"','')||'","'||
       REPLACE(sess.USERNAME,'"','')||'","'||REPLACE(sess.MACHINE,'"','')||'","'||
       REPLACE(sess.SERVICE_NAME,'"','')||'","'||
       NVL(sess.FAILOVER_TYPE,'NONE')||'","'||NVL(sess.FAILOVER_METHOD,'NONE')||'"'
FROM   v\$session_connect_info inf
JOIN   v\$session sess ON inf.SID = sess.SID AND inf.SERIAL# = sess.SERIAL#
LEFT JOIN dba_pdbs pdbs ON pdbs.pdb_id = inf.CON_ID
CROSS JOIN v\$database dbs
WHERE  inf.CLIENT_VERSION <> 'Unknown'
  AND  sess.TYPE = 'USER'
  AND  sess.USERNAME IS NOT NULL;
SQL

done < <(grep -v '^\s*#' "${LIST_FILE}" | grep -v '^\s*$' | sort -u)

finalize_lst "${LIST_DIR}/client_info_temp.csv" "${LIST_DIR}/oracle_client_version.csv"

report_errors "Oracle inventory (client version): erreurs de connexion"
log "Terminé."
