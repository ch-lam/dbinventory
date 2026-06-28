#!/bin/bash
# =============================================================================
# get_info_mssql_common — bibliothèque commune aux scripts de collecte MSSQL
# À sourcer, ne pas exécuter directement.
# =============================================================================

MONITORING_USER="monitoring"
MONITORING_PASS="HY9Xine38wnkC2gLadd2YafJiz5gRw"
MAIL_TO="sysadmin-mssql@chl.lu"   # à adapter : équipe en charge des serveurs Windows/MSSQL

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIST_DIR="${SCRIPT_DIR}/lists"
LIST_FILE="${SCRIPT_DIR}/mssql_database_lists.lst"
SQL_DIR="${SCRIPT_DIR}/sql"

# ── Helpers ───────────────────────────────────────────────────────────────────
log()     { printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*"; }
log_err() { log "ERROR: $*" >&2; printf '%s\n' "$*" >> "${LIST_DIR}/error_db.lst"; }

# Exécute un fichier SQL contre une instance MSSQL cible.
# Usage : sqlcmd_run "host,port" sql_file
sqlcmd_run() {
    local target="$1" sql_file="$2"
    sqlcmd -U "${MONITORING_USER}" -S "${target}" -P "${MONITORING_PASS}" -C \
           -i "${sql_file}" -h-1 -W -w 999 -s"," 2>/dev/null
}

# Vérifie la disponibilité d'une instance.
# Retourne 0 si accessible, non-zero sinon.
status_check() {
    local target="$1"
    sqlcmd -U "${MONITORING_USER}" -S "${target}" -P "${MONITORING_PASS}" -C \
           -Q "SET NOCOUNT ON; SELECT @@SERVERNAME;" -h-1 -W 2>/dev/null \
        | grep -qv '^\s*$'
}

# Trie, déduplique, filtre les artefacts sqlcmd, normalise les séparateurs de path.
# Usage : finalize_lst src_temp.csv dst.lst
finalize_lst() {
    local src="$1" dst="$2"
    [[ -f "${src}" ]] || return 0
    sort -u "${src}" \
        | grep -v '^\s*$' \
        | grep ',' \
        | grep -Ev '^\([0-9]+ rows? affected\)' \
        | grep -iv 'Sqlcmd:' \
        | grep -iv '^Changed database' \
        | sed 's/\\/\//g' \
        | sed 's/""//g' \
        > "${dst}" || true
    rm -f "${src}"
}

# Initialise (vide) les fichiers temporaires.
# Usage : init_temps tag1 tag2 ...  → crée ${LIST_DIR}/tag1_temp.csv …
init_temps() {
    mkdir -p "${LIST_DIR}"
    local f
    for f in "$@"; do : > "${LIST_DIR}/${f}_temp.csv"; done
}

# Envoie un email d'erreur et quitte avec code 1 si error_db.lst existe.
report_errors() {
    local subject="${1:-MSSQL inventory: erreurs de connexion}"
    if [[ -f "${LIST_DIR}/error_db.lst" ]]; then
        mailx -s "${subject}" "${MAIL_TO}" \
            < <(printf 'Collecte impossible pour :\n'; cat "${LIST_DIR}/error_db.lst")
        exit 1
    fi
}
