-- Source: index.php

-- Oracle Security Compliance card (badge couleur)
SELECT CASE WHEN count(*) = 0 THEN 'OK' ELSE 'NOK' END AS compliance_result
FROM oracle_security_scoring
WHERE admin_high_privs_score=0
   OR audit_enable_score=0
   OR default_profile_score=0
   OR default_user_pwd_score=0
   OR high_tab_privs_score=0
   OR security_parameter_score=0
   OR security_profile_score=0;

-- MSSQL Security Compliance card (badge couleur)
SELECT CASE WHEN count(*) = 0 THEN 'OK' ELSE 'NOK' END AS compliance_result
FROM mssql_security_scoring
WHERE compliance_score_total < 100;

-- Oracle Licensing Overview card (badge couleur)
SELECT CASE WHEN count(lmschk.compliance_result) = 0 THEN 'OK' ELSE 'NOK' END AS result
FROM (
    SELECT CASE WHEN num_core=0 THEN 'BAD' ELSE 'GOOD' END AS compliance_result
    FROM oracle_lms lms, oracle_lms_reference lmsref
    WHERE lms.product_name = lmsref.product_name
      AND lms.db_name IN (SELECT db_name FROM oracle_database_list WHERE license_type='CPU')
      AND usage_detected <> 'NO_USAGE'
      AND lmsref.license_type = 'CPU'
    UNION ALL
    SELECT CASE WHEN num_core=0 THEN 'BAD' ELSE 'GOOD' END AS compliance_result
    FROM oracle_lms lms, oracle_lms_reference lmsref
    WHERE lms.product_name = lmsref.product_name
      AND lms.db_name IN (SELECT db_name FROM oracle_database_list WHERE license_type='FSIP')
      AND usage_detected <> 'NO_USAGE'
      AND lmsref.license_type = 'FSIP'
) lmschk
WHERE lmschk.compliance_result = 'BAD';

-- Pie Chart: Hosts OS
SELECT concat(a.nbhst,',',b.nbhst,',',c.nbhst,',',d.nbhst)
FROM
    (SELECT count(*) AS nbhst FROM mssql_hosts WHERE os_type='10.0') a,
    (SELECT count(*) AS nbhst FROM mssql_hosts WHERE os_type='6.3') b,
    (SELECT count(*) AS nbhst FROM mssql_hosts WHERE os_type='6.1') c,
    (SELECT count(*) AS nbhst FROM oracle_hosts WHERE os_type='Linux x86 64-bit') d;

-- Pie Chart: Oracle DB (PRD vs Non PRD)
SELECT concat(a.nbdb,',',b.nbdb)
FROM
    (SELECT count(DISTINCT db_name) AS nbdb FROM oracle_database_list WHERE environment='PRD') a,
    (SELECT count(DISTINCT db_name) AS nbdb FROM oracle_database_list WHERE environment<>'PRD') b;

-- Pie Chart: Oracle PDB (DEV/TST/UAT/PRD)
SELECT concat(a.nbpdb,',',b.nbpdb,',',d.nbpdb,',',g.nbpdb)
FROM
    (SELECT count(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBD%') a,
    (SELECT count(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBT%') b,
    (SELECT count(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBU%') d,
    (SELECT count(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBP%') g;

-- Pie Chart: Oracle Version (19c / 23ai)
SELECT concat(d.db_name,',',f.db_name)
FROM
    (SELECT count(db_name) AS db_name FROM oracle_database_list WHERE db_version='19.0.0.0.0') d,
    (SELECT count(db_name) AS db_name FROM oracle_database_list WHERE db_version LIKE '23%') f;

-- Pie Chart: MSSQL Version
SELECT concat(a.product_version,',',b.product_version,',',c.product_version,',',d.product_version,',',e.product_version,',',f.product_version,',',g.product_version)
FROM
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '10.50.%') a,
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '11.0.%') b,
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '12.0.%') c,
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '13.0.%') d,
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '14.0.%') e,
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '15.0.%') f,
    (SELECT count(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '16.0.%') g;

-- Pie Chart: MSSQL DB par environnement
SELECT concat(a.mssql_hst,',',d.mssql_hst,',',e.mssql_hst,',',f.mssql_hst)
FROM
    (SELECT count(hostname) AS mssql_hst FROM mssql_hosts WHERE env='DEV') a,
    (SELECT count(hostname) AS mssql_hst FROM mssql_hosts WHERE env='PRD') d,
    (SELECT count(hostname) AS mssql_hst FROM mssql_hosts WHERE env='TST') e,
    (SELECT count(hostname) AS mssql_hst FROM mssql_hosts WHERE env='UAT') f;
