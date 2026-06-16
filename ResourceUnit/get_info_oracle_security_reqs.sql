-- =============================================================================
-- get_info_oracle_security — Requêtes SQL de collecte sécurité Oracle
--
-- Exécution : sqlplus monitoring/<pass>@<tns_alias>
-- Session recommandée :
--   SET FEEDBACK OFF
--   SET HEADING OFF
--   SET PAGESIZE 0
--   SET LINESIZE 32767
--   ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
--
-- Seules les bases PRIMARY sont collectées (pas les STANDBY).
-- =============================================================================


-- ── Paramètres et chiffrement réseau (toutes les bases) ───────────────────────

-- [sec_parameter] Paramètres de sécurité
SELECT dbs.NAME||','||prm.VALUE||','||prm.name FROM v$parameter prm, v$database dbs
WHERE  lower(prm.name) IN ('o7_dictionary_accessibility','sec_return_server_release_banner',
       'remote_os_authent','remote_os_roles','os_roles','audit_trail','audit_sys_operations',
       'sec_max_failed_login_attempts','sec_protocol_error_trace_action','resource_limit',
       'sec_case_sensitive_logon','sec_protocol_error_further_action','utl_file_dir','pdb_os_credential')
UNION ALL
SELECT dbs.NAME||','||prm.VALUE||','||prm.PARAMETER FROM v$option prm, v$database dbs
WHERE  prm.PARAMETER = 'Unified Auditing'
UNION ALL
SELECT dbs.NAME||',4,_sys_logon_delay' FROM v$database dbs
WHERE  EXISTS (SELECT 1 FROM v$parameter WHERE lower(name)='_sys_logon_delay' AND value='4')
UNION ALL
SELECT dbs.NAME||',0,_sys_logon_delay' FROM v$database dbs
WHERE  NOT EXISTS (SELECT 1 FROM v$parameter WHERE lower(name)='_sys_logon_delay' AND value='4');

-- [sec_network_enc] Chiffrement réseau de la session courante
SELECT dbs.NAME||','||NVL(REPLACE(sess.NETWORK_SERVICE_BANNER,' ','_'),'EMPTY')
FROM   v$database dbs, v$session_connect_info sess
WHERE  sess.SID = SYS_CONTEXT('USERENV','SID')
  AND  LOWER(sess.NETWORK_SERVICE_BANNER) LIKE '%encryption%service%adapter%';


-- ── Profils (CDB) ─────────────────────────────────────────────────────────────

-- [sec_profile] Profils par PDB (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||cdb.profile||','||cdb.resource_name||','||cdb.limit
FROM   v$database dbs, cdb_profiles cdb, dba_pdbs pdbs
WHERE  cdb.con_id = pdbs.pdb_id AND cdb.con_id <> 2;

-- [sec_default_profile] Profil par défaut des utilisateurs (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||cdb.username||','||cdb.profile||','||cdb.oracle_maintained
FROM   v$database dbs, cdb_users cdb, dba_pdbs pdbs
WHERE  cdb.con_id = pdbs.pdb_id AND cdb.con_id <> 2
UNION ALL
SELECT dbs.NAME||','||pdbs.pdb_name||','||cdb.NAME||','||cdb.profile||',N'
FROM   v$database dbs, cdb_xs_users cdb, dba_pdbs pdbs
WHERE  cdb.con_id = pdbs.pdb_id AND cdb.con_id <> 2 AND cdb.name NOT IN ('XSGUEST');

-- [sec_usermig] Présence de la table USER$MIG (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||cdb.OWNER||','||cdb.TABLE_NAME
FROM   v$database dbs, CDB_TABLES cdb, dba_pdbs pdbs
WHERE  cdb.con_id = pdbs.pdb_id AND cdb.con_id <> 2
  AND  cdb.TABLE_NAME='USER$MIG' AND cdb.OWNER='SYS';


-- ── Profils (non-CDB) ─────────────────────────────────────────────────────────

-- [sec_profile] Profils (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||prf.profile||','||prf.resource_name||','||prf.limit
FROM   v$database dbs, dba_profiles prf;

-- [sec_default_profile] Profil par défaut des utilisateurs (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||usr.username||','||usr.profile||','||
       NVL(usr.oracle_maintained,'NA')
FROM   v$database dbs, dba_users usr;

-- [sec_usermig] Présence de la table USER$MIG (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||tbs.OWNER||','||tbs.TABLE_NAME
FROM   v$database dbs, DBA_TABLES tbs
WHERE  tbs.TABLE_NAME='USER$MIG' AND tbs.OWNER='SYS';


-- ── Privilèges élevés — toutes bases ─────────────────────────────────────────

-- [sec_admin_high_privs] Utilisateurs dans le fichier de mots de passe (SYSDBA/SYSOPER)
SELECT dbs.NAME||','||pwd.username FROM v$database dbs, v$pwfile_users pwd ORDER BY 1;


-- ── Privilèges élevés (CDB) ───────────────────────────────────────────────────

-- [sec_high_role_privs] Rôles à privilèges élevés (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||r.grantee||','||r.granted_role
FROM   v$database dbs, cdb_role_privs r, dba_pdbs pdbs
WHERE  r.con_id = pdbs.pdb_id AND r.con_id <> 2
  AND  r.GRANTED_ROLE IN ('DELETE_CATALOG_ROLE','SELECT_CATALOG_ROLE','EXECUTE_CATALOG_ROLE','DBA');

-- [sec_high_sys_privs] Privilèges système élevés (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||p.grantee||','||p.privilege
FROM   v$database dbs, cdb_sys_privs p, dba_pdbs pdbs
WHERE  p.con_id = pdbs.pdb_id AND p.con_id <> 2
  AND  p.privilege IN ('SELECT ANY DICTIONARY','SELECT ANY TABLE','AUDIT SYSTEM',
       'EXEMPT ACCESS POLICY','BECOME USER','CREATE_PROCEDURE','ALTER SYSTEM',
       'CREATE ANY LIBRARY','CREATE LIBRARY','GRANT ANY OBJECT PRIVILEGE',
       'GRANT ANY ROLE','GRANT ANY PRIVILEGE','CREATE EXTERNAL JOB');

-- [sec_high_tab_privs] Privilèges sur objets sensibles accordés à PUBLIC (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||p.grantee||','||p.TABLE_NAME
FROM   v$database dbs, cdb_tab_privs p, dba_pdbs pdbs
WHERE  p.con_id = pdbs.pdb_id AND p.con_id <> 2
  AND  p.grantee = 'PUBLIC' AND p.privilege = 'EXECUTE'
  AND  p.TABLE_NAME IN ('UTL_FILE','UTL_INADDR','UTL_MAIL','UTL_SMTP','UTL_HTTP',
       'UTL_ORAMTS','UTL_DBWS','HTTPURITYPE','DBMS_SYS_SQL','DBMS_BACKUP_RESTORE',
       'DBMS_AQADM_SYSCALLS','DBMS_REPCAT_SQL_UTL','INITJVMAUX','DBMS_STREAMS_ADM_UTL',
       'DBMS_AQADM_SYS','DBMS_STREAMS_RPC','DBMS_PRVTAQIM','LTADM','WWV_DBMS_SQL',
       'WWV_EXECUTE_IMMEDIATE','DBMS_IJOB','DBMS_FILE_TRANSFER')
UNION ALL
SELECT dbs.NAME||','||pdbs.pdb_name||','||p.TABLE_NAME||','||p.PRIVILEGE||' TO '||p.grantee
FROM   v$database dbs, cdb_tab_privs p, dba_pdbs pdbs
WHERE  p.con_id = pdbs.pdb_id AND p.con_id <> 2
  AND  p.grantee = 'PUBLIC' AND p.PRIVILEGE = 'INHERIT PRIVILEGES' AND p.TABLE_NAME = p.GRANTOR;

-- [sec_default_user_pwd] Utilisateurs avec mot de passe Oracle par défaut (CDB)
SELECT dbs.NAME||','||'CONTAINER,'||usr.USERNAME
FROM   v$database dbs, DBA_USERS_WITH_DEFPWD usr WHERE USERNAME NOT LIKE '%XS$NULL%';


-- ── Privilèges élevés (non-CDB) ───────────────────────────────────────────────

-- [sec_high_role_privs] Rôles à privilèges élevés (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||r.grantee||','||r.GRANTED_ROLE
FROM   v$database dbs, dba_role_privs r
WHERE  r.GRANTED_ROLE IN ('DELETE_CATALOG_ROLE','SELECT_CATALOG_ROLE','EXECUTE_CATALOG_ROLE','DBA');

-- [sec_high_sys_privs] Privilèges système élevés (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||p.grantee||','||p.privilege
FROM   v$database dbs, dba_sys_privs p
WHERE  p.privilege IN ('SELECT ANY DICTIONARY','SELECT ANY TABLE','AUDIT SYSTEM',
       'EXEMPT ACCESS POLICY','BECOME USER','CREATE_PROCEDURE','ALTER SYSTEM',
       'CREATE ANY LIBRARY','CREATE LIBRARY','GRANT ANY OBJECT PRIVILEGE',
       'GRANT ANY ROLE','GRANT ANY PRIVILEGE','CREATE EXTERNAL JOB');

-- [sec_high_tab_privs] Privilèges sur objets sensibles accordés à PUBLIC (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||p.grantee||','||p.TABLE_NAME
FROM   v$database dbs, dba_tab_privs p
WHERE  p.grantee = 'PUBLIC' AND p.privilege = 'EXECUTE'
  AND  p.TABLE_NAME IN ('UTL_FILE','UTL_INADDR','UTL_MAIL','UTL_SMTP','UTL_HTTP',
       'UTL_ORAMTS','UTL_DBWS','HTTPURITYPE','DBMS_SYS_SQL','DBMS_BACKUP_RESTORE',
       'DBMS_AQADM_SYSCALLS','DBMS_REPCAT_SQL_UTL','INITJVMAUX','DBMS_STREAMS_ADM_UTL',
       'DBMS_AQADM_SYS','DBMS_STREAMS_RPC','DBMS_PRVTAQIM','LTADM','WWV_DBMS_SQL',
       'WWV_EXECUTE_IMMEDIATE','DBMS_IJOB','DBMS_FILE_TRANSFER')
UNION ALL
SELECT dbs.NAME||','||'NON CONTAINER,'||','||p.TABLE_NAME||','||p.PRIVILEGE||' TO '||p.grantee
FROM   v$database dbs, dba_tab_privs p
WHERE  p.grantee = 'PUBLIC' AND p.PRIVILEGE = 'INHERIT PRIVILEGES' AND p.TABLE_NAME = p.GRANTOR;

-- [sec_default_user_pwd] Utilisateurs avec mot de passe Oracle par défaut (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||usr.USERNAME
FROM   v$database dbs, DBA_USERS_WITH_DEFPWD usr WHERE USERNAME NOT LIKE '%XS$NULL%';


-- ── Tablespaces chiffrés (CDB) ───────────────────────────────────────────────

-- [sec_tablespace] Chiffrement des tablespaces (CDB)
SELECT dbs.NAME||','||pdbs.pdb_name||','||ts.tablespace_name||','||ts.encrypted
FROM   v$database dbs, cdb_tablespaces ts, dba_pdbs pdbs
WHERE  ts.con_id = pdbs.pdb_id AND ts.con_id <> 2;


-- ── Tablespaces chiffrés (non-CDB) ───────────────────────────────────────────

-- [sec_tablespace] Chiffrement des tablespaces (non-CDB)
SELECT dbs.NAME||','||'NON CONTAINER,'||ts.tablespace_name||','||ts.encrypted
FROM   v$database dbs, dba_tablespaces ts;


-- ── Audit (Oracle 12c+ — politique unifiée, CDB) ─────────────────────────────

-- [sec_audit] Activation de la politique ORA_CIS_RECOMMENDATIONS (CDB, 12c+)
SELECT dbs.name||','||pol.PDB_NAME||',ORA_CIS_RECOMMENDATIONS,1'
FROM   (SELECT pdbs.PDB_NAME FROM CONTAINERS ("SYS"."AUDIT_UNIFIED_ENABLED_POLICIES") pol, dba_pdbs pdbs
        WHERE pol.con_id = pdbs.pdb_id AND pol.con_id <> 2
          AND pol.POLICY_NAME = 'ORA_CIS_RECOMMENDATIONS') pol, v$database dbs
UNION
SELECT dbs.NAME||','||pdbs.pdb_name||',ORA_CIS_RECOMMENDATIONS,0'
FROM   v$database dbs, dba_pdbs pdbs
WHERE  pdbs.pdb_name NOT IN
       (SELECT pdbs2.PDB_NAME FROM CONTAINERS ("SYS"."AUDIT_UNIFIED_ENABLED_POLICIES") pol, dba_pdbs pdbs2
        WHERE pol.con_id = pdbs2.pdb_id AND pol.con_id <> 2
          AND pol.POLICY_NAME = 'ORA_CIS_RECOMMENDATIONS')
  AND  pdbs.STATUS = 'NORMAL' AND pdbs.con_id <> 2;


-- ── Audit (Oracle 12c+ — politique unifiée, non-CDB) ─────────────────────────

-- [sec_audit] Activation de la politique ORA_CIS_RECOMMENDATIONS (non-CDB, 12c+)
SELECT (SELECT name||',NON CONTAINER' FROM v$database)||
       ',ORA_CIS_RECOMMENDATIONS,'||
       (SELECT COUNT(*) FROM AUDIT_UNIFIED_ENABLED_POLICIES WHERE POLICY_NAME='ORA_CIS_RECOMMENDATIONS')
FROM dual;


-- ── Audit classique (Oracle 11g uniquement) ───────────────────────────────────

-- [sec_audit] Audit classique — options de base (11g)
SELECT dbs.name||',NON CONTAINER,'||opt.AUDIT_OPTION||','||
       CASE WHEN cnt.CNT > 0 THEN '1' ELSE '0' END
FROM   v$database dbs,
       (SELECT 'USER' AO FROM dual UNION ALL SELECT 'ROLE' FROM dual
        UNION ALL SELECT 'SYSTEM GRANT' FROM dual UNION ALL SELECT 'PROFILE' FROM dual
        UNION ALL SELECT 'DATABASE LINK' FROM dual UNION ALL SELECT 'ALTER SYSTEM' FROM dual
        UNION ALL SELECT 'CREATE SESSION' FROM dual UNION ALL SELECT 'TRIGGER' FROM dual) opt,
       (SELECT AUDIT_OPTION, COUNT(*) CNT FROM DBA_STMT_AUDIT_OPTS
        WHERE USER_NAME IS NULL AND PROXY_NAME IS NULL
          AND SUCCESS='BY ACCESS' AND FAILURE='BY ACCESS'
        GROUP BY AUDIT_OPTION) cnt
WHERE  cnt.AUDIT_OPTION(+) = opt.AO;
