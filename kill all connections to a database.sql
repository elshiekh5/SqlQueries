--===================================================================================--
--kill all connections to a database (More than RESTRICTED_USER ROLLBACK)
--===================================================================================--
USE [master];
DECLARE @DatabaseName = 'CITC_Complaints_4'
DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id(@DatabaseName)

EXEC(@kill);
--===================================================================================--