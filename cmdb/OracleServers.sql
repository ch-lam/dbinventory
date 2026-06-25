-- Source: OracleServers.php

SELECT a.hostname, a.num_cpus, a.memory_gb, a.os_type, a.environment, a.license_type, b.comment
FROM oracle_hosts a, chl_ipam_comment b
WHERE upper(a.hostname) = upper(b.hostname)
UNION ALL
SELECT a.hostname, a.num_cpus, a.memory_gb, a.os_type, a.environment, a.license_type, 'NOT IN IPAM'
FROM oracle_hosts a
WHERE upper(a.hostname) NOT IN (SELECT upper(hostname) FROM chl_ipam_comment)
ORDER BY hostname;
