-- Source: OracleCapacityPlanning.php

-- Oracle Database Usage (J-1)
SELECT b.hostname, a.environment, db_name, pdb_name,
       round(a.size_mb/1024),
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
    SELECT a.db_name, a.pdb_name, b.environment,
           a.size_gb AS min_size, b.size_gb AS current_size,
           b.size_gb - a.size_gb AS gb_grows
    FROM (
        SELECT min(c.date_value), c.db_name, c.pdb_name, c.environment, c.size_gb
        FROM (
            SELECT DATE_FORMAT(date_value,'%m%d') AS date_value, db_name, pdb_name, environment,
                   round(sum(size_mb)/1024) AS size_gb
            FROM oracle_database_capacity_planning_dbsize_history
            WHERE MONTH(date_value) > MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))
            GROUP BY db_name, pdb_name, environment, date_value
        ) c
        GROUP BY c.db_name, c.pdb_name
    ) a,
    (
        SELECT db_name, pdb_name, environment, round(sum(size_mb)/1024) AS size_gb
        FROM oracle_database_capacity_planning_dbsize
        GROUP BY db_name, pdb_name, environment
    ) b
    WHERE a.pdb_name = b.pdb_name
      AND a.db_name = b.db_name
    ORDER BY gb_grows
) d
GROUP BY d.db_name, d.pdb_name
ORDER BY d.gb_grows DESC
LIMIT 50;

-- TOP 20 PDB CPU usage (last 3 months)
SELECT pdb_name, environment,
       round(avg(cpu_time_minutes)) AS cpu_time,
       round(avg(cpu_time_minutes))/60/2
FROM oracle_database_capacity_planning_cpu_mem_history
WHERE MONTH(date_value) > MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))
GROUP BY pdb_name, environment
ORDER BY cpu_time DESC
LIMIT 20;

-- TOP 50 DB DBSize/Segments Size
SELECT db_name, pdb_name, environment,
       round(sum(size_mb)/1024),
       round(sum(sum_segment_mb)/1024),
       round(sum(size_mb)/1024 - sum(sum_segment_mb)/1024),
       100 - round((sum(sum_segment_mb)*100) / sum(size_mb))
FROM oracle_database_capacity_planning_dbsize
WHERE db_name NOT LIKE 'ZDLRA%'
  AND tablespace_name NOT LIKE '%UNDO%'
GROUP BY db_name, pdb_name, environment
ORDER BY 6 DESC
LIMIT 50;

-- Area Chart PROD - Cumulative DBSize History (last 7 months)
SELECT concat(round(a.size_gb),',',round(b.size_gb),',',round(c.size_gb),',',round(d.size_gb),',',round(e.size_gb),',',round(f.size_gb),',',round(g.size_gb))
FROM
    (SELECT COALESCE(h.size_gb,0) AS size_gb, min(h.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AND environment='PRD' GROUP BY DATE_FORMAT(date_value,'%d')) h) a,
    (SELECT COALESCE(i.size_gb,0) AS size_gb, min(i.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AND environment='PRD' GROUP BY DATE_FORMAT(date_value,'%d')) i) b,
    (SELECT COALESCE(j.size_gb,0) AS size_gb, min(j.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AND environment='PRD' GROUP BY DATE_FORMAT(date_value,'%d')) j) c,
    (SELECT COALESCE(k.size_gb,0) AS size_gb, min(k.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AND environment='PRD' GROUP BY DATE_FORMAT(date_value,'%d')) k) d,
    (SELECT COALESCE(l.size_gb,0) AS size_gb, min(l.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AND environment='PRD' GROUP BY DATE_FORMAT(date_value,'%d')) l) e,
    (SELECT COALESCE(m.size_gb,0) AS size_gb, min(m.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND environment='PRD' GROUP BY DATE_FORMAT(date_value,'%d')) m) f,
    (SELECT sum(size_mb)/1024 AS size_gb FROM oracle_database_capacity_planning_dbsize WHERE environment='PRD') g;

-- Area Chart NONPROD - Cumulative DBSize History (last 7 months)
SELECT concat(round(a.size_gb),',',round(b.size_gb),',',round(c.size_gb),',',round(d.size_gb),',',round(e.size_gb),',',round(f.size_gb),',',round(g.size_gb))
FROM
    (SELECT COALESCE(h.size_gb,0) AS size_gb, min(h.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AND environment<>'PRD' GROUP BY DATE_FORMAT(date_value,'%d')) h) a,
    (SELECT COALESCE(i.size_gb,0) AS size_gb, min(i.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AND environment<>'PRD' GROUP BY DATE_FORMAT(date_value,'%d')) i) b,
    (SELECT COALESCE(j.size_gb,0) AS size_gb, min(j.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AND environment<>'PRD' GROUP BY DATE_FORMAT(date_value,'%d')) j) c,
    (SELECT COALESCE(k.size_gb,0) AS size_gb, min(k.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AND environment<>'PRD' GROUP BY DATE_FORMAT(date_value,'%d')) k) d,
    (SELECT COALESCE(l.size_gb,0) AS size_gb, min(l.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AND environment<>'PRD' GROUP BY DATE_FORMAT(date_value,'%d')) l) e,
    (SELECT COALESCE(m.size_gb,0) AS size_gb, min(m.date_value) FROM (SELECT sum(size_mb)/1024 AS size_gb, DATE_FORMAT(date_value,'%d') AS date_value FROM oracle_database_capacity_planning_dbsize_history WHERE MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND environment<>'PRD' GROUP BY DATE_FORMAT(date_value,'%d')) m) f,
    (SELECT sum(size_mb)/1024 AS size_gb FROM oracle_database_capacity_planning_dbsize WHERE environment<>'PRD') g;
