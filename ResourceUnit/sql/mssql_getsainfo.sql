SELECT @@servername,name, is_disabled
FROM sys.server_principals
WHERE sid = 0x01;
GO
