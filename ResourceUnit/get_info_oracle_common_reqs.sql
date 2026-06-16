-- =============================================================================
-- get_info_oracle_common — Requête de vérification du statut de la base
-- Exécution : sqlplus monitoring/<pass>@<tns_alias>
-- Retourne  : "<PRIMARY|PHYSICAL STANDBY>,<YES|NO>,<version_majeure>"
--             Ex. : PRIMARY,YES,19  |  PHYSICAL STANDBY,NO,12
-- =============================================================================

SELECT database_role || ',' || cdb || ',' || REGEXP_SUBSTR((SELECT version FROM v$instance), '^\d+')
FROM   v$database;
