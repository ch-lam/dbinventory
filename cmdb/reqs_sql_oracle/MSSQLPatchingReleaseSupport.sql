-- Source: MSSQLPatchingReleaseSupport.php
-- Oracle version: CURDATE() -> TRUNC(SYSDATE)

-- MSSQL Infrastructure Release Used
select "TYPE",
       version,
       to_char(
          end_of_support_date,
          'DD/MM/YYYY'
       ) end_of_support_date,
       case
          when end_of_support_date > trunc(sysdate) then
             'SUPPORTED'
          else
             'OUT OF SUPPORT'
       end as supported_state
  from product_support
 where type = 'MSSQL'
union all
select 'MSSQL',
       mssql_product_version,
       'NOT REGISTER IN CMDB',
       'OUT OF SUPPORT'
  from mssql_hosts
 where mssql_product_version not in (
   select version
     from product_support
    where type = 'MSSQL'
);

-- MSSQL Infrastructure Support State (per database)
select ct.env,
       ct.hostname,
       upper(ct.database_name),
       hst.mssql_product_version,
       case
          when hst.mssql_product_version in (
             select version
               from product_support
              where type = 'MSSQL'
                and end_of_support_date < trunc(sysdate)
          ) then
             'OUT OF SUPPORT'
          else
             'SUPPORTED'
       end as supported_state
  from mssql_database ct,
       mssql_hosts hst
 where ct.hostname = hst.hostname
   and ct.database_name not in ( 'master',
                                 'tempdb',
                                 'model',
                                 'dba',
                                 'msdb' );