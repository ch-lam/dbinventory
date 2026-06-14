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
