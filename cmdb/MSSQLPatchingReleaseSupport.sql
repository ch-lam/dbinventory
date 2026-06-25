-- Source: MSSQLPatchingReleaseSupport.php

-- MSSQL Infrastructure Release Used
SELECT TYPE, VERSION, END_OF_SUPPORT_DATE,
       CASE
           WHEN END_OF_SUPPORT_DATE > CURDATE() THEN 'SUPPORTED'
           ELSE 'OUT OF SUPPORT'
       END AS supported_state
FROM product_support
WHERE TYPE = 'MSSQL'
UNION ALL
SELECT 'MSSQL', mssql_product_version, 'NOT REGISTER IN CMDB', 'OUT OF SUPPORT'
FROM mssql_hosts
WHERE mssql_product_version NOT IN (SELECT version FROM product_support WHERE TYPE = 'MSSQL');

-- MSSQL Infrastructure Support State (per database)
SELECT CT.env, CT.hostname, upper(CT.database_name), HST.mssql_product_version,
       CASE
           WHEN HST.mssql_product_version IN (SELECT VERSION FROM product_support WHERE TYPE = 'MSSQL' AND END_OF_SUPPORT_DATE < CURDATE()) THEN 'OUT OF SUPPORT'
           ELSE 'SUPPORTED'
       END AS supported_state
FROM mssql_database CT, mssql_hosts HST
WHERE CT.hostname = HST.hostname
  AND CT.database_name NOT IN ('master','tempdb','model','dba','msdb');
