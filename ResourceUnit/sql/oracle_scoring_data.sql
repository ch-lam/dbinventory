#################START SCORING LMS
update inventory.oracle_lms set db_pdb_name=db_name where db_pdb_name not like 'PDB%';

#Cleanup .Oracle Gateway for ODBC - RETRODEV
delete from oracle_lms where product_name='.Database Gateway' and db_name='RETRODEV';

#Cleanup some wrong return about RAC/RacOneNode
create table oracle_lms_temp as select db_name from oracle_lms where product_name='Real Application Clusters One Node' and usage_detected='CURRENT_USAGE';
delete from oracle_lms where product_name='Real Application Clusters' and usage_detected='CURRENT_USAGE' and db_name in (select db_name from oracle_lms_temp);
drop table oracle_lms_temp;
update oracle_lms set product_name='Real Application Clusters One Node' where product_name='Real Application Clusters' and usage_detected='CURRENT_USAGE' and db_name in (select db_name from oracle_database_list where license_type='CPU' and db_version='11.2.0.4.0');
update oracle_lms set product_name='Real Application Clusters One Node', usage_detected='CURRENT_USAGE'  where product_name='Real Application Clusters' and usage_detected='PAST_USAGE' and db_name in (select db_name from oracle_database_list where license_type='CPU');
delete from oracle_lms where product_name='Real Application Clusters One Node' and usage_detected='PAST_USAGE' and db_name in (select db_name from oracle_database_list where license_type='FSIP');

#Cleanup wrong result 19c - Multinenant CPU
update oracle_lms set usage_detected='NO_USAGE' where product_name='Multitenant' and db_name in (select db_name from oracle_database_list where db_version like '19%' and license_type='CPU');

#Cleanup Cloud Control PDB Adavanced Compression detected
delete from oracle_lms where DB_NAME='O11W001P' and (db_pdb_name='O11W001P' or db_pdb_name='PDBP_OEM') and product_name='Advanced Compression';

#################END SCORING LMS


##################START SCORING CAPACITY PLANNING
#####Scoring ENV DBSIZE
update oracle_database_capacity_planning_dbsize a, oracle_database_list b set a.environment=b.environment where a.db_name=b.db_name;

#####Scoring Segment SIZE
update oracle_database_capacity_planning_dbsize a, oracle_database_capacity_planning_dbsize_segs b set a.sum_segment_mb=b.sum_segment_mb where a.db_name=b.db_name and a.pdb_name=b.pdb_name and a.tablespace_name=b.tablespace_name;


#####Scoring History DBSIZE
insert into oracle_database_capacity_planning_dbsize_history (db_name,pdb_name,environment,tablespace_name,size_mb,sum_segment_mb) select db_name,pdb_name,environment,tablespace_name,size_mb,sum_segment_mb from oracle_database_capacity_planning_dbsize;
delete from oracle_database_capacity_planning_dbsize_history where date_value <= NOW() - INTERVAL 9 MONTH;


#####Scoring ENV MEM/CPU
update oracle_database_capacity_planning_cpu_mem a, oracle_database_capacity_planning_dbsize b set a.environment=b.environment where a.pdb_name=b.pdb_name;

#####Scoring History MEM/CPU
insert into oracle_database_capacity_planning_cpu_mem_history (pdb_name,environment,cpu_time_minutes,avg_sga_mb,avg_pga_mb,avg_buffer_cache_mb,avg_shared_pool_mb) select pdb_name,environment,cpu_time_minutes,avg_sga_mb,avg_pga_mb,avg_buffer_cache_mb,avg_shared_pool_mb from oracle_database_capacity_planning_cpu_mem;
delete from oracle_database_capacity_planning_cpu_mem_history where date_value <= NOW() - INTERVAL 9 MONTH;


#####Scoring oracle_database_capacity_planning_summary
truncate table oracle_database_capacity_planning_summary;
insert into oracle_database_capacity_planning_summary(db_name,pdb_name,environment,size_mb) select db_name,pdb_name,environment,sum(size_mb) from oracle_database_capacity_planning_dbsize group by db_name,pdb_name,environment;

update oracle_database_capacity_planning_summary a, oracle_database_capacity_planning_cpu_mem b
set a.cpu_time_minutes=b.cpu_time_minutes
where a.pdb_name=b.pdb_name;

update oracle_database_capacity_planning_summary a, oracle_database_capacity_planning_cpu_mem b
set a.avg_sga_mb=b.avg_sga_mb
where a.pdb_name=b.pdb_name;

update oracle_database_capacity_planning_summary a, oracle_database_capacity_planning_cpu_mem b
set a.avg_pga_mb=b.avg_pga_mb
where a.pdb_name=b.pdb_name;

update oracle_database_capacity_planning_summary a, oracle_database_capacity_planning_cpu_mem b
set a.avg_buffer_cache_mb=b.avg_buffer_cache_mb
where a.pdb_name=b.pdb_name;

update oracle_database_capacity_planning_summary a, oracle_database_capacity_planning_cpu_mem b
set a.avg_shared_pool_mb=b.avg_shared_pool_mb
where a.pdb_name=b.pdb_name;

##PURGE CPU PER SERVICE
delete from oracle_database_capacity_planning_cpu_service_history where date_value <= NOW() - INTERVAL 9 MONTH;

#################END SCORINGCAPACITY PLANNING

#################START SCORING AUDIT LOGON
##Flag Logon Toad and SQLDev
update `oracle_audit_logon` set expected_logon=1 where lower(client_name) like '%toad%' or lower(client_name) like '%sql dev%';

##Exclude RO user
update `oracle_audit_logon` set expected_logon=0 where lower(db_username) like '%_RO';

##LOAD HISTORY TABLE
insert into oracle_audit_logon_history(db_name,logon_time,db_username,os_username,host_client,client_name) select db_name,logon_time,db_username,os_username,host_client,client_name from oracle_audit_logon where expected_logon=1 and concat(db_name,logon_time,db_username,os_username,host_client,client_name) not in (select concat(db_name,logon_time,db_username,os_username,host_client,client_name) from oracle_audit_logon_history);
delete from oracle_audit_logon_history where cast(logon_time as date) <= NOW() - INTERVAL 9 MONTH;

##Exclude ASE
update oracle_audit_logon set expected_logon=0 where upper(os_username) in ('XRY2F','XRW6T','XRU9Y','XS14D','XS08Y','EQU6J','XR49T','E2410','E3941','EF182','ERP1H','ERH9C','ERA39','XRB55','XRX85','XS324','E4775','EJ142','XS09E','XS19C','XS25A','XRC6S','XI353','XRA0P','XRH6H','XS03Z','XS20G','ED458','XRD46','XS27N','ERM8I','XM572','XRX58','EM020','XRD5A','ERC3C','XRX31','E4809','ERI49','ERD22','XRV15','E5864','XRT0U','XE967','XRA0R','XRY2Z','EQP7P','ER53V','XRM1A','XRP0J','XRI9Z','XRM7T','ERD1D','ERP49','XRX62','XS07Q','ERD1A','ERD1C','ERD1B','ERE0I','ERG00','ERS02');
update oracle_audit_logon set expected_logon=0 where upper(os_username) in ('CNXRY2F','CNXRW6T','CNXRU9Y','CNXS14D','CNXS08Y','CNEQU6J','CNXR49T','CNE2410','CNE3941','CNEF182','CNERP1H','CNERH9C','CNERA39','CNXRB55','CNXRX85','CNXS324','CNE4775','CNEJ142','CNXS09E','CNXS19C','CNXS25A','CNXRC6S','CNXI353','CNXRA0P','CNXRH6H','CNXS03Z','CNXS20G','CNED458','CNXRD46','CNXS27N','CNERM8I','CNXM572','CNXRX58','CNEM020','CNXRD5A','CNERC3C','CNXRX31','CNE4809','CNERI49','CNERD22','CNXRV15','CNE5864','CNXRT0U','CNXE967','CNXRA0R','CNXRY2Z','CNEQP7P','CNER53V','CNXRM1A','CNXRP0J','CNXRI9Z','CNXRM7T','CNERD1D','CNERP49','CNXRX62','CNXS07Q','CNERD1A','CNERD1C','CNERD1B','CNERE0I','CNERG00','CNERS02');

#################END SCORING LOGON

#################START SCORING JDBC
###LOAD TABLE
truncate table inventory.oracle_jdbc_tns;
insert into inventory.oracle_jdbc_tns (service_name, easy_connect_tns,db_name)
SELECT distinct a.service_name as 'service_name', SUBSTRING_INDEX(b.easy_connect_tns,'/',1) as 'easy_connect_tns',b.db_name as 'db_name'
FROM inventory.oracle_services a, inventory.oracle_database_list b
where a.instance_name=b.instance_name
and a.service_name not like '%XDB'
UNION ALL
SELECT distinct a.pdb_name as 'service_name', SUBSTRING_INDEX(b.easy_connect_tns,'/',1) as 'easy_connect_tns',b.db_name as 'db_name'
FROM inventory.oracle_pdbs a, inventory.oracle_database_list b
where a.instance_name=b.instance_name
UNION ALL
SELECT db_unique_name as 'service_name', SUBSTRING_INDEX(easy_connect_tns,'/',1) as 'easy_connect_tns',db_name as 'db_name'
FROM inventory.oracle_database_list
where database_type='CONTAINER'
UNION ALL
SELECT db_unique_name as 'service_name', SUBSTRING_INDEX(easy_connect_tns,'/',1) as 'easy_connect_tns',db_name as 'db_name'
FROM inventory.oracle_database_list
where database_type='NON_CONTAINER'
AND db_role='PHYSICAL STANDBY';


###UPDATE oracle_jdbc_tns
update inventory.oracle_jdbc_tns
set tcp_port=substring_index(easy_connect_tns,':',-1),
standby_hst='EMPTY',
primary_hst=substring_index(easy_connect_tns,':',1);

##COMMIT
commit;

#################END SCORING JDBC


#################START SCORING SECURITY

######Cleanup Scoring Result
truncate table oracle_security_scoring;

######Scoring oracle_security_admin_high_privs
update oracle_security_admin_high_privs set compliance_score=1 where username='SYS';
update oracle_security_admin_high_privs set compliance_score=1 where username='SYSADMIN';
update oracle_security_admin_high_privs set compliance_score=1 where username='SYSBACKUP';
update oracle_security_admin_high_privs set compliance_score=1 where username='SYSDG';
update oracle_security_admin_high_privs set compliance_score=1 where username='SYSKM';
update oracle_security_admin_high_privs set compliance_score=1 where username='SYSMONITOR';
update oracle_security_admin_high_privs set compliance_score=1 where username='VPCBIL';
update oracle_security_admin_high_privs set compliance_score=1 where username='C##AUTOMATION';
update oracle_security_admin_high_privs set compliance_score=1 where username in ('C##GOLIVE_DRE','C##LOCAL_CLONE','C##CLONE_T24_PDB_FOR_COB');
update oracle_security_admin_high_privs a set a.compliance_score=1 where a.db_name in (select db_name from oracle_security_admin_high_privs_exception where username = a.username);
insert into oracle_security_scoring (db_name,admin_high_privs_score) select distinct db_name,1 from oracle_security_admin_high_privs where compliance_score=1 and db_name not in (select db_name from oracle_security_admin_high_privs where compliance_score=0);
insert into oracle_security_scoring (db_name,admin_high_privs_score) select distinct db_name,0 from oracle_security_admin_high_privs where db_name in (select db_name from oracle_security_admin_high_privs where compliance_score=0);
commit;


######Scoring oracle_security_audit_enable
update oracle_security_audit_enable set compliance_score=1 where audit_activated=1;
update oracle_security_scoring set audit_enable_score=1 where db_name not in (select distinct db_name from oracle_security_audit_enable where compliance_score=0);
commit;

######Scoring oracle_security_default_profile
update oracle_security_default_profile set compliance_score=1 where profile <> 'DEFAULT';
update oracle_security_default_profile set compliance_score=1 where profile='DEFAULT' and username='XS$NULL';
update oracle_security_scoring set default_profile_score=1 where db_name not in (select distinct db_name from oracle_security_default_profile where compliance_score=0);
commit;


######Scoring oracle_security_default_user_pwd
update oracle_security_scoring set default_user_pwd_score=1 where db_name not in (select distinct db_name from oracle_security_default_user_pwd);
commit;


######Scoring oracle_security_high_role_privs
####Exception Temporary until solved by Security
truncate table oracle_security_high_role_privs_exception;
#insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'CHL TEMP - EXCEPTION' from oracle_security_high_role_privs;
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed By Application AAA for deployment' from oracle_security_high_role_privs where privilege='DBA' and username='AAASYS';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed By Application FERMAT for deployment' from oracle_security_high_role_privs where privilege='DBA' and username='FERMAT_LUX';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed By Application FRS for deployment' from oracle_security_high_role_privs where privilege='DBA' and username='FRS_INSTALL';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed By Application SAFEWATCH for deployment' from oracle_security_high_role_privs where privilege='DBA' and username='SCDB';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed By Application SAFEWATCH for deployment' from oracle_security_high_role_privs where privilege='DBA' and username='SWSERVER';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed By Application TRT for deployment' from oracle_security_high_role_privs where privilege='DBA' and username='TRT_NEW';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Users was used by DBA DEV/PROD to manage all Oracle databases - Password know only by DBA' from oracle_security_high_role_privs where privilege='DBA' and username in ('C##DBADEV','C##DBAPROD','C##ER89J','C##ERI6D','C##XRV4S');
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed by DBA and ASE to be able to deploy release through FlyWay - Password know only by DBA' from oracle_security_high_role_privs where privilege='DBA' and username='DBA_DEPLOY';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'Needed by DBA and ASE to be able to managed audit of application - Password know only by DBA' from oracle_security_high_role_privs where privilege='DBA' and username='ELLIPSYS';
insert into oracle_security_high_role_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'CHL TEMP - EXCEPTION' from oracle_security_high_role_privs where concat(db_name,pdb_name,username,privilege) not in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_role_privs_exception);
commit;


update oracle_security_high_role_privs set compliance_score=1 where username in ('SYSTEM','SYSMAN','SYSBACKUP','SYS','SQLT_USER_ROLE','SQLTXADMIN','OLAP_USER','OLAP_DBA','OEM_MONITOR','IMP_FULL_DATABASE','EXP_FULL_DATABASE','DBSNMP','DBA');
update oracle_security_high_role_privs set compliance_score=1 where concat(db_name,pdb_name,username,privilege) in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_role_privs_exception);
update oracle_security_scoring set high_role_privs_score=1 where db_name not in (select distinct db_name from oracle_security_high_role_privs where compliance_score=0);
commit;

######Scoring oracle_security_high_sys_privs
####Exception Temporary until solved by Security
truncate table oracle_security_high_sys_privs_exception;
insert into oracle_security_high_sys_privs_exception (db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'CHL TEMP - EXCEPTION' from oracle_security_high_sys_privs;
commit;


update oracle_security_high_sys_privs set compliance_score=1 where username in ('XDB','WMSYS','SYSTEM','SYSRAC','SYSMAN','SYS','SYSBACKUP','SYSDG','SQLTXADMIN','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','OEM_MONITOR','OLAPSYS','OLAP_DBA','ORACLE_OCM','ORDPLUGINS','ORDSYS','MDSYS','IMP_FULL_DATABASE','GSMADMIN_INTERNAL','GSMADMIN_ROLE','GSMUSER','GGSYS','EXP_FULL_DATABASE','DVSYS','DMSYS','DBSNMP','DBA','AUDIT_ADMIN','DATAPUMP_IMP_FULL_DATABASE','EM_EXPRESS_ALL');
update oracle_security_high_sys_privs set compliance_score=1 where concat(db_name,pdb_name,username,privilege) in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_sys_privs_exception);
update oracle_security_scoring set high_sys_privs_score=1 where db_name not in (select distinct db_name from oracle_security_high_sys_privs where compliance_score=0);
commit;

######Scoring oracle_security_high_tab_privs
####Exception Temporary until solved by Security
truncate table oracle_security_high_tab_privs_exception;
insert into oracle_security_high_tab_privs_exception(db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'DBA INFRA TEMP - EXCEPTION' from oracle_security_high_tab_privs where privilege not like '%INHERIT%';
commit;

####Exception for INHERIT TO PUBLIC
insert into oracle_security_high_tab_privs_exception(db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'DBA INFRA - EXCEPTION ADMIN OR INTERNAL USER' from oracle_security_high_tab_privs where privilege like '%INHERIT%' and USERNAME in ('C##AUTOMATION','C##CLONE_T24_PDB_FOR_COB','C##CMUMONITOR','C##DBADEV','C##DBAPROD','C##DBA_TOOLS','C##ER606','C##ER89J','C##ERI6D','C##ERI7D','C##GLOBALCMU','C##GOLIVE_DRE','C##GOLIVE_EXACC_FAST_REFRESH','C##LOCAL_CLONE','C##PROXY_PDB','C##USER_DB_LINK','C##USER_DB_LINK_TRM','C##XRV4S','DBA_DEPLOY','DBA_TOOLBOX','XS$NULL','PUBLIC','AUDIT_MGMT','INTF_EODS','XDB','WMSYS','SYSTEM','SYSRAC','SYSMAN','SYS','SYSBACKUP','SYSDG','SQLTXADMIN','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','OEM_MONITOR','OLAPSYS','OLAP_DBA','ORACLE_OCM','ORDPLUGINS','ORDSYS','MDSYS','IMP_FULL_DATABASE','GSMADMIN_INTERNAL','GSMADMIN_ROLE','GSMUSER','GGSYS','EXP_FULL_DATABASE','DVSYS','DMSYS','DBSNMP','DBA','AUDIT_ADMIN','DATAPUMP_IMP_FULL_DATABASE','EM_EXPRESS_ALL','DPADMIN');
insert into oracle_security_high_tab_privs_exception(db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'DBA INFRA - EXCEPTION ADMIN OR INTERNAL USER' from oracle_security_high_tab_privs where privilege like '%INHERIT%' and USERNAME  like 'ADMIN_PDB%';

###TEMPORARY EXCEPTION FOR AAA Application - 26_02_2025 - JRAGUENEAU
#insert into oracle_security_high_tab_privs_exception(db_name,pdb_name,username,privilege,comment) select db_name,pdb_name,username,privilege,'DBA INFRA - AAA ISSUE KNOW ISSUE' from oracle_security_high_tab_privs where privilege like '%INHERIT%' and pdb_name  like '%AAA%';
commit;


update oracle_security_high_tab_privs set compliance_score=1 where concat(db_name,pdb_name,username,privilege) in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_tab_privs_exception);
update oracle_security_scoring set high_tab_privs_score=1 where db_name not in (select distinct db_name from oracle_security_high_tab_privs where compliance_score=0);
commit;


######Scoring oracle_security_parameter
update oracle_security_parameter set compliance_score=1 where parameter_name='AUDIT_SYS_OPERATIONS' and parameter_value='TRUE';
update oracle_security_parameter set compliance_score=1 where parameter_name='O7_DICTIONARY_ACCESSIBILITY' and parameter_value='FALSE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='SEC_RETURN_SERVER_RELEASE_BANNER' and parameter_value='FALSE';
update oracle_security_parameter set compliance_score=1 where parameter_name='REMOTE_OS_AUTHENT' and parameter_value='FALSE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='REMOTE_OS_ROLES' and parameter_value='FALSE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='OS_ROLES' and parameter_value='FALSE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='AUDIT_TRAIL' and parameter_value='DB';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='SEC_MAX_FAILED_LOGIN_ATTEMPTS' and parameter_value='4';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='SEC_PROTOCOL_ERROR_TRACE_ACTION' and parameter_value='LOG';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='UTL_FILE_DIR' and parameter_value not like '*';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='RESOURCE_LIMIT' and parameter_value='TRUE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='SEC_CASE_SENSITIVE_LOGON' and parameter_value='TRUE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='SEC_PROTOCOL_ERROR_FURTHER_ACTION' and parameter_value like '(DROP3)';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='UNIFIED AUDITING' and parameter_value='TRUE';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='UNIFIED AUDITING' and parameter_value='N/A';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='_SYS_LOGON_DELAY' and parameter_value='4';
update oracle_security_parameter set compliance_score=1 where upper(parameter_name)='PDB_OS_CREDENTIAL' and parameter_value<>'EMPTY';
update oracle_security_parameter set compliance_score=1 where concat(db_name,parameter_value,parameter_name) in (select concat(db_name,parameter_value,parameter_name) from oracle_security_parameter_exception);
update oracle_security_scoring set security_parameter_score=1 where db_name not in (select distinct db_name from oracle_security_parameter where compliance_score=0);
commit;



######Scoring oracle_security_profile
delete from oracle_security_profile where resource_name not in ('INACTIVE_ACCOUNT_TIME','FAILED_LOGIN_ATTEMPTS','PASSWORD_LOCK_TIME','PASSWORD_LIFE_TIME','PASSWORD_REUSE_MAX','PASSWORD_REUSE_TIME','PASSWORD_GRACE_TIME','PASSWORD_VERIFY_FUNCTION');
update oracle_security_profile set compliance_score=1 where upper(resource_name)='FAILED_LOGIN_ATTEMPTS' and limit_value='4';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_LOCK_TIME' and limit_value='UNLIMITED';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_LIFE_TIME' and limit_value='90';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_LIFE_TIME' and limit_value='UNLIMITED' and profile in ('SERVICE_PROFILE','SYSTEM_PROFILE','PRIVILEGE_PROFILE','PRIVILEGED_PROFILE','HIGH_PRIV_PROFILE','C##HIGH_PRIV_PROFILE','ADMIN_PROFILE','C##SERVICE_PROFILE','C##SYSTEM_PROFILE','APPLICATIF_PROFILE','C##PRIVILEGED_PROFILE','MGMT_ADMIN_USER_PROFILE','MGMT_INTERNAL_USER_PROFILE');

update oracle_security_profile set compliance_score=1 where upper(resource_name)='INACTIVE_ACCOUNT_TIME' and limit_value='120';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='INACTIVE_ACCOUNT_TIME' and profile='DEFAULT' and limit_value='UNLIMITED';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='INACTIVE_ACCOUNT_TIME' and limit_value='DEFAULT' and profile in ('APPLICATIF_PROFILE','BIL_ADMIN_PROFILE','DEFAULT','PROFIL_USER_LIMIT','SERVICE_PROFILE','SYSTEM_PROFILE','HIGH_PRIV_PROFILE','ORA_STIG_PROFILE','PRIVILEGED_PROFILE','C##HIGH_PRIV_PROFILE','C##SERVICE_PROFILE','C##SYSTEM_PROFILE','C##ORA_STIG_PROFILE','C##PRIVILEGED_PROFILE','MGMT_ADMIN_USER_PROFILE','MGMT_INTERNAL_USER_PROFILE','GSM_PROF');

update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_REUSE_MAX' and limit_value='24';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_REUSE_TIME' and limit_value='720';
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_GRACE_TIME' and limit_value in ('0','1','2','3','4','5');
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_VERIFY_FUNCTION' and limit_value <> 'NULL';
create table oracle_security_profile_temp as select * from oracle_security_profile;
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_REUSE_MAX' and limit_value='DEFAULT' and concat(db_name,pdb_name) in (select concat(db_name,pdb_name) from oracle_security_profile_temp where upper(resource_name)='PASSWORD_REUSE_MAX' and profile='DEFAULT' and limit_value='24');
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_LIFE_TIME' and limit_value='DEFAULT' and concat(db_name,pdb_name) in (select concat(db_name,pdb_name) from oracle_security_profile_temp where upper(resource_name)='PASSWORD_LIFE_TIME' and profile='DEFAULT' and limit_value='90');
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_LOCK_TIME' and limit_value='DEFAULT' and concat(db_name,pdb_name) in (select concat(db_name,pdb_name) from oracle_security_profile_temp where upper(resource_name)='PASSWORD_REUSE_MAX' and profile='PASSWORD_LOCK_TIME' and limit_value='UNLIMITED');
update oracle_security_profile set compliance_score=1 where upper(resource_name)='PASSWORD_REUSE_TIME' and limit_value='DEFAULT' and concat(db_name,pdb_name) in (select concat(db_name,pdb_name) from oracle_security_profile_temp where upper(resource_name)='PASSWORD_REUSE_MAX' and profile='PASSWORD_REUSE_TIME' and limit_value='720');
update oracle_security_profile set compliance_score=1 where upper(resource_name)='FAILED_LOGIN_ATTEMPTS' and limit_value='DEFAULT' and concat(db_name,pdb_name) in (select concat(db_name,pdb_name) from oracle_security_profile_temp where upper(resource_name)='PASSWORD_REUSE_MAX' and profile='FAILED_LOGIN_ATTEMPTS' and limit_value='4');
drop table oracle_security_profile_temp;
update oracle_security_profile set compliance_score=1 where concat(db_name,pdb_name,profile,resource_name,limit_value) in (select concat(db_name,pdb_name,profile,resource_name,limit_value) from oracle_security_profile_exception);
update oracle_security_scoring set security_profile_score=1 where db_name not in (select distinct db_name from oracle_security_profile where compliance_score=0);
commit;

######Update Environment
update oracle_security_scoring a, oracle_database_list b set a.environment=b.environment where a.db_name=b.db_name;
   
#####Scoring Encrypted Tablespace
update oracle_security_tablespace_encrypted a, oracle_database_list b set a.license_type=b.license_type where a.db_name=b.db_name;
update oracle_security_tablespace_encrypted set compliance_score=1 where encrypted='YES';
update oracle_security_tablespace_encrypted set compliance_score=1 where encrypted='NO' and (tablespace_name in ('SYSTEM','SYSAUX','TEMP') or tablespace_name like 'UNDO%' or tablespace_name like '%TEMP%' or tablespace_name like 'TEMP%');
update oracle_security_tablespace_encrypted set compliance_score=1 where encrypted='YES' and tablespace_name in ('TEMP') or tablespace_name like '%TEMP%' or tablespace_name like 'TEMP%';
update oracle_security_tablespace_encrypted set compliance_score=0 where encrypted='YES' and tablespace_name in ('SYSTEM','SYSAUX');
update oracle_security_scoring set encrypted_tablespace_score=1 where db_name not in (select distinct db_name from oracle_security_tablespace_encrypted where compliance_score=0);
commit;


#####Scoring Network Encryption
update oracle_security_network_encryption set compliance_score=1 where upper(sqlnet_encryption)<>'EMPTY';
update oracle_security_scoring set network_encryption_score=1 where db_name not in (select distinct db_name from oracle_security_network_encryption where compliance_score=0);
update oracle_security_scoring set network_encryption_score=0 where db_name not in (select distinct db_name from oracle_security_network_encryption);
commit;

######Calculate Total Scoring
update oracle_security_scoring set compliance_score_total=20 where audit_enable_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+20 where security_parameter_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+10 where admin_high_privs_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+10 where default_user_pwd_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+10 where security_profile_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+5 where default_profile_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+5 where high_role_privs_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+5 where high_sys_privs_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+5 where high_tab_privs_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+5 where encrypted_tablespace_score=1;
update oracle_security_scoring set compliance_score_total=compliance_score_total+5 where network_encryption_score=1;

#####Scoring History
insert into oracle_security_history (db_name,environment,compliance_score_total) select db_name,environment,compliance_score_total from oracle_security_scoring;
delete from oracle_security_history where date_value <= NOW() - INTERVAL 9 MONTH;

#################END SCORING SECURITY

######Scoring Oracle PDB COUNT per container
update oracle_database_list a set a.count_pdb = (select count(b.pdb_name) from oracle_pdbs b where a.instance_name=b.instance_name group by b.instance_name);
##########END Scoring  Oracle PDB COUNT per container


######Scoring Oracle App CMDB Link
insert into oracle_pdbs_app_link(pdb_name) select distinct pdb_name from oracle_pdbs where substr(pdb_name,4,1) in ('P','V') and pdb_name not in (select pdb_name from oracle_pdbs_app_link);
#delete from oracle_pdbs_app_link where pdb_name not in (select pdb_name from oracle_pdbs);
##########END Scoring Scoring Oracle App CMDB Link
