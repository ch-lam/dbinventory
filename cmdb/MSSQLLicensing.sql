-- Source: MSSQLLicensing.php

-- Production Environment (env = 'PRD')
SELECT a.MSSQL_Edition, a.license_type, sum(a.num_cpus) AS CPU_Core, sum(a.licence_count) AS NB_Pack_2_Cores
FROM (
    SELECT CT.env,
           CT.license_type,
           CASE WHEN CT.mssql_edition LIKE '%Enterprise%' THEN 'Enterprise Edition'
                WHEN CT.mssql_edition LIKE '%Standard%'   THEN 'Standard Edition'
                ELSE 'Unknow Edition' END AS MSSQL_Edition,
           CT.mssql_product_version,
           CT.num_cpus,
           CASE WHEN CT.num_cpus <= 4 THEN '2' ELSE round(CT.num_cpus/2) END AS licence_count
    FROM inventory.mssql_hosts CT
    WHERE CT.env = 'PRD'
      AND (CT.mssql_edition LIKE '%Enterprise%' OR CT.mssql_edition LIKE '%Standard%')
      AND CT.license_type <> 'FREE_LIC'
    ORDER BY CT.hostname
) a
GROUP BY a.MSSQL_Edition, a.license_type;

-- Testing Environment (env = 'TST')
SELECT a.MSSQL_Edition, a.license_type, sum(a.num_cpus) AS CPU_Core, sum(a.licence_count) AS NB_Pack_2_Cores
FROM (
    SELECT CT.env,
           CT.license_type,
           CASE WHEN CT.mssql_edition LIKE '%Enterprise%' THEN 'Enterprise Edition'
                WHEN CT.mssql_edition LIKE '%Standard%'   THEN 'Standard Edition'
                ELSE 'Unknow Edition' END AS MSSQL_Edition,
           CT.mssql_product_version,
           CT.num_cpus,
           CASE WHEN CT.num_cpus <= 4 THEN '2' ELSE round(CT.num_cpus/2) END AS licence_count
    FROM inventory.mssql_hosts CT
    WHERE CT.env = 'TST'
      AND (CT.mssql_edition LIKE '%Enterprise%' OR CT.mssql_edition LIKE '%Standard%')
      AND CT.license_type <> 'FREE_LIC'
    ORDER BY CT.hostname
) a
GROUP BY a.MSSQL_Edition, a.license_type;

-- Development / Others Environment (env NOT IN ('TST','PRD'))
SELECT a.MSSQL_Edition, a.license_type, sum(a.num_cpus) AS CPU_Core, sum(a.licence_count) AS NB_Pack_2_Cores
FROM (
    SELECT CT.env,
           CT.license_type,
           CASE WHEN CT.mssql_edition LIKE '%Enterprise%' THEN 'Enterprise Edition'
                WHEN CT.mssql_edition LIKE '%Standard%'   THEN 'Standard Edition'
                ELSE 'Unknow Edition' END AS MSSQL_Edition,
           CT.mssql_product_version,
           CT.num_cpus,
           CASE WHEN CT.num_cpus <= 4 THEN '2' ELSE round(CT.num_cpus/2) END AS licence_count
    FROM inventory.mssql_hosts CT
    WHERE CT.env NOT IN ('TST','PRD')
      AND (CT.mssql_edition LIKE '%Enterprise%' OR CT.mssql_edition LIKE '%Standard%')
      AND CT.license_type <> 'FREE_LIC'
    ORDER BY CT.hostname
) a
GROUP BY a.MSSQL_Edition, a.license_type;
