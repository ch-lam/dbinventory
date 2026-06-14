#################START MSSQL SCORING SECURITY

######Cleanup Scoring Result
truncate table mssql_security_scoring;

######Scoring mssql_security_configoptions
update mssql_security_configoptions set compliance_score=1 where name='Ad Hoc Distributed Queries' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='clr enabled' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='cross db ownership chaining' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='Database Mail XPs' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='Ole Automation Procedures' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='remote access' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='remote admin connections' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='remote access' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='scan for startup procs' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='xp_cmdshell' and run_value='0';
update mssql_security_configoptions set compliance_score=1 where name='default trace enabled' and run_value='1';
update mssql_security_configoptions set compliance_score=1 where name='clr strict security' and run_value='1';
update mssql_security_configoptions set compliance_score=1 where concat(servername,name,run_value) in (select concat(servername,name,run_value) from mssql_security_configoptions_exception);
insert into mssql_security_scoring (servername,configoptions) select distinct servername,1 from mssql_security_configoptions where compliance_score=1 and servername not in (select servername from mssql_security_configoptions where compliance_score=0);
insert into mssql_security_scoring (servername,configoptions) select distinct servername,0 from mssql_security_configoptions where servername in (select servername from mssql_security_configoptions where compliance_score=0);
commit;

######Scoring mssql_security_dbproperties
update mssql_security_dbproperties set compliance_score=1 where db_name='msdb' and is_auto_close_on=0 and is_trustworthy_on=1;
update mssql_security_dbproperties set compliance_score=1 where is_auto_close_on=0 and is_trustworthy_on=0;
update mssql_security_dbproperties set compliance_score=1 where concat(servername,db_name,is_auto_close_on,is_trustworthy_on) in (select concat(servername,db_name,is_auto_close_on,is_trustworthy_on) from mssql_security_dbproperties_exception);
update mssql_security_scoring set dbproperties=1 where servername not in (select distinct servername from mssql_security_dbproperties where compliance_score=0);
commit;

######Scoring mssql_security_auditlevel
update mssql_security_auditlevel set compliance_score=1 where auditlevel in ('All','Failed');
update mssql_security_scoring set auditlevel=1 where servername not in (select distinct servername from mssql_security_auditlevel where compliance_score=0);
commit;

######Scoring mssql_security_encryption
#update mssql_security_encryption set compliance_score=1 where key_name in ('NoSymKeyFound','NoAsymKeyFound') and algorithm_desc='NotFound';
update mssql_security_encryption set compliance_score=0 where key_name in ('NoSymKeyFound','NoAsymKeyFound') and algorithm_desc='NotFound';
update mssql_security_encryption set compliance_score=1 where db_name in ('master','model','msdb','tempdb');
update mssql_security_encryption set compliance_score=1 where algorithm_desc in ('TRIPLE_DES','AES_128','AES_192','AES_256') or (key_name='AES' and algorithm_desc='256');
update mssql_security_encryption set compliance_score=1 where concat(servername,db_name,key_type,key_name,algorithm_desc) in (select concat(servername,db_name,key_type,key_name,algorithm_desc) from mssql_security_encryption_exception);
update mssql_security_encryption set compliance_score=1 where servername in (select hostname from mssql_hosts where lower(mssql_edition) like '%express%' or lower(mssql_edition) like '%developer%');
delete from mssql_security_encryption where key_type in ('asymmetric','symmetric') and db_name in (select db_name from mssql_security_encryption where key_type='CERTIFICATE');
update mssql_security_scoring set encryption=1 where servername not in (select distinct servername from mssql_security_encryption where compliance_score=0);
commit;

######Scoring mssql_security_groups
update mssql_security_groups set compliance_score=1 where localgroupname='nogroup';
update mssql_security_groups set compliance_score=1 where concat(servername,localgroupname) in (select concat(servername,localgroupname) from mssql_security_groups_exception);
update mssql_security_scoring set groups=1 where servername not in (select distinct servername from mssql_security_groups where compliance_score=0);
commit;

######Scoring mssql_security_guestconnect
update mssql_security_guestconnect set compliance_score=1 where permission_name='no_permission' and state_desc='no_permission';
update mssql_security_guestconnect set compliance_score=1 where concat(servername,db_name,permission_name,state_desc) in (select concat(servername,db_name,permission_name,state_desc) from mssql_security_guestconnect_exception);
update mssql_security_scoring set guestconnect=1 where servername not in (select distinct servername from mssql_security_guestconnect where compliance_score=0);
commit;

######Scoring mssql_security_logins
update mssql_security_logins set compliance_score=1 where is_policy_checked=1;
update mssql_security_logins set compliance_score=0 where is_sysadmin=1 and is_expiration_checked=0;
update mssql_security_logins set compliance_score=1 where is_sysadmin=1 and is_expiration_checked=1;
update mssql_security_logins set compliance_score=1 where is_policy_checked=1 and principal_id=1 and login_name<>'sa';
update mssql_security_logins set compliance_score=1 where login_name in ('sa','monitoring');
update mssql_security_logins set compliance_score=1 where concat(servername,login_name) in (select concat(servername,login_name) from mssql_security_logins_exception);
update mssql_security_scoring set logins=1 where servername not in (SELECT distinct servername FROM `mssql_security_logins` where compliance_score =0);
commit;

######Scoring mssql_security_orphanedusers
update mssql_security_orphanedusers set compliance_score=1 where user_name='NoOrphanedUser';
update mssql_security_orphanedusers set compliance_score=1 where concat(servername,db_name,user_name) in (select concat(servername,db_name,user_name) from mssql_security_orphanedusers_exception);
update mssql_security_scoring set orphanedusers=1 where servername not in (SELECT distinct servername FROM mssql_security_orphanedusers where compliance_score =0);
commit;

######Scoring mssql_security_publicpermission
update mssql_security_publicpermission set compliance_score=1 where permission_name='OnlyDefaultPermission' and state_desc='OnlyDefaultPermission';
update mssql_security_scoring set publicpermission=1 where servername not in (SELECT distinct servername FROM mssql_security_publicpermission where compliance_score =0);
commit;


######Scoring mssql_security_registryinfo
update mssql_security_registryinfo set compliance_score=1 where name='Hide Instance' and value=1;
update mssql_security_registryinfo set compliance_score=1 where name='Hide Instance' and value=0 and servername like 'XV%';
update mssql_security_registryinfo set compliance_score=1 where name='ForceEncryption' and value=1;
update mssql_security_registryinfo set compliance_score=1 where name='NumErrorlogFiles' and value>12; 
update mssql_security_registryinfo set compliance_score=1 where name='TCP Port' and value='1433';
update mssql_security_registryinfo set compliance_score=1 where concat(servername,name) in (select concat(servername,name) from mssql_security_registryinfo_exception);
update mssql_security_scoring set registryinfo=1 where servername not in (SELECT distinct servername FROM mssql_security_registryinfo where compliance_score =0);
commit;

######Scoring mssql_security_sqlserveraudit
update mssql_security_sqlserveraudit set compliance_score=1 where auditactionname='AUDIT_CHANGE_GROUP' and auditenabled='1' and auditspecificationenabled='1' ;
update mssql_security_sqlserveraudit set compliance_score=1 where auditactionname='FAILED_LOGIN_GROUP' and auditenabled='1' and auditspecificationenabled='1';
update mssql_security_sqlserveraudit set compliance_score=1 where auditactionname='SUCCESSFUL_LOGIN_GROUP' and auditenabled='1' and auditspecificationenabled='1';
update mssql_security_sqlserveraudit set compliance_score=1 where concat(servername,auditactionname) in (select concat(servername,auditactionname) from mssql_security_sqlserveraudit_exception);
update mssql_security_scoring set sqlserveraudit=1 where servername not in (SELECT distinct servername FROM mssql_security_sqlserveraudit where compliance_score =0);
commit;


######Update Environment
update inventory.mssql_security_scoring cmss
JOIN inventory.mssql_hosts oh on cmss.servername = oh.hostname
set cmss.environment=oh.env where cmss.servername=oh.hostname;
commit;

######Calculate Total Scoring
update mssql_security_scoring set compliance_score_total=35 where configoptions=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+10 where logins=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+10 where registryinfo=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+10 where SQLServerAudit=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5 where dbproperties=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5  where auditlevel=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5 where encryption=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5 where groups=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5 where guestconnect=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5 where orphanedusers=1;
update mssql_security_scoring set compliance_score_total=compliance_score_total+5 where publicpermission=1;
commit;

####Scoring Exception and Legacy Server
update mssql_security_scoring set legacy_server=1 where servername in (select hostname from mssql_hosts where install_date < 20251211);
update mssql_security_scoring set legacy_server=1 where servername='THYCOTICSRV';
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_configoptions_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_dbproperties_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_logins_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_registryinfo_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_sqlserveraudit_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_guestconnect_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_orphanedusers_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_encryption_exception);
update mssql_security_scoring set exception_detected=1 where servername in (select servername from mssql_security_groups_exception);


#####Scoring History
insert into mssql_security_history (servername,environment,compliance_score_total) select servername,environment,compliance_score_total from mssql_security_scoring;
delete from mssql_security_history where date_value <= NOW() - INTERVAL 365 DAY;
