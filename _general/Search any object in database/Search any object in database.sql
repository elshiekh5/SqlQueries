dECLARE
 @searchString nvarchar( 50 );
SET @searchString = 'reports';
SELECT DISTINCT
    s.name AS Schema_Name , O.name AS Object_Name , C.text AS OBJECT_DEFINITION
  ,o.type_desc  
FROM
     syscomments C INNER JOIN sys.objects O
                     ON
     C.id
     =
     O.object_id
                   INNER JOIN sys.schemas S
                   ON
     O.schema_id
     =
     S.schema_id
WHERE
    C.text LIKE
     '%'
   + @searchString
   + '%'
 OR O.name LIKE
     '%'
   + @searchString
   + '%'
ORDER BY
       Schema_name , Object_name;