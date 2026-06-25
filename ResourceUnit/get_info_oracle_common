#!/bin/bash
# =============================================================================
# get_info_oracle_common — bibliothèque commune aux scripts de collecte Oracle
# À sourcer, ne pas exécuter directement.
# =============================================================================

# ── Environnement Oracle client ───────────────────────────────────────────────
# export ORACLE_HOME="${ORACLE_HOME:-/inventory/OracleClient/instantclient_23_9}"
# export TNS_ADMIN="${TNS_ADMIN:-${ORACLE_HOME}/network}"
# export LD_LIBRARY_PATH="${ORACLE_HOME}"
# export PATH="${PATH}:${ORACLE_HOME}"

MONITORING_USER="c##monitoring"
MONITORING_PASS="Monitoring:PwdToChange:000:001"
MAIL_TO="clam@clam.lu"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIST_DIR="${SCRIPT_DIR}/lists"
LIST_FILE="${SCRIPT_DIR}/oracle_database_lists.lst"

# ── Helpers ───────────────────────────────────────────────────────────────────
log()     { printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*"; }
err()     { log "ERROR: $*" >&2; }
log_err() { err "$*"; printf '%s\n' "$*" >> "${LIST_DIR}/error_db.lst"; }

# Exécute le SQL fourni sur stdin contre une base cible.
# Utiliser pour toutes les requêtes de collecte (WHENEVER SQLERROR CONTINUE).
sql_run() {
    local dsn="$1"
    {
        printf 'WHENEVER SQLERROR CONTINUE\n'
        printf 'SET ECHO OFF\nSET FEEDBACK OFF\nSET HEADING OFF\nSET PAGESIZE 0\n'
        printf 'SET LINESIZE 32767\nSET TRIMSPOOL ON\n'
        printf "ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';\n"
        cat
        printf '\nEXIT;\n'
    } | sqlplus -s "${MONITORING_USER}/${MONITORING_PASS}@${dsn}"
}

# Vérifie la disponibilité et retourne le statut de la base.
# Sortie : "PRIMARY,YES,19" ou "PHYSICAL STANDBY,NO,12"
# Retour non-zero si la base est inaccessible.
status_check() {
    sqlplus -s "${MONITORING_USER}/${MONITORING_PASS}@${1}" 2>/dev/null <<'EOF'
WHENEVER SQLERROR EXIT FAILURE
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0
SELECT database_role || ',' || cdb || ',' || REGEXP_SUBSTR((SELECT version FROM v$instance), '^\d+')
FROM   v$database;
EXIT;
EOF
}

# Trie, déduplique, filtre les artefacts sqlplus, supprime les lignes vides.
# Usage : finalize_lst src.tmp dst.lst
finalize_lst() {
    local src="$1" dst="$2"
    [[ -f "${src}" ]] || return 0
    sort -u "${src}" \
        | grep -v '^\s*$' \
        | grep ',' \
        | grep -Ev '^(SP2-|ORA-|ERROR )' \
        | grep -Ev '^\s+' \
        | grep -Eiv '\b(SELECT|FROM|WHERE|UNION|GROUP|ORDER|HAVING|JOIN)\b|\|\|' \
        | sed 's/""//g' \
        > "${dst}" || true
    rm -f "${src}"
}

# Initialise (vide) les fichiers temporaires listés.
# Usage : init_temps tag1 tag2 ...  → crée ${LIST_DIR}/tag1_temp.csv …
init_temps() {
    mkdir -p "${LIST_DIR}"
    local f
    for f in "$@"; do : > "${LIST_DIR}/${f}_temp.csv"; done
}

# Envoie un email d'erreur et quitte avec code 1 si error_db.lst existe.
report_errors() {
    local subject="${1:-Oracle inventory: erreurs de connexion}"
    if [[ -f "${LIST_DIR}/error_db.lst" ]]; then
        mailx -s "${subject}" "${MAIL_TO}" \
            < <(printf 'Collecte impossible pour :\n'; cat "${LIST_DIR}/error_db.lst")
        exit 1
    fi
}
