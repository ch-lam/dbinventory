-- Source: OracleSecurityCompliance.php
-- Oracle version:
--   'Details: ' || db_name  (CONCAT -> ||)
--   REPLACE(REPLACE(TO_CHAR(score),'1','OK'),'0','NOK') for NUMBER(2) columns
--   MONTH(date_value) -> EXTRACT(MONTH FROM date_value)
--   DATE_SUB(NOW(), INTERVAL N MONTH) -> ADD_MONTHS(SYSDATE, -N)
--   CONCAT(a,',',b,...) -> TO_CHAR(a) || ',' || TO_CHAR(b) || ...

-- Security Scoring Per Database
SELECT compliance_score_total,
       date_value,
       'Details: ' || db_name,
       db_name,
       environment,
       REPLACE(REPLACE(TO_CHAR(audit_enable_score),          '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(security_parameter_score),    '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(security_profile_score),      '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(admin_high_privs_score),      '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(default_user_pwd_score),      '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(default_profile_score),       '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(encrypted_tablespace_score),  '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(network_encryption_score),    '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(high_role_privs_score),       '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(high_sys_privs_score),        '1','OK'),'0','NOK'),
       REPLACE(REPLACE(TO_CHAR(high_tab_privs_score),        '1','OK'),'0','NOK')
FROM oracle_security_scoring;

-- Area Chart PROD - Average Security Scoring (last 7 months)
SELECT TO_CHAR(a.compliance_score_total) || ',' || TO_CHAR(b.compliance_score_total) || ',' || TO_CHAR(c.compliance_score_total) || ',' || TO_CHAR(d.compliance_score_total) || ',' || TO_CHAR(e.compliance_score_total) || ',' || TO_CHAR(f.compliance_score_total) || ',' || TO_CHAR(g.compliance_score_total)
FROM
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-6))) a,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-5))) b,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-4))) c,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-3))) d,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-2))) e,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-1))) f,
    (SELECT AVG(compliance_score_total) AS compliance_score_total FROM oracle_security_scoring WHERE environment='PRD') g;

-- Area Chart NONPROD - Average Security Scoring (last 7 months)
SELECT TO_CHAR(a.compliance_score_total) || ',' || TO_CHAR(b.compliance_score_total) || ',' || TO_CHAR(c.compliance_score_total) || ',' || TO_CHAR(d.compliance_score_total) || ',' || TO_CHAR(e.compliance_score_total) || ',' || TO_CHAR(f.compliance_score_total) || ',' || TO_CHAR(g.compliance_score_total)
FROM
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-6))) a,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-5))) b,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-4))) c,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-3))) d,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-2))) e,
    (SELECT CASE WHEN AVG(compliance_score_total) IS NULL THEN 0 ELSE AVG(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND EXTRACT(MONTH FROM date_value)=EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,-1))) f,
    (SELECT AVG(compliance_score_total) AS compliance_score_total FROM oracle_security_scoring WHERE environment<>'PRD') g;
