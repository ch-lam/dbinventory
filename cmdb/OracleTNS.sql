-- Source: OracleTNS.php

SELECT DISTINCT upper(service_name),
       'FireFlow GRP',
       concat('jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=',primary_hst,')(PORT=',tcp_port,'))(CONNECT_DATA=(SERVICE_NAME=',service_name,')))'),
       concat(service_name,'=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=',primary_hst,')(PORT=',tcp_port,'))(CONNECT_DATA=(SERVICE_NAME=',service_name,')))')
FROM oracle_jdbc_tns;
