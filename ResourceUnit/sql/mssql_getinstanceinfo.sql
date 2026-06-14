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
