/*
** Create MONITORING user for Zabbix collector to be deployed in all oracle databases
** (it should be part of post deployment template after a new cdb/pdb, this script if for 
**  manual deployment only and documentation purposes).
*/
-- create monitoring profile to avoid password lock
create profile MONITORING limit PASSWORD_LIFE_TIME UNLIMITED;

-- Create user and privs.
create user MONITORING identified by "*******************************" -- use secret server to retreive correct value.
       profile MONITORING;
grant create session to MONITORING;
grant SELECT_CATALOG_ROLE to MONITORING;

-- create view as X$ cannot be granted directly, then grant select on view
create view vw_x$dbgalertext as select * from sys.x$dbgalertext;
grant select on vw_x$dbgalertext to MONITORING;

-- In case MONITORING user password expired (prior to profile creation)
create profile MONITORING limit PASSWORD_LIFE_TIME UNLIMITED;
alter user MONITORING profile MONITORING;
alter user MONITORING identified by "*******************************" account unlock;