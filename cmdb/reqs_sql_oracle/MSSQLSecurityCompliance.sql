-- Source: MSSQLSecurityCompliance.php
-- Oracle version:
--   REPLACE(REPLACE(col,'1','X'),0,'Y') -> REPLACE(REPLACE(TO_CHAR(col),'1','X'),'0','Y') for NUMBER columns
--   CONCAT('Details: ',servername) -> 'Details: ' || servername
--   MONTH(date_value) -> EXTRACT(MONTH FROM date_value)
--   DATE_SUB(NOW(), INTERVAL N MONTH) -> ADD_MONTHS(SYSDATE, -N)
--   CONCAT(a,',',b,...) -> TO_CHAR(a) || ',' || TO_CHAR(b) || ...

-- Security Scoring Per Servername
SELECT
    REPLACE(REPLACE(TO_CHAR(legacy_server),     '1','YES'),'0','NO'),
    REPLACE(REPLACE(TO_CHAR(exception_detected),'1','YES'),'0','NO'),
    compliance_score_total,
    date_value,
    'Details: ' || servername,
    servername,
    environment,
    REPLACE(REPLACE(TO_CHAR(configoptions),     '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(dbproperties),      '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(auditlevel),        '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(encryption),        '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(groups),            '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(guestconnect),      '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(logins),            '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(orphanedusers),     '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(publicpermission),  '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(registryinfo),      '1','OK'),'0','NOK'),
    REPLACE(REPLACE(TO_CHAR(sqlserveraudit),    '1','OK'),'0','NOK')
FROM mssql_security_scoring;

-- Area Chart PROD - Average Security Scoring (last 7 months)
SELECT TO_CHAR(a.compliance_score_total) || ',' || TO_CHAR(b.compliance_score_total) || ',' || TO_CHAR(c.compliance_score_total) || ',' || TO_CHAR(d.compliance_score_total) || ',' || TO_CHAR(e.compliance_score_total) || ',' || TO_CHAR(f.compliance_score_total) || ',' || TO_CHAR(g.compliance_score_total)
FROM
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-6))) a,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-5))) b,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-4))) c,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-3))) d,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-2))) e,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-1))) f,
    (SELECT AVG(compliance_score_total) AS compliance_score_total FROM mssql_security_scoring WHERE environment='PRD') g;

-- Area Chart NON PROD - Average Security Scoring (last 7 months)
SELECT TO_CHAR(a.compliance_score_total) || ',' || TO_CHAR(b.compliance_score_total) || ',' || TO_CHAR(c.compliance_score_total) || ',' || TO_CHAR(d.compliance_score_total) || ',' || TO_CHAR(e.compliance_score_total) || ',' || TO_CHAR(f.compliance_score_total) || ',' || TO_CHAR(g.compliance_score_total)
FROM
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-6))) a,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-5))) b,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-4))) c,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-3))) d,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-2))) e,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM mssql_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-1))) f,
    (SELECT AVG(compliance_score_total) AS compliance_score_total FROM mssql_security_scoring WHERE environment != 'PRD') g;
