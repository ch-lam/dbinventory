-- =============================================================================
-- get_info_sqlserver — Requêtes SQL de collecte inventaire SQL Server
--
-- Exécution : sqlcmd -U monitoring -S <host> -P <pass> -C
-- Les requêtes ci-dessous correspondent aux fichiers sql/*.sql appelés
-- par le script, ainsi qu'à la requête IPAM inline.
-- =============================================================================


-- ── Informations instance (sql/mssql_getinstanceinfo.sql) ────────────────────
-- Note : ce script utilise du SQL dynamique selon la version (SQL 2008 = v10,
--        SQL 2012+ = v11+). La version complète est ci-dessous.

DECLARE @ver nvarchar(128)
DECLARE @sqlstmt nvarchar(4000)
SET @ver = CAST(serverproperty('ProductVersion') AS nvarchar)
SET @ver = SUBSTRING(@ver, 1, CHARINDEX('.', @ver) - 1)

IF EXISTS (SELECT * FROM sys.all_views
WHERE name = N'dm_os_windows_info')
BEGIN
IF ( @ver = '10' )
(         select  @sqlstmt = '
      DECLARE @ServiceAccount varchar(100)
EXECUTE master.dbo.xp_instance_regread
            N''HKEY_LOCAL_MACHINE'',
            N''SYSTEM\CurrentControlSet\Services\MSSQLSERVER'',
            N''ObjectName'',
            @ServiceAccount OUTPUT,
            N''no_output''
          select
          SERVERPROPERTY(''ServerName''),
          SERVERPROPERTY(''Edition''),
          SERVERPROPERTY(''ProductVersion''),
          SERVERPROPERTY(''Collation''),
          SERVERPROPERTY(''IsClustered''),
          SERVERPROPERTY(''ComputerNamePhysicalNetBIOS''),
          '','',
          (select value from sys.configurations where name = ''cost threshold for parallelism''),
          (select value from sys.configurations where name = ''max degree of parallelism''),
          (select value from sys.configurations where name = ''min server memory (MB)''),
          (select value from sys.configurations where name = ''max server memory (MB)''),
          (select value from sys.configurations where name = ''xp_cmdshell''),
          (select cpu_count from sys.dm_os_sys_info),
          (select physical_memory_in_bytes/1024/1024/1024 from sys.dm_os_sys_info),
          (SELECT windows_release FROM sys.dm_os_windows_info),
	  (SELECT CONVERT(VARCHAR(10), createdate, 112) FROM  sys.syslogins where sid = 0x010100000000000512000000),
          @ServiceAccount')
ELSE
(         select @sqlstmt = '
            DECLARE @ServiceAccount varchar(100)
EXECUTE master.dbo.xp_instance_regread
            N''HKEY_LOCAL_MACHINE'',
            N''SYSTEM\CurrentControlSet\Services\MSSQLSERVER'',
            N''ObjectName'',
            @ServiceAccount OUTPUT,
            N''no_output''
          select
          SERVERPROPERTY(''ServerName''),
          SERVERPROPERTY(''Edition''),
          SERVERPROPERTY(''ProductVersion''),
          SERVERPROPERTY(''Collation''),
          SERVERPROPERTY(''IsClustered''),
          SERVERPROPERTY(''ComputerNamePhysicalNetBIOS''),
          (SELECT nodename FROM sys.dm_os_cluster_nodes ORDER BY 1 OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY),
          (SELECT nodename FROM sys.dm_os_cluster_nodes ORDER BY 1 OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY),
          (select value from sys.configurations where name = ''cost threshold for parallelism''),
          (select value from sys.configurations where name = ''max degree of parallelism''),
          (select value from sys.configurations where name = ''min server memory (MB)''),
          (select value from sys.configurations where name = ''max server memory (MB)''),
          (select value from sys.configurations where name = ''xp_cmdshell''),
          (select cpu_count from sys.dm_os_sys_info),
          (select physical_memory_kb/1024/1024 from sys.dm_os_sys_info),
          (SELECT windows_release FROM sys.dm_os_windows_info),
	  (SELECT CONVERT(VARCHAR(10), createdate, 112) FROM  sys.syslogins where sid = 0x010100000000000512000000),
          @ServiceAccount'
          )
END
ELSE
BEGIN
select  @sqlstmt = '
      DECLARE @ServiceAccount varchar(100)
EXECUTE master.dbo.xp_instance_regread
            N''HKEY_LOCAL_MACHINE'',
            N''SYSTEM\CurrentControlSet\Services\MSSQLSERVER'',
            N''ObjectName'',
            @ServiceAccount OUTPUT,
            N''no_output''
          select
          SERVERPROPERTY(''ServerName''),
          SERVERPROPERTY(''Edition''),
          SERVERPROPERTY(''ProductVersion''),
          SERVERPROPERTY(''Collation''),
          SERVERPROPERTY(''IsClustered''),
          SERVERPROPERTY(''ComputerNamePhysicalNetBIOS''),
          '','',
          (select value from sys.configurations where name = ''cost threshold for parallelism''),
          (select value from sys.configurations where name = ''max degree of parallelism''),
          (select value from sys.configurations where name = ''min server memory (MB)''),
          (select value from sys.configurations where name = ''max server memory (MB)''),
          (select value from sys.configurations where name = ''xp_cmdshell''),
          (select cpu_count from sys.dm_os_sys_info),
          (select physical_memory_in_bytes/1024/1024/1024 from sys.dm_os_sys_info),
          6.1,
	  (SELECT CONVERT(VARCHAR(10), createdate, 112) FROM  sys.syslogins where sid = 0x010100000000000512000000),
          @ServiceAccount'
END
EXEC (@sqlstmt)
GO


-- ── Informations bases de données (sql/mssql_getdbinfo.sql) ──────────────────

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
GO


-- ── Informations backups (sql/mssql_getbackupinfo.sql) ───────────────────────

SELECT DISTINCT
SERVERPROPERTY('ServerName'),
msdb.dbo.backupset.database_name,
msdb.dbo.backupset.backup_start_date,
msdb.dbo.backupset.backup_finish_date,
CASE msdb..backupset.type
WHEN 'D' THEN 'Full'
WHEN 'I' THEN 'Incr'
WHEN 'L' THEN 'Log'
END AS backup_type,
msdb.dbo.backupset.backup_size
FROM msdb.dbo.backupmediafamily
INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id
WHERE (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 31)
ORDER BY
msdb.dbo.backupset.database_name,
msdb.dbo.backupset.backup_finish_date
GO


-- ── Informations fichiers (sql/mssql_getfileinfo.sql) ────────────────────────

select @@SERVERNAME as instance_name, DB_Name(database_id) as database_name, file_id, type_desc, name, physical_name, (size)*8/1024 as size_mb
        ,case (is_percent_growth) WHEN 1 THEN growth ELSE 0 END  as growth_percent
        ,case (is_percent_growth) WHEN 0 THEN growth*8/1024 ELSE 0 END  as growth_mb
	,max_size
        from sys.master_files
        WHERE type in (0, 1)
GO


-- ── Informations logins (sql/mssql_getloginsinfo.sql) ────────────────────────

SELECT @@SERVERNAME as instance_name, sp.[name] as LoginName, sp.create_date AS AccountCreateDate,
sp.modify_date AS LastTimeAccountModified,
LOGINPROPERTY( sp.[name], 'PasswordLastSetTime' ) AS PasswordLastSetTime,
sp.default_database_name as DefaultDatabase,
sp.default_language_name as DefaultLanguage,
sp.is_disabled as IsDisabledChecked,
sl.is_policy_checked as IsPolicyChecked,
sl.is_expiration_checked as IsExpirationChecked,
LOGINPROPERTY( sp.[name], 'IsExpired' ) AS IsExpired,
LOGINPROPERTY (sp.[name], 'DaysUntilExpiration' ) AS DaysUntilExpiration,
LOGINPROPERTY( sp.[name], 'IsLocked' ) AS IsLocked,
LOGINPROPERTY( sp.[name], 'IsMustChange' ) AS IsMustChange,
LOGINPROPERTY( sp.[name], 'LockoutTime' ) AS LockoutTime,
LOGINPROPERTY( sp.[name], 'BadPasswordCount' ) AS BadPasswordCount,
LOGINPROPERTY( sp.[name], 'BadPasswordTime' ) AS BadPasswordTime,
LOGINPROPERTY( sp.[name], 'HistoryLength' ) AS HistoryLength,
sp.sid, sp.type,
CASE WHEN sysadmin = 1 THEN 'sysadmin'
WHEN securityadmin=1 THEN 'securityadmin'
WHEN serveradmin=1 THEN 'serveradmin'
WHEN setupadmin=1 THEN 'setupadmin'
WHEN processadmin=1 THEN 'processadmin'
WHEN diskadmin=1 THEN 'diskadmin'
WHEN dbcreator=1 THEN 'dbcreator'
WHEN bulkadmin=1 THEN 'bulkadmin'
ELSE 'Public' END AS 'ServerRole'
FROM sys.server_principals sp
Join syslogins sysl on sysl.loginname=sp.name
LEFT OUTER JOIN sys.sql_logins sl on sl.sid = sp.sid
WHERE sp.type not in ('C', 'R')
GO


-- ── Informations utilisateurs (sql/mssql_getuserinfo.sql) ────────────────────

EXEC sp_MSforeachdb
	'
	 SELECT
	   @@SERVERNAME,
	   ''?'',
	   u.name,
	   CASE WHEN (r.principal_id IS NULL) THEN ''public'' ELSE r.name END GroupName,
	   l.name LoginName,
	   l.default_database_name,
	   u.default_schema_name,
	   u.principal_id,
	   u.sid
	 FROM [?].sys.database_principals u
	   LEFT JOIN ([?].sys.database_role_members m
	   JOIN [?].sys.database_principals r
	   ON m.role_principal_id = r.principal_id)
	   ON m.member_principal_id = u.principal_id
	   LEFT JOIN [?].sys.server_principals l
	   ON u.sid = l.sid
	 WHERE u.TYPE <> ''R''
	 order by u.name
	 '
GO


-- ── Logins sans permission (sql/mssql_loginwithoutperm.sql) ──────────────────

SET NOCOUNT ON
CREATE TABLE #all_users (db NVARCHAR(200), sid VARBINARY(100), stat NVARCHAR(60))
EXEC master.sys.sp_MSforeachdb
'INSERT INTO #all_users
 SELECT ''?'', CONVERT(varbinary(85), sid) ,
  CASE WHEN  r.role_principal_id IS NULL AND p.major_id IS NULL
  THEN ''no_db_permissions''  ELSE ''db_user'' END
 FROM [?].sys.database_principals u LEFT JOIN [?].sys.database_permissions p
   ON u.principal_id = p.grantee_principal_id
   AND p.permission_name <> ''CONNECT''
  LEFT JOIN [?].sys.database_role_members r
   ON u.principal_id = r.member_principal_id
  WHERE u.SID IS NOT NULL AND u.type_desc <> ''DATABASE_ROLE'''
IF EXISTS
(SELECT l.name FROM sys.server_principals l LEFT JOIN sys.server_permissions p
  ON l.principal_id = p.grantee_principal_id
  AND p.permission_name <> 'CONNECT SQL'
 LEFT JOIN sys.server_role_members r
  ON l.principal_id = r.member_principal_id
 LEFT JOIN #all_users u
  ON l.sid= u.sid
 WHERE r.role_principal_id IS NULL  AND l.type_desc <> 'SERVER_ROLE'
  AND p.major_id IS NULL
 )
BEGIN
 SELECT DISTINCT @@SERVERNAME as instance_name, l.name LoginName, l.type_desc, l.is_disabled,
  ISNULL(u.stat + ' but is user in ' + u.db  +' DB', 'no_db_users') db_perms,
  CASE WHEN p.major_id IS NULL AND r.role_principal_id IS NULL
  THEN 'no_srv_permissions' ELSE 'na' END srv_perms,l.modify_date As Modify_Date,getdate() as Scandate
 FROM sys.server_principals l LEFT JOIN sys.server_permissions p
   ON l.principal_id = p.grantee_principal_id
   AND p.permission_name <> 'CONNECT SQL'
  LEFT JOIN sys.server_role_members r
   ON l.principal_id = r.member_principal_id
   LEFT JOIN #all_users u
   ON l.sid= u.sid
  WHERE  l.type_desc <> 'SERVER_ROLE'
   AND ((u.db  IS NULL  AND p.major_id IS NULL
     AND r.role_principal_id IS NULL )
   OR (u.stat = 'no_db_permissions' AND p.major_id IS NULL
     AND r.role_principal_id IS NULL))
 ORDER BY 1, 4
END
DROP TABLE #all_users
GO


-- ── Validation des logins Windows (sql/mssql_validatelogin.sql) ──────────────

IF (OBJECT_ID('tempdb..#invalidlogins') IS NOT NULL)
BEGIN
DROP TABLE #invalidlogins
END
CREATE TABLE #invalidlogins(
ACCTSID VARBINARY(85)
, NTLOGIN SYSNAME)
INSERT INTO #invalidlogins
EXEC sys.sp_validatelogins
SELECT @@servername as Servername, ACCTSID, NTLogin,SP.is_disabled, SP.modify_date ,getdate() FROM #invalidlogins as IL
join sys.server_principals as SP on IL.NTLOGIN = SP.Name
order by 1
GO


-- ── Commentaires IPAM (requête inline dans le script) ────────────────────────
-- Exécution : sqlcmd -U monitoring -S INFRASQL -P <pass> -C

SELECT Hostname,REPLACE(REPLACE(comment, CHAR(13), ''), CHAR(10), '') FROM CHL_IPAM.dbo.Hosts;
GO
