/*Putting it all together
The following query will show you, for each suggested missing index, the number of reads an index might have assisted, the number of writes and reads that have currently been captured against the existing indexes, the ratio of those, the number of plans associated with that object, and the total number of use counts for those plans:
*/
;WITH x AS 
(
  SELECT 
    c.[object_id],
    potential_read_ops = SUM(c.user_seeks + c.user_scans),
    [write_ops] = SUM(iu.user_updates),
    [read_ops] = SUM(iu.user_scans + iu.user_seeks + iu.user_lookups), 
    [write:read ratio] = CONVERT(DECIMAL(18,2), SUM(iu.user_updates)*1.0 / 
      SUM(iu.user_scans + iu.user_seeks + iu.user_lookups)), 
    current_plan_count = po.h,
    current_plan_use_count = po.uc
  FROM 
    #candidates AS c
  LEFT OUTER JOIN 
    #indexusage AS iu
    ON c.[object_id] = iu.[object_id]
  LEFT OUTER JOIN
  (
    SELECT o, h = COUNT(h), uc = SUM(uc)
      FROM #planops GROUP BY o
  ) AS po
    ON c.[object_id] = po.o
  GROUP BY c.[object_id], po.h, po.uc
)
SELECT [object] = QUOTENAME(c.s) + '.' + QUOTENAME(c.o),
  c.equality_columns,
  c.inequality_columns,
  c.included_columns,
  x.potential_read_ops,
  x.write_ops,
  x.read_ops,
  x.[write:read ratio],
  x.current_plan_count,
  x.current_plan_use_count
FROM #candidates AS c
INNER JOIN x 
ON c.[object_id] = x.[object_id]
ORDER BY x.[write:read ratio];