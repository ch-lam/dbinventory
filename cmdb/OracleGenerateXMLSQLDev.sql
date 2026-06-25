-- Source: OracleGenerateXMLSQLDev.php

SELECT concat('{"name":"',a.service_name,'","type":"jdbc","info":{"role":"","SavePassword":"false","OracleConnectionType":"TNS","RaptorConnectionType":"Oracle","customUrl":"',a.service_name,'","oraDriverType":"thin","NoPasswordConnection":"TRUE","driver":"oracle.jdbc.OracleDriver","subtype":"oraJDBC","OS_AUTHENTICATION":"false","user":"administrator","KERBEROS_AUTHENTICATION":"false","ConnName":"',a.service_name,'"}},')
FROM (SELECT DISTINCT service_name FROM oracle_jdbc_tns) a
UNION ALL
SELECT concat('{"name":"EMPTY","type":"jdbc","info":{"role":"","SavePassword":"false","OracleConnectionType":"TNS","RaptorConnectionType":"Oracle","customUrl":"EMPTY","oraDriverType":"thin","NoPasswordConnection":"TRUE","driver":"oracle.jdbc.OracleDriver","subtype":"oraJDBC","OS_AUTHENTICATION":"false","user":"administrator","KERBEROS_AUTHENTICATION":"false","ConnName":"EMPTY"}}')
FROM dual;
