-- Source: OraclePatchingReleaseSupport.php

-- Oracle Infrastructure Release Used
SELECT TYPE, VERSION, END_OF_SUPPORT_DATE,
       CASE WHEN END_OF_SUPPORT_DATE > CURDATE() THEN 'SUPPORTED' ELSE 'OUT OF SUPPORT' END AS supported_state
FROM product_support
WHERE TYPE = 'ORACLE'
UNION ALL
SELECT 'ORACLE', db_version, 'NOT REGISTER IN CMDB', 'OUT OF SUPPORT'
FROM oracle_database_list
WHERE db_version NOT IN (SELECT version FROM product_support WHERE TYPE = 'ORACLE');

-- PDB Infrastructure Support State
SELECT DISTINCT
       CASE WHEN substr(a.pdb_name,4,1) = 'D' THEN 'DEV'
            WHEN substr(a.pdb_name,4,1) = 'T' THEN 'TST'
            WHEN substr(a.pdb_name,4,1) = 'V' THEN 'INT'
            WHEN substr(a.pdb_name,4,1) = 'U' THEN 'UAT'
            WHEN substr(a.pdb_name,4,1) = 'P' THEN 'PRD'
            WHEN substr(a.pdb_name,4,1) = 'A' THEN 'TAT'
            WHEN substr(a.pdb_name,4,1) = 'R' THEN 'DRE'
            WHEN substr(a.pdb_name,4,1) = 'S' THEN 'SNAPSHOT'
            ELSE 'UNKNOWN' END AS env,
       substr(a.pdb_name,6,30),
       b.db_version,
       CASE WHEN b.db_version IN (SELECT VERSION FROM product_support WHERE TYPE='ORACLE' AND END_OF_SUPPORT_DATE < CURDATE()) THEN 'OUT OF SUPPORT'
            ELSE 'SUPPORTED' END AS supported_state,
       a.pdb_name
FROM oracle_pdbs a, oracle_database_list b
WHERE a.instance_name = b.instance_name
ORDER BY 2, 1, 3;

-- Non Container Infrastructure Support State
SELECT x.environment, x.db_version, x.db_name, x.supported_state
FROM (
    SELECT DISTINCT a.db_name, a.environment, a.db_version,
           CASE WHEN a.db_version IN (SELECT VERSION FROM product_support WHERE TYPE='ORACLE' AND END_OF_SUPPORT_DATE < CURDATE()) THEN 'OUT OF SUPPORT'
                ELSE 'SUPPORTED' END AS supported_state
    FROM oracle_database_list a
    WHERE a.database_type = 'NON_CONTAINER'
      AND db_role = 'PRIMARY'
    ORDER BY 2, 1, 3
) x;
