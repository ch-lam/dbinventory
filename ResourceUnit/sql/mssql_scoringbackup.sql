##Populate table with last backup for each backup type
create table inventory.backup_temp as 
select * from inventory.backup where backup_type='Log' and backup_start_date > now() - interval 2 day
UNION ALL
select * from inventory.backup where backup_type='Full' and backup_start_date > now() - interval 3 day;

truncate table cmdb.inventory.backup_summary;
insert into cmdb.inventory.backup_summary(hostname,database_name,backup_type,backup_start_date,previous_backup,hours_between_backup)
select a.hostname,a.database_name,backup_type,a.backup_start_date,
IFNULL((select max(backup_finish_date) from inventory.backup_temp where concat(hostname,database_name)=concat(a.hostname,a.database_name) 
and backup_start_date > now() - interval 2 day and backup_type='Log' and backup_finish_date < a.backup_start_date),a.backup_start_date) AS previous_backup,
'666'
FROM inventory.backup_temp a
WHERE a.backup_type='Log'
AND backup_start_date > now() - interval 2 day
UNION ALL
select a.hostname,a.database_name,backup_type,a.backup_start_date,
IFNULL((select max(backup_finish_date) from inventory.backup_temp where concat(hostname,database_name)=concat(a.hostname,a.database_name) 
and backup_start_date > now() - interval 2 day and backup_type='Full' and backup_finish_date < a.backup_start_date),a.backup_start_date) AS previous_backup,
'666'
FROM inventory.backup_temp  a
WHERE a.backup_type='Full'
AND backup_start_date > now() - interval 2 day;

drop table inventory.backup_temp;

##Update NB Hours between last backup
update inventory.backup_summary set hours_between_backup=TIMESTAMPDIFF(HOUR,previous_backup,backup_start_date);

##Update Recovery Model
update inventory.backup_summary a, inventory.database b set a.recovery_model=b.recovery_model where concat(a.hostname,a.database_name)=concat(b.hostname,b.database_name);

##Populate with environment
create table cmdb.inventory.temp_env as
select OH.name as 'hostname', OHA.value as 'environment' 
FROM cmdb.inventory.hosts CT left outer join opsview.hosts OH on (CT.hostname=OH.name) join opsview.host_attributes OHA on (OH.id=OHA.host) 
where OHA.value in ('DEV','TEST','UAT','PROD','INT','GTU') order by CT.hostname;
update inventory.backup_summary a, inventory.temp_env b set a.environment=b.environment where a.hostname=b.hostname;
drop table cmdb.inventory.temp_env;

##Remove SLA from diff between backup
update inventory.backup_summary set hours_between_backup=hours_between_backup-2 where backup_type='Log';
update inventory.backup_summary set hours_between_backup=hours_between_backup-24 where backup_type='Full';
update inventory.backup_summary set hours_between_backup=0 where hours_between_backup<1;
update inventory.backup_summary set hours_between_backup=0 where hours_between_backup=1;


commit;

## populate inventory.backup_info_history
INSERT INTO inventory.backup_info_history(environment,cumulative_hours_between_backup)
SELECT  'PROD',c.cumulative_hours_between_backup
FROM
(SELECT sum(hours_between_backup) as cumulative_hours_between_backup FROM inventory.backup_summary WHERE environment='PROD') c;

INSERT INTO inventory.backup_info_history(environment,cumulative_hours_between_backup)
SELECT  'NON_PROD',c.cumulative_hours_between_backup
FROM
(SELECT sum(hours_between_backup) as cumulative_hours_between_backup FROM inventory.backup_summary WHERE environment<>'PROD') c;

## populate inventory.backup_stats
truncate table inventory.backup_stats;
insert into inventory.backup_stats(hostname,database_name,recovery_model,Backup_type,NbreBU)
SELECT 
db.hostname,
db.database_name,
db.recovery_model,
'Log' as Backup_Type,
(select count(*) from inventory.backup where hostname=db.hostname and database_name=db.database_name and backup_type='Log') as NbreBU
FROM inventory.database db 
LEFT OUTER JOIN inventory.backup bu on db.hostname=bu.hostname and db.database_name=bu.database_name
where 
db.database_name <> 'tempdb' and db.recovery_model = 'Full'
group by db.hostname,db.database_name,db.recovery_model;
insert into inventory.backup_stats(hostname,database_name,recovery_model,Backup_type,NbreBU)
SELECT 
db.hostname,
db.database_name,
db.recovery_model,
'Full' as Backup_Type,
(select count(*) from inventory.backup where hostname=db.hostname and database_name=db.database_name and backup_type='Full') as Nbre_FullBU
FROM inventory.database db 
LEFT OUTER JOIN inventory.backup bu on db.hostname=bu.hostname and db.database_name=bu.database_name
where 
db.database_name <> 'tempdb'  
group by db.hostname,db.database_name,db.recovery_model;

## Calculate cumulative hours between backups

update inventory.backup_stats a set a.cumulative_hours_between_backup =(select sum(b.hours_between_backup) from inventory.backup_summary b where a.database_name=b.database_name and a.hostname=b.hostname and a.backup_type=b.backup_type);


## Delete info older than 1 year

delete from inventory.backup_info_history where cast(scoring_result as date) <= NOW() - INTERVAL 365 DAY;
