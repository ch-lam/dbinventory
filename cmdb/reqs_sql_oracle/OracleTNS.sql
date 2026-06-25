-- Source: OracleTNS.php
-- Oracle version: CONCAT() -> || operator; TO_CHAR(tcp_port) since tcp_port is NUMBER

SELECT DISTINCT UPPER(service_name),
       'FireFlow GRP',
       'jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=' || primary_hst || ')(PORT=' || TO_CHAR(tcp_port) || '))(CONNECT_DATA=(SERVICE_NAME=' || service_name || ')))',
       service_name || '=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=' || primary_hst || ')(PORT=' || TO_CHAR(tcp_port) || '))(CONNECT_DATA=(SERVICE_NAME=' || service_name || ')))'
FROM oracle_jdbc_tns;
