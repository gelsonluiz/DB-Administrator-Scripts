SELECT  
OBJECT_NAME(s.object_id) [Tabela], 
i.name, 
i.type_desc,
( s.user_seeks + s.user_scans + s.user_lookups ) reads,
s.user_updates
FROM    sys.dm_db_index_usage_stats s WITH ( NOLOCK )
JOIN sys.indexes i WITH (NOLOCK) ON s.index_id = i.index_id
AND s.object_id = i.object_id
WHERE   OBJECTPROPERTY(s.[object_id], 'IsUserTable') = 1
AND s.database_id = DB_ID()
AND s.user_updates > ( s.user_seeks + s.user_scans + s.user_lookups )
AND s.index_id > 1
ORDER BY 4 desc -- OBJECT_NAME(s.object_id) , i.name