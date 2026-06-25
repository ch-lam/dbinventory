-- Source: OraclePatchingReleaseSupport.php
-- Oracle version: CURDATE() -> TRUNC(SYSDATE); SUBSTR() is identical in Oracle

-- Oracle Infrastructure Release Used
select type,
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
 where type = 'ORACLE'
union all
select 'ORACLE',
       db_version,
       'NOT REGISTER IN CMDB',
       'OUT OF SUPPORT'
  from oracle_database_list
 where db_version not in (
   select version
     from product_support
    where type = 'ORACLE'
);

-- PDB Infrastructure Support State
select distinct case
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'D' then
      'DEV'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'T' then
      'TST'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'V' then
      'INT'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'U' then
      'UAT'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'P' then
      'PRD'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'A' then
      'TAT'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'R' then
      'DRE'
   when substr(
      a.pdb_name,
      4,
      1
   ) = 'S' then
      'SNAPSHOT'
   else
      'UNKNOWN'
                end as env,
                substr(
                   a.pdb_name,
                   6,
                   30
                ),
                b.db_version,
                case
                   when b.db_version in (
                      select version
                        from product_support
                       where type = 'ORACLE'
                         and end_of_support_date < trunc(sysdate)
                   ) then
                      'OUT OF SUPPORT'
                   else
                      'SUPPORTED'
                end as supported_state,
                a.pdb_name
  from oracle_pdbs a,
       oracle_database_list b
 where a.instance_name = b.instance_name
 order by 2,
          1,
          3;

-- Non Container Infrastructure Support State
select x.environment,
       x.db_version,
       x.db_name,
       x.supported_state
  from (
   select distinct a.db_name,
                   a.environment,
                   a.db_version,
                   case
                      when a.db_version in (
                         select version
                           from product_support
                          where type = 'ORACLE'
                            and end_of_support_date < trunc(sysdate)
                      ) then
                         'OUT OF SUPPORT'
                      else
                         'SUPPORTED'
                   end as supported_state
     from oracle_database_list a
    where a.database_type = 'NON_CONTAINER'
      and db_role = 'PRIMARY'
    order by 2,
             1,
             3
) x;