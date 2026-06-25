-- Source: OracleCapacityPlanning.php
-- Oracle version:
--   MONTH(x) -> EXTRACT(MONTH FROM x)
--   DATE_SUB(NOW(), INTERVAL N MONTH) -> ADD_MONTHS(SYSDATE, -N)
--   DATE_FORMAT(x,'%m%d') -> TO_CHAR(x,'MMDD')
--   LIMIT N -> FETCH FIRST N ROWS ONLY
--   CONCAT() -> || with TO_CHAR() for NUMBER values
--   MySQL non-standard GROUP BY extension (unaggregated columns) -> rewritten
--   Area chart nested subqueries -> simplified to direct SUM aggregation (NVL for NULL)

-- Oracle Database Usage (J-1)
SELECT b.hostname, a.environment, db_name, pdb_name,
       ROUND(a.size_mb/1024),
       a.cpu_time_minutes,
       a.avg_sga_mb, avg_pga_mb,
       a.avg_buffer_cache_mb,
       a.avg_shared_pool_mb
FROM oracle_database_capacity_planning_summary a,
     (SELECT DISTINCT db_name AS database_name,
             CASE WHEN hostname LIKE '%vm01%' THEN 'Cluster1'
                  WHEN hostname LIKE '%vm02%' THEN 'Cluster2'
                  WHEN hostname LIKE '%vm03%' THEN 'Cluster3'
                  WHEN hostname LIKE '%vm04%' THEN 'Cluster4'
                  WHEN hostname LIKE '%odak%' THEN 'ODA Kayl'
                  WHEN hostname LIKE '%odaw%' THEN 'ODA Windhoff'
                  ELSE hostname END AS hostname
      FROM oracle_database_list) b
WHERE a.db_name = b.database_name;

-- TOP 50 DB Size Grows (last 3 months)
SELECT *
FROM (
    SELECT a.db_name, a.pdb_name, a.environment,
           a.size_gb AS min_size, b.size_gb AS current_size,
           b.size_gb - a.size_gb AS gb_grows
    FROM (
        SELECT c.db_name, c.pdb_name, c.environment, MIN(c.size_gb) AS size_gb
        FROM (
            SELECT TO_CHAR(date_value,'MMDD') AS date_value, db_name, pdb_name, environment,
                   ROUND(SUM(size_mb)/1024) AS size_gb
            FROM oracle_database_capacity_planning_dbsize_history
            WHERE EXTRACT(MONTH FROM date_value) > EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -3))
            GROUP BY db_name, pdb_name, environment, TO_CHAR(date_value,'MMDD')
        ) c
        GROUP BY c.db_name, c.pdb_name, c.environment
    ) a,
    (
        SELECT db_name, pdb_name, environment, ROUND(SUM(size_mb)/1024) AS size_gb
        FROM oracle_database_capacity_planning_dbsize
        GROUP BY db_name, pdb_name, environment
    ) b
    WHERE a.pdb_name = b.pdb_name
      AND a.db_name = b.db_name
    ORDER BY gb_grows
) d
ORDER BY d.gb_grows DESC
FETCH FIRST 50 ROWS ONLY;

-- TOP 20 PDB CPU usage (last 3 months)
SELECT pdb_name, environment,
       ROUND(AVG(cpu_time_minutes)) AS cpu_time,
       ROUND(AVG(cpu_time_minutes))/60/2
FROM oracle_database_capacity_planning_cpu_mem_history
WHERE EXTRACT(MONTH FROM date_value) > EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -3))
GROUP BY pdb_name, environment
ORDER BY cpu_time DESC
FETCH FIRST 20 ROWS ONLY;

-- TOP 50 DB DBSize/Segments Size
SELECT db_name, pdb_name, environment,
       ROUND(SUM(size_mb)/1024),
       ROUND(SUM(sum_segment_mb)/1024),
       ROUND(SUM(size_mb)/1024 - SUM(sum_segment_mb)/1024),
       100 - ROUND((SUM(sum_segment_mb)*100) / SUM(size_mb))
FROM oracle_database_capacity_planning_dbsize
WHERE db_name NOT LIKE 'ZDLRA%'
  AND tablespace_name NOT LIKE '%UNDO%'
GROUP BY db_name, pdb_name, environment
ORDER BY 6 DESC
FETCH FIRST 50 ROWS ONLY;

-- Area Chart PROD - Cumulative DBSize History (last 7 months)
SELECT TO_CHAR(ROUND(a.size_gb)) || ',' || TO_CHAR(ROUND(b.size_gb)) || ',' || TO_CHAR(ROUND(c.size_gb)) || ',' || TO_CHAR(ROUND(d.size_gb)) || ',' || TO_CHAR(ROUND(e.size_gb)) || ',' || TO_CHAR(ROUND(f.size_gb)) || ',' || TO_CHAR(ROUND(g.size_gb))
FROM
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-6)) AND environment='PRD') a,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-5)) AND environment='PRD') b,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-4)) AND environment='PRD') c,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-3)) AND environment='PRD') d,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-2)) AND environment='PRD') e,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-1)) AND environment='PRD') f,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize WHERE environment='PRD') g;

-- Area Chart NONPROD - Cumulative DBSize History (last 7 months)
SELECT TO_CHAR(ROUND(a.size_gb)) || ',' || TO_CHAR(ROUND(b.size_gb)) || ',' || TO_CHAR(ROUND(c.size_gb)) || ',' || TO_CHAR(ROUND(d.size_gb)) || ',' || TO_CHAR(ROUND(e.size_gb)) || ',' || TO_CHAR(ROUND(f.size_gb)) || ',' || TO_CHAR(ROUND(g.size_gb))
FROM
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-6)) AND environment<>'PRD') a,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-5)) AND environment<>'PRD') b,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-4)) AND environment<>'PRD') c,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-3)) AND environment<>'PRD') d,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-2)) AND environment<>'PRD') e,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize_history WHERE EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-1)) AND environment<>'PRD') f,
    (SELECT NVL(SUM(size_mb)/1024, 0) AS size_gb FROM oracle_database_capacity_planning_dbsize WHERE environment<>'PRD') g;
