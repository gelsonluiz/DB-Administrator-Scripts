DECLARE @TableName AS VARCHAR(250)='TB_FcaTcn'
;WITH cte AS 
(
	SELECT Cast(OBJECT_NAME (fkc.parent_object_id) as VARCHAR(MAX)) AS TableRelation, 
	       OBJECT_NAME(fkc.parent_object_id) AS DependentTable, 
	       fkc.parent_object_id AS childID, 
	       1 AS ReLevel
	FROM   sys.foreign_key_columns fkc
	WHERE  fkc.referenced_object_id = OBJECT_ID (@TableName)
	UNION ALL
	SELECT Cast(c.TableRelation +'-->'+ OBJECT_NAME (fkc.parent_object_id) AS VARCHAR(MAX)) AS TableRelation, 
	       OBJECT_NAME(fkc.parent_object_id) AS DependentTable, 
	       fkc.parent_object_id AS childID, 
	       c.ReLevel + 1
	FROM   sys.foreign_key_columns fkc
	INNER JOIN cte c ON  fkc.referenced_object_id = c.Childid
	 AND fkc.parent_object_id<>c.childid
)
SELECT TableRelation, DependentTable FROM cte
-- SELECT TableRelation FROM cte Order by TableRelation -- Apenas Tabelas Relacionadas
-- SELECT DISTINCT DependentTable FROM cte -- Apenas tabelas descendentes