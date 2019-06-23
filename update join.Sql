UPDATE Table1
SET Col2 = t2.Col2,
Col3 = t2.Col3
FROM Table1 t1
INNER JOIN Table2 t2 ON t1.Col1 = t2.Col1
WHERE t1.Col1 IN (21, 31)
GO