-- Source: MSSQLServersnodb.php
-- Oracle version (no changes required)

SELECT CT.hostname,
       CT.env AS Env,
       CASE WHEN CT.mssql_edition LIKE '%Enterprise%' THEN 'Enterprise Edition'
            WHEN CT.mssql_edition LIKE '%Standard%'   THEN 'Standard Edition'
            WHEN CT.mssql_edition LIKE '%Express%'    THEN 'Express Edition'
            WHEN CT.mssql_edition LIKE '%Dev%'        THEN 'Developer Edition'
            ELSE 'Not Standard Nor Enterprise' END AS MSSQL_Edition,
       CT.mssql_product_version,
       CT.collation,
       CT.os_type,
       CT.is_clustered,
       CT.num_cpus,
       CT.memory_gb,
       CT.service_account
FROM mssql_hosts CT
WHERE CT.hostname NOT IN (
    SELECT DISTINCT hostname
    FROM mssql_database
    WHERE database_name NOT IN ('master','model','msdb','tempdb','dba')
)
ORDER BY CT.hostname;
