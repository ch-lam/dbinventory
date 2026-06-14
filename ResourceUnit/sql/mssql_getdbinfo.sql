DECLARE @ver nvarchar(128)
DECLARE @sqlstmt nvarchar(4000)
SET @ver = CAST(serverproperty('ProductVersion') AS nvarchar)
SET @ver = SUBSTRING(@ver, 1, CHARINDEX('.', @ver) - 1)
IF ( @ver < '12' )
(         select  @sqlstmt = '
      select @@SERVERNAME as [instance_name],d.database_id,d.name as [database_name],CASE d.state
When 0 then ''Online''
When 1 then ''Restoring''
When 2 then ''Recovering''
When 3 then ''Recovery_pending''
When 4 then ''Suspect''
When 5 then ''Emergency''
When 6 then ''Offline''
When 7 then ''Copying''
When 10 then ''Offline_secondary'' END as state,
CASE d.recovery_model
When 1 Then ''Full''
When 2 Then ''Bulk Logged''
When 3 Then ''Simple'' END as recovery_model,
CASE d.compatibility_level
When 100 then ''SQL 2008''
When 110 then ''SQL 2012''
When 120 then ''SQL 2014''
When 130 then ''SQL 2016''
When 140 then ''SQL 2017''
When 150 then ''SQL 2019''
ELSE ''new unknown-''+CONVERT(varchar(10),compatibility_level) END as compatibility_level,
d.collation_name,b.bkup_dt as last_backup_date,b.diff_dt as last_differential_backup_date,b.log_dt as last_log_backup_date,d.create_date,
isnull(dm.mirroring_role, 0) as is_mirroring_enabled,p.name as [owner],
''NOT REPLICATED'' as AGType,
''N/A'' as AGName
from master.sys.databases d
join master.sys.database_mirroring dm on d.database_id = dm.database_id
left join master.sys.server_principals p on d.owner_sid = p.sid
left join(SELECT bs.database_name,
MAX(case bs.type when ''D'' then bs.backup_start_date end) as bkup_dt,
MAX(case bs.type when ''I'' then bs.backup_start_date end) as diff_dt,
MAX(case bs.type when ''L'' then bs.backup_start_date end) as log_dt
FROM msdb.dbo.backupset bs where bs.is_copy_only = 0 group by bs.database_name) b on b.database_name = d.name
order by instance_name, database_id')
ELSE
(         select @sqlstmt = '
           select distinct @@SERVERNAME as [instance_name],d.database_id,d.name as [database_name],CASE d.state
When 0 then ''Online''
When 1 then ''Restoring''
When 2 then ''Recovering''
When 3 then ''Recovery_pending''
When 4 then ''Suspect''
When 5 then ''Emergency''
When 6 then ''Offline''
When 7 then ''Copying''
When 10 then ''Offline_secondary'' END as state,
CASE d.recovery_model
When 1 Then ''Full''
When 2 Then ''Bulk Logged''
When 3 Then ''Simple'' END as recovery_model,
CASE d.compatibility_level
When 100 then ''SQL 2008''
When 110 then ''SQL 2012''
When 120 then ''SQL 2014''
When 130 then ''SQL 2016''
When 140 then ''SQL 2017''
When 150 then ''SQL 2019''
ELSE ''new unknown-''+CONVERT(varchar(10),compatibility_level) END as compatibility_level,
d.collation_name,b.bkup_dt as last_backup_date,b.diff_dt as last_differential_backup_date,b.log_dt as last_log_backup_date,d.create_date,
isnull(dm.mirroring_role, 0) as is_mirroring_enabled,p.name as [owner],
(
case 
 when
  hdrs.is_primary_replica IS NULL then  ''NOT REPLICATED''
 when exists ( select * from sys.dm_hadr_database_replica_states as irs where d.database_id = irs.database_id and is_primary_replica = 1 ) then
	''PRIMARY''
 else
    ''SECONDARY''
 end
) as  AGType,
COALESCE(grp.ag_name,''N/A'') as AGName
from master.sys.databases d
 left outer join sys.dm_hadr_database_replica_states  as hdrs on hdrs.database_id = d.database_id
 left outer join sys.dm_hadr_name_id_map as grp on grp.ag_id = hdrs.group_id
join master.sys.database_mirroring dm on d.database_id = dm.database_id
left join master.sys.server_principals p on d.owner_sid = p.sid
left join(SELECT bs.database_name,
MAX(case bs.type when ''D'' then bs.backup_start_date end) as bkup_dt,
MAX(case bs.type when ''I'' then bs.backup_start_date end) as diff_dt,
MAX(case bs.type when ''L'' then bs.backup_start_date end) as log_dt
FROM msdb.dbo.backupset bs where bs.is_copy_only = 0 group by bs.database_name) b on b.database_name = d.name
order by instance_name, database_id
'
)
EXEC (@sqlstmt)
