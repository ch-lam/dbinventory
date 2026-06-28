#!/bin/bash
# =============================================================================
# get_info_oracle_lms — collecte LMS Oracle (Feature Usage Statistics)
# Utilise sql/oracle_lms.sql (script Oracle officiel).
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=get_info_oracle_common
source "${SCRIPT_DIR}/get_info_oracle_common"

init_temps lms
rm -f "${LIST_DIR}/error_db.lst"

while IFS=';' read -r db_env lic db; do
    [[ -z "${db:-}" ]] && continue
    log "Connexion : ${db} [${db_env}/${lic}]"

    status_raw=$(status_check "${db}") || { log_err "${db}"; continue; }
    status=$(printf '%s\n' "${status_raw}" | grep -E '^(PRIMARY|PHYSICAL)' | head -1)
    [[ -z "${status}" ]] && { log_err "${db}"; continue; }

    IFS=',' read -r db_role _ _ <<< "${status}"

    # LMS : primaire uniquement
    [[ "${db_role}" == *STANDBY* ]] && continue

    sql_run "${db}" <<SQL >> "${LIST_DIR}/lms_temp.csv"
@${SCRIPT_DIR}/sql/oracle_lms.sql
SQL

done < <(grep -v '^\s*#' "${LIST_FILE}" | grep -v '^\s*$' | sort -u)

finalize_lst "${LIST_DIR}/lms_temp.csv" "${LIST_DIR}/oracle_lms.csv"

report_errors "Oracle inventory (LMS): erreurs de connexion"
log "Terminé."
