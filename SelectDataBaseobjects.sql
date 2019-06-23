DECLARE @TempTable Table(
SourceCount INT,
DestinationCount INT,
Diff Int
)

Select (SELECT COUNT(*) FROM CITC_Enterprise_Release.dbo.ComplaintCostLog),(SELECT COUNT(*) FROM CITC_Enterprise_BI_Release.dbo.ComplaintCostLog)
SELECT 

'Union Select '''+SCHEMA_NAME(schema_id)+'.'+name+''', (SELECT COUNT(*) FROM CITC_Enterprise_Release.'+SCHEMA_NAME(schema_id)+'.'+name+'),(SELECT COUNT(*) FROM CITC_Enterprise_BI_Release.'+SCHEMA_NAME(schema_id)+'.'+name+')'
    , name,
    object_id,
    principal_id,
    schema_id,
    parent_object_id,
    type,
    type_desc,
    create_date,
    modify_date,
    is_ms_shipped,
    is_published,
    is_schema_published,
   SCHEMA_NAME(schema_id) AS schema_name  
FROM sys.objects  
WHERE type IN ('U')
ORDER BY type