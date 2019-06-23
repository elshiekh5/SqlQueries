--truncate all tables 
EXEC Sp_msforeachtable @command1='Truncate Table ?'
--truncate all tables in specific schema 
EXEC Sp_msforeachtable @command1='Truncate Table ?',@whereand='and Schema_Id=Schema_id(''Schema_id'')'