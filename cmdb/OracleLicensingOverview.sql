-- Source: OracleLicensingOverview.php

-- Oracle Licensing Core Usage
SELECT license_type, os_type, sum(num_cpus) AS vcpu,
       CASE WHEN os_type='Linux x86 64-bit' THEN format(sum(num_cpus)/2,0)   ELSE format(sum(num_cpus)/8,0) END AS num_core,
       CASE WHEN os_type='Linux x86 64-bit' THEN format((sum(num_cpus)/2)/2,0) ELSE format(sum(num_cpus)/8,0) END AS core_with_core_factor
FROM oracle_hosts
WHERE license_type IN ('CPU','FSIP')
GROUP BY os_type, license_type
ORDER BY 1, 2;

-- Oracle Licensing Options Usage
SELECT DISTINCT lms.product_name,
       CASE WHEN num_core=0 THEN 'BAD' ELSE 'GOOD' END AS compliance_result,
       'CPU', 'YES', lmsref.num_core
FROM oracle_lms lms, oracle_lms_reference lmsref
WHERE lms.product_name = lmsref.product_name
  AND lms.db_name IN (SELECT db_name FROM oracle_database_list WHERE license_type='CPU')
  AND usage_detected <> 'NO_USAGE'
  AND lmsref.license_type = 'CPU'
UNION ALL
SELECT DISTINCT lms.product_name,
       CASE WHEN num_core=0 THEN 'BAD' ELSE 'GOOD' END AS compliance_result,
       'FSIP', 'YES', lmsref.num_core
FROM oracle_lms lms, oracle_lms_reference lmsref
WHERE lms.product_name = lmsref.product_name
  AND lms.db_name IN (SELECT db_name FROM oracle_database_list WHERE license_type='FSIP')
  AND usage_detected <> 'NO_USAGE'
  AND lmsref.license_type = 'FSIP';

-- Oracle Licensing Product Usage Details
SELECT 'BAD', dbs.license_type, lms.db_name, lms.hostname, lms.db_pdb_name,
       lms.product_name, lms.usage_detected, lms.first_usage_date, lms.last_usage_date
FROM oracle_lms lms, oracle_database_list dbs
WHERE dbs.db_name = lms.db_name
  AND lms.product_name IN (SELECT product_name FROM oracle_lms_reference WHERE num_core=0 AND license_type=dbs.license_type)
  AND lms.usage_detected <> 'NO_USAGE'
UNION ALL
SELECT 'GOOD', dbs.license_type, lms.db_name, lms.hostname, lms.db_pdb_name,
       lms.product_name, lms.usage_detected, lms.first_usage_date, lms.last_usage_date
FROM oracle_lms lms, oracle_database_list dbs
WHERE dbs.db_name = lms.db_name
  AND lms.product_name IN (SELECT product_name FROM oracle_lms_reference WHERE num_core>0 AND license_type=dbs.license_type)
  AND lms.usage_detected <> 'NO_USAGE';
