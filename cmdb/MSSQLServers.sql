-- Source: MSSQLServers.php

SELECT CT.hostname, CT.env, CT.license_type,
       CASE WHEN CT.mssql_edition LIKE '%Enterprise%' THEN 'Enterprise Edition'
            WHEN CT.mssql_edition LIKE '%Standard%'   THEN 'Standard Edition'
            WHEN CT.mssql_edition LIKE '%Developer%'  THEN 'Developer Edition'
            WHEN CT.mssql_edition LIKE '%Express%'    THEN 'Express Edition'
            ELSE 'Not Standard Nor Enterprise' END AS MSSQL_Edition,
       CT.mssql_product_version, CT.collation, CT.os_type, CT.is_clustered,
       CT.ActiveNodeName, CT.num_cpus, CT.memory_gb, CT.service_account, IPA.comment
FROM mssql_hosts CT, chl_ipam_comment IPA
WHERE upper(replace(CT.hostname, concat('/', substring_index(CT.hostname,'/',-1)), '')) = upper(IPA.hostname)
UNION
SELECT CT.hostname, CT.env, CT.license_type,
       CASE WHEN CT.mssql_edition LIKE '%Enterprise%' THEN 'Enterprise Edition'
            WHEN CT.mssql_edition LIKE '%Standard%'   THEN 'Standard Edition'
            WHEN CT.mssql_edition LIKE '%Developer%'  THEN 'Developer Edition'
            WHEN CT.mssql_edition LIKE '%Express%'    THEN 'Express Edition'
            ELSE 'Not Standard Nor Enterprise' END AS MSSQL_Edition,
       CT.mssql_product_version, CT.collation, CT.os_type, CT.is_clustered,
       CT.ActiveNodeName, CT.num_cpus, CT.memory_gb, CT.service_account, 'NOT IN IPAM'
FROM mssql_hosts CT
WHERE upper(replace(CT.hostname, concat('/', substring_index(CT.hostname,'/',-1)), ''))
      NOT IN (SELECT upper(hostname) FROM chl_ipam_comment);
