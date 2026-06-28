#!/bin/bash
# =============================================================================
# get_info_sqlserver_security — collecte sécurité MSSQL
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=get_info_mssql_common
source "${SCRIPT_DIR}/get_info_mssql_common"

init_temps mssql_security_auditlevel   mssql_security_configoptions \
           mssql_security_dbproperties mssql_security_encryption    \
           mssql_security_groups       mssql_security_guestconnect  \
           mssql_security_logins       mssql_security_orphanedusers \
           mssql_security_publicpermission mssql_security_registryinfo \
           mssql_security_sqlserveraudit
rm -f "${LIST_DIR}/error_db.lst"

# ── Collecte par instance ─────────────────────────────────────────────────────
while IFS=';' read -r env license server; do
    [[ -z "${server:-}" ]] && continue
    host="${server%%:*}"
    port="${server##*:}"
    target="${host},${port}"
    log "Connexion : ${target} [${env}/${license}]"

    status_check "${target}" || { log_err "${target}"; continue; }

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getconfigoptions.sql" \
        >> "${LIST_DIR}/mssql_security_configoptions_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getregistryinfo.sql" \
        | grep -v "The system cannot find the file specified" \
        | grep -v "introuvable" \
        >> "${LIST_DIR}/mssql_security_registryinfo_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getguestconnect.sql" \
        >> "${LIST_DIR}/mssql_security_guestconnect_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getorphanedusers.sql" \
        >> "${LIST_DIR}/mssql_security_orphanedusers_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getdbproperties.sql" \
        >> "${LIST_DIR}/mssql_security_dbproperties_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getpublicperm.sql" \
        >> "${LIST_DIR}/mssql_security_publicpermission_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getgroups.sql" \
        >> "${LIST_DIR}/mssql_security_groups_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getlogins.sql" \
        >> "${LIST_DIR}/mssql_security_logins_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getauditlevel.sql" \
        >> "${LIST_DIR}/mssql_security_auditlevel_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getsqlserveraudit.sql" \
        >> "${LIST_DIR}/mssql_security_sqlserveraudit_temp.csv" || log_err "${target}"

    sqlcmd_run "${target}" "${SQL_DIR}/mssql_getencryption.sql" \
        | grep -v "Invalid column" \
        | grep -v "Msg 207, Level 16" \
        >> "${LIST_DIR}/mssql_security_encryption_temp.csv" || log_err "${target}"

done < <(grep -v '^\s*#' "${LIST_FILE}" | grep -v '^\s*$' | sort -u)

# ── Finalisation ──────────────────────────────────────────────────────────────
log "Finalisation..."
finalize_lst "${LIST_DIR}/mssql_security_auditlevel_temp.csv"       "${LIST_DIR}/mssql_security_auditlevel.csv"
finalize_lst "${LIST_DIR}/mssql_security_configoptions_temp.csv"    "${LIST_DIR}/mssql_security_configoptions.csv"
finalize_lst "${LIST_DIR}/mssql_security_dbproperties_temp.csv"     "${LIST_DIR}/mssql_security_dbproperties.csv"
finalize_lst "${LIST_DIR}/mssql_security_encryption_temp.csv"       "${LIST_DIR}/mssql_security_encryption.csv"
finalize_lst "${LIST_DIR}/mssql_security_groups_temp.csv"           "${LIST_DIR}/mssql_security_groups.csv"
finalize_lst "${LIST_DIR}/mssql_security_guestconnect_temp.csv"     "${LIST_DIR}/mssql_security_guestconnect.csv"
finalize_lst "${LIST_DIR}/mssql_security_logins_temp.csv"           "${LIST_DIR}/mssql_security_logins.csv"
finalize_lst "${LIST_DIR}/mssql_security_orphanedusers_temp.csv"    "${LIST_DIR}/mssql_security_orphanedusers.csv"
finalize_lst "${LIST_DIR}/mssql_security_publicpermission_temp.csv" "${LIST_DIR}/mssql_security_publicpermission.csv"
finalize_lst "${LIST_DIR}/mssql_security_registryinfo_temp.csv"     "${LIST_DIR}/mssql_security_registryinfo.csv"
finalize_lst "${LIST_DIR}/mssql_security_sqlserveraudit_temp.csv"   "${LIST_DIR}/mssql_security_sqlserveraudit.csv"

report_errors "MSSQL inventory (sécurité): erreurs de connexion"
log "Terminé."
