-- =============================================================================
-- get_info_oracle_client_version — Versions des clients Oracle connectés
--
-- Exécution : sqlplus monitoring/<pass>@<tns_alias>
-- Session recommandée :
--   SET FEEDBACK OFF
--   SET HEADING OFF
--   SET PAGESIZE 0
--   SET LINESIZE 32767
--
-- Placeholder (remplacé dynamiquement par le script shell) :
--   <db_env> : environnement de la base (PROD, DEV, etc.)
--
-- Collecte uniquement sur les bases PRIMARY.
-- =============================================================================

SELECT dbs.name||','||(SELECT version FROM v$instance)||','||'<db_env>,'||
       NVL(pdbs.pdb_name,'NON_CONTAINER')||','||
       inf.CLIENT_VERSION||','||inf.CLIENT_DRIVER||','||
       sess.USERNAME||','||sess.MACHINE||','||sess.SERVICE_NAME||','||
       NVL(sess.FAILOVER_TYPE,'NONE')||','||NVL(sess.FAILOVER_METHOD,'NONE')
FROM   v$session_connect_info inf
JOIN   v$session sess ON inf.SID = sess.SID AND inf.SERIAL# = sess.SERIAL#
LEFT JOIN dba_pdbs pdbs ON pdbs.pdb_id = inf.CON_ID
CROSS JOIN v$database dbs
WHERE  inf.CLIENT_VERSION <> 'Unknown'
  AND  sess.TYPE = 'USER'
  AND  sess.USERNAME IS NOT NULL;
