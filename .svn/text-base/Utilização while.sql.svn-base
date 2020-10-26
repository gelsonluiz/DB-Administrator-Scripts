DECLARE 
@Chave Int,
@Pos INT,     -- Posição
@Cnt INT    -- Quantidade de registros do while


DECLARE @Tmp TABLE (
   ID int Identity Primary Key,
   Chave Int) -- Chave representa os campos da tabela

-- TABELA COM DADOS A SEREM TRABALHADOS   
INSERT INTO @Tmp 
SELECT Chave 
FROM Tabela1 
WHERE Campo = 'valor'

SELECT @Cnt = Count(ID) FROM @Tmp
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
  SELECT 
   @chave = Temp.chave 
  FROM @Tmp Temp
  WHERE ID = @Pos

  -- Bloco de código 
  UPDATE Tabela2 SET coluna = 1 WHERE chave = @chave

  SET @Pos = @Pos + 1
END