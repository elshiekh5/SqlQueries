DECLARE @TableName NVARCHAR(250) = 'ComplaintDecisionRegulation' 
--=======================================================================
--select all relations with this table whatever it is the master or detail
--=======================================================================
SELECT
    fk.name 'FK Name',
    tp.name 'Parent table',
    cp.name, cp.column_id,
    tr.name 'Refrenced table',
    cr.name, cr.column_id
FROM 
    sys.foreign_keys fk
INNER JOIN 
    sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN 
    sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN 
    sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN 
    sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id

	WHERE 
	tp.NAME = @TableName
	OR tr.name =@TableName

ORDER BY
    tp.name, cp.column_id
--=======================================================================
--select all relations that this table is the master table
--=======================================================================
SELECT
    fk.name 'FK Name',
    tp.name 'Parent table',
    cp.name, cp.column_id,
    tr.name 'Refrenced table',
    cr.name, cr.column_id
FROM 
    sys.foreign_keys fk
INNER JOIN 
    sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN 
    sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN 
    sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN 
    sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id

	WHERE 
	tr.NAME = @TableName

ORDER BY
    tr.name, cp.column_id
--=======================================================================
--select all relations that this table is the master table
--select all relations with this table whatever it is the master or detail
--select all relations that this table is the detailed table
--=======================================================================
SELECT
    fk.name 'FK Name',
    tp.name 'Parent table',
    cp.name, cp.column_id,
    tr.name 'Refrenced table',
    cr.name, cr.column_id
FROM 
    sys.foreign_keys fk
INNER JOIN 
    sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN 
    sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN 
    sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN 
    sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id

	WHERE 
	 tp.name =@TableName

ORDER BY
    tp.name, cp.column_id

--=======================================================================
--## Resources 
--=======================================================================
/*
https://stackoverflow.com/questions/8094156/know-relationships-between-all-the-tables-of-database-in-sql-server

*/
--=======================================================================