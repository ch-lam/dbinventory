-- Source: OracleGenerateTNS.php
-- Oracle version:
--   CONCAT() -> || operator
--   TO_CHAR(tcp_port) because tcp_port is NUMBER(5)
--   tcp_port comparisons use numeric literals (not strings)

SELECT DISTINCT a.tns
FROM (
    SELECT UPPER(service_name) || '=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=' || primary_hst || ')(PORT=' || TO_CHAR(tcp_port) || '))(CONNECT_DATA=(SERVICE_NAME=' || service_name || ')))' AS tns
    FROM oracle_jdbc_tns
    WHERE tcp_port <> 1601
      AND tcp_port <> 1613
      AND tcp_port <> 1530
      AND service_name NOT LIKE 'PDB%'
    UNION ALL
    SELECT UPPER(service_name) || '=(DESCRIPTION_LIST = (FAILOVER = ON)(LOAD_BALANCE = OFF)(DESCRIPTION =(CONNECT_TIMEOUT = 20)(ADDRESS = (PROTOCOL = TCP)(HOST = ' || primary_hst || ')(PORT = ' || TO_CHAR(tcp_port) || '))(CONNECT_DATA = (SERVICE_NAME = ' || service_name || ')))(DESCRIPTION =(CONNECT_TIMEOUT = 20)(RETRY_COUNT = 2)(ADDRESS = (PROTOCOL = TCP)(HOST = ' || standby_hst || ')(PORT = ' || TO_CHAR(tcp_port) || '))(CONNECT_DATA = (SERVICE_NAME = ' || service_name || '))))' AS tns
    FROM oracle_jdbc_tns
    WHERE standby_hst <> 'EMPTY'
      AND service_name NOT LIKE 'PDB%'
      AND tcp_port IN (1601,1613,1530)
) a
ORDER BY tns;
