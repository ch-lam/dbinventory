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
