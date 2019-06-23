SELECT Name,
    CASE xtype 
	WHEN 'U'  THEN 'Table'
	WHEN 'C'  THEN 'CHECK constraint' 
	WHEN 'D'  THEN 'DEFAULT constraint'
	WHEN 'F'  THEN 'FOREIGN KEY constraint' 
	WHEN 'FN' THEN 'Scalar function'
	WHEN 'IT' THEN 'Internal table'
	WHEN 'P'  THEN 'Stored procedure' 
	WHEN 'PK' THEN 'PRIMARY KEY'
	WHEN 'S'  THEN 'System table'
	WHEN 'TR' THEN 'Trigger'
	WHEN 'UQ' THEN 'UNIQUE constraint'
	WHEN 'V'  THEN 'View' 
	WHEN 'X'  THEN 'Extended stored procedure'
	ELSE 'Unknown type' End
[Object Type],
crdate CreatedOn 
FROM SYSOBJECTS WHERE NAME like '%reports%'