DECLARE 
@NomeTrigger VarChar(255),
@NomeTabela VarChar(255),
@ScriptSql Varchar(500),
@Pos INT,     -- Posição
@Cnt INT    -- Quantidade de registros do while

CREATE TABLE #Temp (
 ID int Identity Primary Key,
 NomeTrigger VarChar(255),
 NomeTabela VarChar(255)) -- Chave representa os campos da tabela
   
INSERT INTO #Temp 
SELECT 
name, 
OBJECT_NAME(parent_obj) AS tabela
FROM sysobjects
WHERE (xtype = 'TR')
AND NAME LIKE '%AUDIT%'

SELECT @Cnt = Count(ID) FROM #Temp
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
  SELECT 
   @NomeTrigger = NomeTrigger,
   @NomeTabela = NomeTabela
  FROM #Temp Temp
  WHERE ID = @Pos

  SET @ScriptSql = 'ALTER TABLE '+@NomeTabela+' DISABLE TRIGGER  '+@NomeTrigger
  
  -- PRINT @ScriptSql
  Exec(@ScriptSql)
  
  SET @Pos = @Pos + 1
END

DROP TABLE #Temp 