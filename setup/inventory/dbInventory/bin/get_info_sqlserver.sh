#!/bin/bash
# =============================================================================
# get_info_sqlserver — collecte inventaire MSSQL (infra)
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=get_info_mssql_common
source "${SCRIPT_DIR}/get_info_mssql_common"

init_temps mssql_hosts mssql_databases mssql_backup mssql_files \
           mssql_logins mssql_users mssql_loginwoperm mssql_validatelogin
rm -f "${LIST_DIR}/error_db.lst"

# ── Collecte par instance ─────────────────────────────────────────────────────
while IFS=';' read -r env license server; do
    [[ -z "${server:-}" ]] && continue
    host="${server%%:*}"
    port="${server##*:}"
    target="${host},${port}"
    log "Connexion : ${target} [${env}/${license}]"

    status_check "${target}" || { log_err "${target}"; continue; }

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getinstanceinfo.sql" \
        | sed "s/$/,${env},${license}/" \
        >> "${LIST_DIR}/mssql_hosts_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getdbinfo.sql" \
        | sed "s/$/,${env}/" \
        >> "${LIST_DIR}/mssql_databases_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getbackupinfo.sql" \
        >> "${LIST_DIR}/mssql_backup_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getfileinfo.sql" \
        | sed "s/$/,${env}/" \
        >> "${LIST_DIR}/mssql_files_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getloginsinfo.sql" \
        >> "${LIST_DIR}/mssql_logins_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getuserinfo.sql" \
        >> "${LIST_DIR}/mssql_users_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_loginwithoutperm.sql" \
        >> "${LIST_DIR}/mssql_loginwoperm_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_validatelogin.sql" \
        >> "${LIST_DIR}/mssql_validatelogin_temp.csv" || log_err "${target}"

done < <(grep -v '^\s*#' "${LIST_FILE}" | grep -v '^\s*$' | sort -u)

# ── Finalisation ──────────────────────────────────────────────────────────────
log "Finalisation..."
finalize_lst "${LIST_DIR}/mssql_hosts_temp.csv"         "${LIST_DIR}/mssql_hosts.csv"
finalize_lst "${LIST_DIR}/mssql_databases_temp.csv"     "${LIST_DIR}/mssql_databases.csv"
finalize_lst "${LIST_DIR}/mssql_backup_temp.csv"        "${LIST_DIR}/mssql_backup.csv"
finalize_lst "${LIST_DIR}/mssql_files_temp.csv"         "${LIST_DIR}/mssql_files.csv"
finalize_lst "${LIST_DIR}/mssql_logins_temp.csv"        "${LIST_DIR}/mssql_logins.csv"
finalize_lst "${LIST_DIR}/mssql_users_temp.csv"         "${LIST_DIR}/mssql_users.csv"
finalize_lst "${LIST_DIR}/mssql_loginwoperm_temp.csv"   "${LIST_DIR}/mssql_loginwoperm.csv"
finalize_lst "${LIST_DIR}/mssql_validatelogin_temp.csv" "${LIST_DIR}/mssql_validatelogin.csv"

report_errors "MSSQL inventory (infra): erreurs de connexion"
log "Terminé."
