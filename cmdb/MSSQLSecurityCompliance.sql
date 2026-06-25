-- Source: MSSQLSecurityCompliance.php

-- Security Scoring Per Servername
SELECT
    replace(replace(legacy_server,     '1','YES'),0,'NO'),
    replace(replace(exception_detected,'1','YES'),0,'NO'),
    compliance_score_total,
    date_value,
    concat('Details: ',servername),
    servername,
    environment,
    replace(replace(configoptions,    '1','OK'),0,'NOK'),
    replace(replace(dbproperties,     '1','OK'),0,'NOK'),
    replace(replace(auditlevel,       '1','OK'),0,'NOK'),
    replace(replace(encryption,       '1','OK'),0,'NOK'),
    replace(replace(groups,           '1','OK'),0,'NOK'),
    replace(replace(guestconnect,     '1','OK'),0,'NOK'),
    replace(replace(logins,           '1','OK'),0,'NOK'),
    replace(replace(orphanedusers,    '1','OK'),0,'NOK'),
    replace(replace(publicpermission, '1','OK'),0,'NOK'),
    replace(replace(registryinfo,     '1','OK'),0,'NOK'),
    replace(replace(sqlserveraudit,   '1','OK'),0,'NOK')
FROM mssql_security_scoring;

-- Area Chart PROD - Average Security Scoring (last 7 months)
SELECT concat(a.compliance_score_total,',',b.compliance_score_total,',',c.compliance_score_total,',',d.compliance_score_total,',',e.compliance_score_total,',',f.compliance_score_total,',',g.compliance_score_total)
FROM
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) a,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) b,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) c,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) d,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) e,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) f,
    (SELECT avg(compliance_score_total) AS compliance_score_total FROM mssql_security_scoring WHERE environment='PRD') g;

-- Area Chart NON PROD - Average Security Scoring (last 7 months)
SELECT concat(a.compliance_score_total,',',b.compliance_score_total,',',c.compliance_score_total,',',d.compliance_score_total,',',e.compliance_score_total,',',f.compliance_score_total,',',g.compliance_score_total)
FROM
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) a,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) b,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) c,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) d,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) e,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) f,
    (SELECT avg(compliance_score_total) AS compliance_score_total FROM mssql_security_scoring WHERE environment != 'PRD') g;
