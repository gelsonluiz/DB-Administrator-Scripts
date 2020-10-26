SELECT DISTINCT
     T.name AS Tabela, 
     C.name AS Coluna,
	 C.system_type_id
FROM 
     sys.sysobjects AS T (NOLOCK) 
INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id AND T.XTYPE = 'U' 
WHERE 
     C.NAME LIKE '%Id' 
	-- AND C.system_type_id = 127
	-- AND C.system_type_id = 56
ORDER BY 
     Coluna