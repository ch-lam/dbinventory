-- Source: MSSQLServers.php
-- Oracle version:
--   comment -> comments in chl_ipam_comment
--   CONCAT('/', SUBSTRING_INDEX(hostname,'/',-1)) -> '/[^/]*$' regexp
--   REPLACE(hostname, concat(...), '') -> REGEXP_REPLACE(hostname, '/[^/]*$', '')
--     extracts the base hostname before the last '/' (e.g. 'HOST/INSTANCE' -> 'HOST')

select ct.hostname,
       ct.env,
       ct.license_type,
       case
          when ct.mssql_edition like '%Enterprise%' then
             'Enterprise Edition'
          when ct.mssql_edition like '%Standard%' then
             'Standard Edition'
          when ct.mssql_edition like '%Developer%' then
             'Developer Edition'
          when ct.mssql_edition like '%Express%' then
             'Express Edition'
          else
             'Not Standard Nor Enterprise'
       end as mssql_edition,
       ct.mssql_product_version,
       ct.collation,
       ct.os_type,
       ct.is_clustered,
       ct.activenodename,
       ct.num_cpus,
       ct.memory_gb,
       ct.service_account,
       ipa.comments
  from mssql_hosts ct,
       chl_ipam_comment ipa
 where upper(regexp_replace(
   ct.hostname,
   '/[^/]*$',
   ''
)) = upper(ipa.hostname);
-- UNION different types to check ...
select ct.hostname,
       ct.env,
       ct.license_type,
       case
          when ct.mssql_edition like '%Enterprise%' then
             'Enterprise Edition'
          when ct.mssql_edition like '%Standard%' then
             'Standard Edition'
          when ct.mssql_edition like '%Developer%' then
             'Developer Edition'
          when ct.mssql_edition like '%Express%' then
             'Express Edition'
          else
             'Not Standard Nor Enterprise'
       end as mssql_edition,
       ct.mssql_product_version,
       ct.collation,
       ct.os_type,
       ct.is_clustered,
       ct.activenodename,
       ct.num_cpus,
       ct.memory_gb,
       ct.service_account,
       'NOT IN IPAM'
  from mssql_hosts ct
 where upper(regexp_replace(
   ct.hostname,
   '/[^/]*$',
   ''
)) not in (
   select upper(hostname)
     from chl_ipam_comment
);