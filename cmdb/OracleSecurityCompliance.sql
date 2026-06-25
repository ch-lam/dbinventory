-- Source: OracleSecurityCompliance.php

-- Security Scoring Per Database
SELECT compliance_score_total,
       date_value,
       concat('Details: ', db_name),
       db_name,
       environment,
       replace(replace(audit_enable_score,          '1','OK'),0,'NOK'),
       replace(replace(security_parameter_score,    '1','OK'),0,'NOK'),
       replace(replace(security_profile_score,      '1','OK'),0,'NOK'),
       replace(replace(admin_high_privs_score,      '1','OK'),0,'NOK'),
       replace(replace(default_user_pwd_score,      '1','OK'),0,'NOK'),
       replace(replace(default_profile_score,       '1','OK'),0,'NOK'),
       replace(replace(encrypted_tablespace_score,  '1','OK'),0,'NOK'),
       replace(replace(network_encryption_score,    '1','OK'),0,'NOK'),
       replace(replace(high_role_privs_score,       '1','OK'),0,'NOK'),
       replace(replace(high_sys_privs_score,        '1','OK'),0,'NOK'),
       replace(replace(high_tab_privs_score,        '1','OK'),0,'NOK')
FROM oracle_security_scoring;

-- Area Chart PROD - Average Security Scoring (last 7 months)
SELECT concat(a.compliance_score_total,',',b.compliance_score_total,',',c.compliance_score_total,',',d.compliance_score_total,',',e.compliance_score_total,',',f.compliance_score_total,',',g.compliance_score_total)
FROM
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) a,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) b,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) c,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) d,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) e,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment='PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) f,
    (SELECT avg(compliance_score_total) AS compliance_score_total FROM oracle_security_scoring WHERE environment='PRD') g;

-- Area Chart NONPROD - Average Security Scoring (last 7 months)
SELECT concat(a.compliance_score_total,',',b.compliance_score_total,',',c.compliance_score_total,',',d.compliance_score_total,',',e.compliance_score_total,',',f.compliance_score_total,',',g.compliance_score_total)
FROM
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) a,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) b,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) c,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) d,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) e,
    (SELECT CASE WHEN avg(compliance_score_total) IS NULL THEN '0' ELSE avg(compliance_score_total) END AS compliance_score_total FROM oracle_security_history WHERE environment<>'PRD' AND MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) f,
    (SELECT avg(compliance_score_total) AS compliance_score_total FROM oracle_security_scoring WHERE environment<>'PRD') g;
