-- =============================================================================
-- get_info_oracle — Requêtes SQL de collecte inventaire Oracle
--
-- Exécution : sqlplus monitoring/<pass>@<tns_alias>
-- Session recommandée :
--   SET FEEDBACK OFF
--   SET HEADING OFF
--   SET PAGESIZE 0
--   SET LINESIZE 32767
--   ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
--
-- Placeholders (remplacés dynamiquement par le script shell) :
--   <db_env>       : environnement (PROD, DEV, etc.)
--   <lic>          : type de licence
--   <tns_alias>    : alias TNS de la base
--   <IS_CONTAINER> : CONTAINER ou NON_CONTAINER
-- =============================================================================


-- ── Toutes les bases (PRIMARY et STANDBY) ─────────────────────────────────────

-- [hosts] Informations hôte / CPU / mémoire / OS
SELECT '<db_env>,<lic>,'||
       (SELECT host_name FROM v$instance)||','||
       (SELECT value FROM v$osstat WHERE stat_name='NUM_CPUS')||','||
       (SELECT ROUND(value/1024/1024/1024) FROM v$osstat WHERE stat_name='PHYSICAL_MEMORY_BYTES')||','||
       (SELECT platform_name FROM v$database)
FROM dual;

-- [databases] Informations instance et base de données
SELECT '<db_env>,<lic>,'||
       (SELECT host_name||','||instance_name||','||version FROM v$instance)||','||
       (SELECT name||','||log_mode||','||database_role||','||db_unique_name FROM v$database)||','||
       (SELECT value FROM v$nls_parameters WHERE parameter='NLS_CHARACTERSET')||','||
       'Enterprise Edition,'||
       (SELECT value FROM v$parameter WHERE name='cluster_database')||','||
       (SELECT ROUND(SUM(value)/1024/1024/1024) FROM v$sga)||','||
       (SELECT ROUND(value/1024/1024/1024) FROM v$pgastat WHERE name='maximum PGA allocated')||','||
       (SELECT ROUND(usable_file_mb/1024)
          FROM v$asm_diskgroup WHERE name LIKE '%DATA%' AND state='CONNECTED' AND ROWNUM=1)||','||
       (SELECT CASE type WHEN 'HIGH' THEN ROUND(total_mb/3/1024) ELSE ROUND(total_mb/2/1024) END
          FROM v$asm_diskgroup WHERE name LIKE '%DATA%' AND state='CONNECTED' AND ROWNUM=1)||','||
       '<tns_alias>,<IS_CONTAINER>'
FROM dual;


-- ── Primaire CDB uniquement ───────────────────────────────────────────────────

-- [pdbs] Liste des PDBs
SELECT inst.host_name||','||inst.instance_name||','||pdb.pdb_name||','||pdb.status
FROM   cdb_pdbs pdb, v$instance inst
WHERE  pdb.pdb_name NOT LIKE '%SEED%' ORDER BY 1;

-- [services] Services actifs (CDB)
SELECT inst.host_name||','||inst.instance_name||','||pdb.pdb_name||','||svc.name
FROM   v$active_services svc, cdb_pdbs pdb, v$instance inst
WHERE  pdb.pdb_id = svc.con_id AND svc.name NOT LIKE 'SYS%' AND svc.name NOT LIKE '%pdb%'
ORDER BY 1;

-- [users] Utilisateurs actifs / OPEN (CDB)
SELECT inst.host_name||','||dbs.name||','||inst.instance_name||','||
       pdb.pdb_name||','||usr.username||','||usr.account_status
FROM   cdb_users usr, v$instance inst, v$database dbs, dba_pdbs pdb
WHERE  usr.con_id = pdb.pdb_id AND usr.account_status = 'OPEN' ORDER BY 1;

-- [size_usage] Taille des tablespaces par datafiles (CDB)
SELECT dbs.name||','||pdb.pdb_name||','||cdf.tablespace_name||','||ROUND(SUM(cdf.bytes/1024/1024))
FROM   cdb_pdbs pdb, v$database dbs, cdb_data_files cdf
WHERE  pdb.pdb_id = cdf.con_id AND pdb.pdb_name NOT LIKE '%SEED%'
GROUP BY dbs.name, pdb.pdb_name, cdf.tablespace_name;

-- [size_usage_seg] Taille des tablespaces par segments (CDB)
SELECT dbs.name||','||pdb.pdb_name||','||seg.tablespace_name||','||ROUND(SUM(seg.bytes/1024/1024))
FROM   cdb_pdbs pdb, v$database dbs, cdb_segments seg
WHERE  pdb.pdb_id = seg.con_id AND pdb.pdb_name NOT LIKE '%SEED%'
GROUP BY dbs.name, pdb.pdb_name, seg.tablespace_name;

-- [cpu_by_service] Consommation CPU par service sur les dernières 24h (CDB)
SELECT pdb.pdb_name||','||hist.service_name||','||ROUND(SUM(hist.value)/60000)
FROM   dba_hist_service_stat hist, dba_pdbs pdb
WHERE  hist.con_id = pdb.pdb_id AND hist.stat_name = 'DB CPU'
  AND  hist.snap_id IN (SELECT snap_id FROM dba_hist_snapshot WHERE begin_interval_time > SYSDATE-1)
GROUP BY pdb.pdb_name, hist.service_name;

-- [cpu_mem] Métriques CPU/mémoire par PDB sur les dernières 24h (CDB, Oracle 18c+)
SELECT p.pdb_name||','||ROUND(SUM(r.cpu_consumed_time)/60000)||','||
       ROUND(AVG(r.sga_bytes)/1024/1024)||','||ROUND(AVG(r.pga_bytes)/1024/1024)||','||
       ROUND(AVG(r.buffer_cache_bytes)/1024/1024)||','||ROUND(AVG(r.shared_pool_bytes)/1024/1024)
FROM   dba_hist_rsrc_pdb_metric r, cdb_pdbs p
WHERE  r.con_id = p.con_id AND r.end_time > SYSDATE-1 AND p.pdb_name NOT LIKE '%SEED%'
GROUP BY p.pdb_name;


-- ── Primaire NON-CDB uniquement ───────────────────────────────────────────────

-- [services] Services actifs (non-CDB)
SELECT inst.host_name||','||inst.instance_name||',NA,'||svc.name
FROM   v$active_services svc, v$instance inst
WHERE  svc.name NOT LIKE 'SYS%' ORDER BY 1;

-- [users] Utilisateurs actifs / OPEN (non-CDB)
SELECT inst.host_name||','||dbs.name||','||inst.instance_name||',NON_CONTAINER,'||
       usr.username||','||usr.account_status
FROM   dba_users usr, v$instance inst, v$database dbs
WHERE  usr.account_status = 'OPEN' ORDER BY 1;

-- [size_usage] Taille des tablespaces par datafiles (non-CDB)
SELECT dbs.name||',NON_CONTAINER,'||dbf.tablespace_name||','||ROUND(SUM(dbf.bytes/1024/1024))
FROM   v$database dbs, dba_data_files dbf GROUP BY dbs.name, dbf.tablespace_name;

-- [size_usage_seg] Taille des tablespaces par segments (non-CDB)
SELECT dbs.name||',NON_CONTAINER,'||seg.tablespace_name||','||ROUND(SUM(seg.bytes/1024/1024))
FROM   v$database dbs, dba_segments seg GROUP BY dbs.name, seg.tablespace_name;


-- ── Tous primaires ────────────────────────────────────────────────────────────

-- [backup] Historique des backups RMAN (31 derniers jours)
SELECT dbs.name||','||rma.input_type||','||rma.status||','||
       TO_CHAR(rma.start_time,'YYYY-MM-DD HH24:MI')||','||
       TO_CHAR(rma.end_time,'YYYY-MM-DD HH24:MI')||','||ROUND(rma.elapsed_seconds/60)
FROM   v$rman_backup_job_details rma, v$database dbs
WHERE  rma.start_time > SYSDATE-31 ORDER BY rma.start_time;

-- [psu] Dernier patch PSU / Release Update appliqué
SELECT dbs.name||','||(SELECT version FROM v$instance)||','||REPLACE(p.description,',','')
FROM   v$database dbs, sys.dba_registry_sqlpatch p
WHERE  p.action = 'APPLY'
  AND  (p.description LIKE 'Database PSU%' OR p.description LIKE 'Database Rele%')
  AND  p.action_time = (SELECT MAX(action_time) FROM sys.dba_registry_sqlpatch
                         WHERE (description LIKE 'Database PSU%' OR description LIKE 'Database Rele%')
                           AND action = 'APPLY');


-- ── DataGuard (primaire avec broker actif) ────────────────────────────────────

-- Vérification activation du broker DG
SELECT 'TRUE' FROM v$parameter WHERE name='dg_broker_start' AND LOWER(value)='true';

-- Liste des PDBs pour rapport DataGuard
SELECT '/ '||pdb_name||' /' FROM cdb_pdbs WHERE pdb_name NOT LIKE '%SEED%' ORDER BY 1;

-- Liste des services pour rapport DataGuard
SELECT '/ '||name||' /' FROM gv$active_services WHERE name NOT LIKE 'SYS%' AND name NOT LIKE '%pdb%' ORDER BY 1;
