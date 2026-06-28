#!/bin/bash
# =============================================================================
# load_info_mssql  –  Charge les fichiers .csv MSSQL dans Oracle via SQLcl
#
# Prérequis : SQLcl 22.x+  (commande : sql)
#
# Les fichiers .csv sont produits par get_info avec les colonnes dans l'ordre
# des tables Oracle (chargement positionnel, sans header).
# Format configuré une fois via SET LOADFORMAT ; commandes LOAD simples ensuite.
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Connexion Oracle ──────────────────────────────────────────────────────────
DBINVENTORY_USER="dbinventory"
DBINVENTORY_PASS="Tofu4567"
DBINVENTORY_DSN="oracledb01:1521/DBINVENTORY_PRD_ALL"
MAIL_TO="clam@clam.lu"

# ── Log ───────────────────────────────────────────────────────────────────────
LOG_DIR="${SCRIPT_DIR}/logs"
mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/load_mssql_$(date '+%Y%m%d_%H%M%S').log"

log() { printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*"; }

# Parse le log SQLcl et reporte les erreurs par fichier CSV.
# Utilise les lignes de synthèse SQLcl (WARNING / #INFO rows in error / ORA-).
# Retourne 1 si au moins une erreur détectée.
parse_load_log() {
    local log="$1"
    local current_csv="" rows_in_error="" ora_error="" files_in_error=0

    while IFS= read -r line; do
        case "${line}" in
            "-- LOADING: "*)
                current_csv="${line#-- LOADING: }"
                rows_in_error=""
                ora_error=""
                ;;
            "#INFO Number of rows in error: "*)
                rows_in_error="${line#*: }"
                ;;
            "#ERROR ORA-"*)
                [[ -z "${ora_error}" ]] && ora_error="${line#"#ERROR "}"
                ;;
            "WARNING: Processed with errors")
                log "  [ERREUR] ${current_csv} — ${rows_in_error} ligne(s) en erreur"
                [[ -n "${ora_error}" ]] && log "           ${ora_error}"
                (( files_in_error++ )) || true
                ;;
        esac
    done < "${log}"

    if [[ "${files_in_error}" -gt 0 ]]; then
        log "Total : ${files_in_error} fichier(s) en erreur — voir ${log}"
        return 1
    else
        log "Chargement OK — aucune erreur détectée."
    fi
}

# =============================================================================
# Session SQLcl unique : TRUNCATE + LOAD
# =============================================================================
log "Chargement des fichiers .csv MSSQL dans Oracle..."
log "Log : ${LOG_FILE}"

SQLCL_EXIT=0
sql -S "${DBINVENTORY_USER}/${DBINVENTORY_PASS}@${DBINVENTORY_DSN}" <<'SQLCL_SESSION' 2>&1 | tee "${LOG_FILE}" || SQLCL_EXIT="${PIPESTATUS[0]}"
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
SET FEEDBACK OFF
SET ECHO     OFF

ALTER SESSION SET NLS_DATE_FORMAT      = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF';

-- ===========================================================================
-- TRUNCATE des tables de staging  (DDL – auto-commit Oracle)
-- ===========================================================================
TRUNCATE TABLE mssql_hosts;
TRUNCATE TABLE mssql_databases;
TRUNCATE TABLE mssql_backup;
TRUNCATE TABLE mssql_files;
TRUNCATE TABLE mssql_logins;
TRUNCATE TABLE mssql_loginwoperm;
TRUNCATE TABLE mssql_users;
TRUNCATE TABLE mssql_validatelogin;
TRUNCATE TABLE mssql_security_auditlevel;
TRUNCATE TABLE mssql_security_configoptions;
TRUNCATE TABLE mssql_security_dbproperties;
TRUNCATE TABLE mssql_security_encryption;
TRUNCATE TABLE mssql_security_groups;
TRUNCATE TABLE mssql_security_guestconnect;
TRUNCATE TABLE mssql_security_logins;
TRUNCATE TABLE mssql_security_orphanedusers;
TRUNCATE TABLE mssql_security_publicpermission;
TRUNCATE TABLE mssql_security_registryinfo;
TRUNCATE TABLE mssql_security_sqlserveraudit;

-- ===========================================================================
-- SQLcl : configuration du format de chargement
-- ===========================================================================
SET LOADFORMAT CSV
SET LOADFORMAT COLUMN_NAMES OFF
SET LOADFORMAT DELIMITER ,
SET LOADFORMAT ENCLOSURES "
SET LOAD SCAN_ROWS 0
SET LOAD ERRORS UNLIMITED
SET LOAD BATCHES_PER_COMMIT 0
SET LOAD COMMIT OFF

-- ===========================================================================
-- MSSQL – Inventaire
-- ===========================================================================

PROMPT -- LOADING: lists/mssql_hosts.csv
LOAD mssql_hosts         lists/mssql_hosts.csv
PROMPT -- LOADING: lists/mssql_databases.csv
LOAD mssql_databases     lists/mssql_databases.csv
PROMPT -- LOADING: lists/mssql_files.csv
LOAD mssql_files         lists/mssql_files.csv
PROMPT -- LOADING: lists/mssql_logins.csv
LOAD mssql_logins        lists/mssql_logins.csv
PROMPT -- LOADING: lists/mssql_users.csv
LOAD mssql_users         lists/mssql_users.csv
PROMPT -- LOADING: lists/mssql_loginwoperm.csv
LOAD mssql_loginwoperm   lists/mssql_loginwoperm.csv
PROMPT -- LOADING: lists/mssql_validatelogin.csv
LOAD mssql_validatelogin lists/mssql_validatelogin.csv
PROMPT -- LOADING: lists/mssql_backup.csv
LOAD mssql_backup        lists/mssql_backup.csv

-- ===========================================================================
-- MSSQL – Sécurité
-- ===========================================================================

PROMPT -- LOADING: lists/mssql_security_auditlevel.csv
LOAD mssql_security_auditlevel       lists/mssql_security_auditlevel.csv
PROMPT -- LOADING: lists/mssql_security_configoptions.csv
LOAD mssql_security_configoptions    lists/mssql_security_configoptions.csv
PROMPT -- LOADING: lists/mssql_security_dbproperties.csv
LOAD mssql_security_dbproperties     lists/mssql_security_dbproperties.csv
PROMPT -- LOADING: lists/mssql_security_encryption.csv
LOAD mssql_security_encryption       lists/mssql_security_encryption.csv
PROMPT -- LOADING: lists/mssql_security_groups.csv
LOAD mssql_security_groups           lists/mssql_security_groups.csv
PROMPT -- LOADING: lists/mssql_security_guestconnect.csv
LOAD mssql_security_guestconnect     lists/mssql_security_guestconnect.csv
PROMPT -- LOADING: lists/mssql_security_logins.csv
LOAD mssql_security_logins           lists/mssql_security_logins.csv
PROMPT -- LOADING: lists/mssql_security_orphanedusers.csv
LOAD mssql_security_orphanedusers    lists/mssql_security_orphanedusers.csv
PROMPT -- LOADING: lists/mssql_security_publicpermission.csv
LOAD mssql_security_publicpermission lists/mssql_security_publicpermission.csv
PROMPT -- LOADING: lists/mssql_security_registryinfo.csv
LOAD mssql_security_registryinfo     lists/mssql_security_registryinfo.csv
PROMPT -- LOADING: lists/mssql_security_sqlserveraudit.csv
LOAD mssql_security_sqlserveraudit   lists/mssql_security_sqlserveraudit.csv

-- Commit final pour valider tous les chargements
COMMIT;
EXIT;
SQLCL_SESSION


# =============================================================================
# Analyse du log
# =============================================================================
log "Analyse du log de chargement..."

send_error_mail() {
    local subject="$1" body="$2"
    mailx -s "${subject}" "${MAIL_TO}" <<EOF
${body}

Log complet : ${LOG_FILE}
EOF
}

if [[ "${SQLCL_EXIT}" -ne 0 ]]; then
    log "SQLcl a terminé avec une erreur (code ${SQLCL_EXIT}) — voir ${LOG_FILE}"
    send_error_mail "dbInventory MSSQL — erreur SQLcl (code ${SQLCL_EXIT})" \
        "$(grep -E 'ORA-[0-9]+|Error report' "${LOG_FILE}" | head -20)"
    exit 1
fi

parse_load_log "${LOG_FILE}" || {
    send_error_mail "dbInventory MSSQL — erreurs de chargement" \
        "$(grep -E '^-- LOADING:|WARNING:|#INFO Number of rows in error' "${LOG_FILE}" | grep -A1 'WARNING')"
    exit 1
}

# =============================================================================
# Archivage des fichiers .csv MSSQL
# =============================================================================
DIR_TIME=$(date '+%y%m%d%H%M%S')
mkdir -p "lists/${DIR_TIME}"
cp lists/mssql*.csv "lists/${DIR_TIME}/"

log "Fichiers archivés dans lists/${DIR_TIME}/"
log "Chargement terminé."
