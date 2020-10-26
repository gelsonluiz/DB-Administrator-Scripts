SELECT 
     ' DROP INDEX '+ind.name+ ' ON ' +t.name [DROPINDEX], 
     IndexName = ind.name,
     TableName = t.name,
     IndexId = ind.index_id,
     ind.*
FROM sys.indexes ind
INNER JOIN sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
     AND ind.name LIKE '%ClcCrgHrrAlnPdc%'
     --AND t.name = 'TB_IndMtlEsaCrlOrg'
ORDER BY 
     ind.name, t.name, ind.index_id-- , ic.index_column_id
