-- Source: OracleServers.php
-- Oracle version: column renamed comment -> comments in chl_ipam_comment

select a.hostname,
       a.num_cpus,
       a.memory_gb,
       a.os_type,
       a.environment,
       a.license_type,
       b.comments
  from oracle_hosts a,
       chl_ipam_comment b
 where upper(a.hostname) = upper(b.hostname);
-- UNION ALL all types differ
select a.hostname,
       a.num_cpus,
       a.memory_gb,
       a.os_type,
       a.environment,
       a.license_type,
       'NOT IN IPAM'
  from oracle_hosts a
 where upper(a.hostname) not in (
   select upper(hostname)
     from chl_ipam_comment
)
 order by hostname;