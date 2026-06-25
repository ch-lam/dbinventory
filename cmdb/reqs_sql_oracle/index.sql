-- Source: index.php
-- Oracle version: CONCAT() -> || ; TO_CHAR() on COUNT/numeric results

-- Oracle Security Compliance card (badge couleur)
SELECT CASE WHEN COUNT(*) = 0 THEN 'OK' ELSE 'NOK' END AS compliance_result
FROM oracle_security_scoring
WHERE admin_high_privs_score=0
   OR audit_enable_score=0
   OR default_profile_score=0
   OR default_user_pwd_score=0
   OR high_tab_privs_score=0
   OR security_parameter_score=0
   OR security_profile_score=0;

-- MSSQL Security Compliance card (badge couleur)
SELECT CASE WHEN COUNT(*) = 0 THEN 'OK' ELSE 'NOK' END AS compliance_result
FROM mssql_security_scoring
WHERE compliance_score_total < 100;

-- Oracle Licensing Overview card (badge couleur)
SELECT CASE WHEN COUNT(lmschk.compliance_result) = 0 THEN 'OK' ELSE 'NOK' END AS result
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
SELECT TO_CHAR(a.nbhst) || ',' || TO_CHAR(b.nbhst) || ',' || TO_CHAR(c.nbhst) || ',' || TO_CHAR(d.nbhst)
FROM
    (SELECT COUNT(*) AS nbhst FROM mssql_hosts WHERE os_type='10.0') a,
    (SELECT COUNT(*) AS nbhst FROM mssql_hosts WHERE os_type='6.3') b,
    (SELECT COUNT(*) AS nbhst FROM mssql_hosts WHERE os_type='6.1') c,
    (SELECT COUNT(*) AS nbhst FROM oracle_hosts WHERE os_type='Linux x86 64-bit') d;

-- Pie Chart: Oracle DB (PRD vs Non PRD)
SELECT TO_CHAR(a.nbdb) || ',' || TO_CHAR(b.nbdb)
FROM
    (SELECT COUNT(DISTINCT db_name) AS nbdb FROM oracle_database_list WHERE environment='PRD') a,
    (SELECT COUNT(DISTINCT db_name) AS nbdb FROM oracle_database_list WHERE environment<>'PRD') b;

-- Pie Chart: Oracle PDB (DEV/TST/UAT/PRD)
SELECT TO_CHAR(a.nbpdb) || ',' || TO_CHAR(b.nbpdb) || ',' || TO_CHAR(d.nbpdb) || ',' || TO_CHAR(g.nbpdb)
FROM
    (SELECT COUNT(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBD%') a,
    (SELECT COUNT(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBT%') b,
    (SELECT COUNT(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBU%') d,
    (SELECT COUNT(DISTINCT pdb_name) AS nbpdb FROM oracle_pdbs WHERE pdb_name LIKE 'PDBP%') g;

-- Pie Chart: Oracle Version (19c / 23ai)
SELECT TO_CHAR(d.db_name) || ',' || TO_CHAR(f.db_name)
FROM
    (SELECT COUNT(db_name) AS db_name FROM oracle_database_list WHERE db_version='19.0.0.0.0') d,
    (SELECT COUNT(db_name) AS db_name FROM oracle_database_list WHERE db_version LIKE '23%') f;

-- Pie Chart: MSSQL Version
SELECT TO_CHAR(a.product_version) || ',' || TO_CHAR(b.product_version) || ',' || TO_CHAR(c.product_version) || ',' || TO_CHAR(d.product_version) || ',' || TO_CHAR(e.product_version) || ',' || TO_CHAR(f.product_version) || ',' || TO_CHAR(g.product_version)
FROM
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '10.50.%') a,
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '11.0.%') b,
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '12.0.%') c,
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '13.0.%') d,
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '14.0.%') e,
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '15.0.%') f,
    (SELECT COUNT(DISTINCT hostname) AS product_version FROM mssql_hosts WHERE mssql_product_version LIKE '16.0.%') g;

-- Pie Chart: MSSQL DB par environnement
SELECT TO_CHAR(a.mssql_hst) || ',' || TO_CHAR(d.mssql_hst) || ',' || TO_CHAR(e.mssql_hst) || ',' || TO_CHAR(f.mssql_hst)
FROM
    (SELECT COUNT(hostname) AS mssql_hst FROM mssql_hosts WHERE env='DEV') a,
    (SELECT COUNT(hostname) AS mssql_hst FROM mssql_hosts WHERE env='PRD') d,
    (SELECT COUNT(hostname) AS mssql_hst FROM mssql_hosts WHERE env='TST') e,
    (SELECT COUNT(hostname) AS mssql_hst FROM mssql_hosts WHERE env='UAT') f;
