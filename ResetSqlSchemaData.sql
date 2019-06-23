/*
    Author : Sameh Hamdy 
    Date : 2018-03-13
    Description : used to Reset all Data in specified Database Schema.
    Instructions : please use your project database then change only Schema name with your project Schema name.
*/

--Please change schema name only with your project schema.
DECLARE @SchemaName VARCHAR(50) = 'dbo'

DECLARE @SQLFilter VARCHAR(2000) = 'And Object_id In (SELECT Object_id FROM sys.objects 
WHERE schema_id = SCHEMA_ID('''+@SchemaName+'''))'

EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
,@whereand = @SQLFilter

EXEC sp_MSForEachTable 'ALTER TABLE ? DISABLE TRIGGER ALL'
,@whereand = @SQLFilter

EXEC sp_MSForEachTable 'DELETE FROM ?'
,@whereand = @SQLFilter

EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
,@whereand = @SQLFilter

EXEC sp_MSForEachTable 'ALTER TABLE ? ENABLE TRIGGER ALL'
,@whereand = @SQLFilter

EXEC sp_MSFOREACHTABLE 'SELECT * FROM ?'
,@whereand = @SQLFilter
GO






