USE master
go

DECLARE 
@BancoA VarChar(255),
@BancoB VarChar(255),
@Chave VarChar(255),
@Pos INT, -- Posição
@Cnt INT, -- Quantidade de registros do while
@Script VarChar(max)

SET @BancoA = 'DBMIRA'
SET @BancoB = 'DBMIRAMS_IMPORT'

DECLARE @Difs Table (
   TableName VarChar(255),
   Diferenca VarChar(20),
   Coluna VarChar(255),
   TipoDado VarChar(50),
   Nulo VarChar(3))

-- TABELA COM DADOS A SEREM TRABALHADOS   
SET @Script = ' SELECT Name Chave '+
              ' FROM ['+@BancoA+'].sys.tables  '+
              ' WHERE Name LIKE ''T%'' '+
              ' UNION ' +
              ' SELECT Name Chave '+
              ' FROM ['+@BancoB+'].sys.tables  '+
              ' WHERE Name LIKE ''T%'' '+
              ' ORDER BY 1  '
              
DECLARE @Tmp TABLE (
   ID int Identity Primary Key,
   Chave VarChar(255)) -- Chave representa os campos da tabela

INSERT INTO @Tmp 
exec(@Script)   

SELECT @Cnt = Count(ID) FROM @Tmp
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
  SELECT 
   @chave = Temp.chave 
  FROM @Tmp Temp
  WHERE ID = @Pos

  -- Bloco de código 
   set @Script = ' EXEC [pr_ComparaTabelas] '''+@BancoA+''', '''+@BancoB+''', '''+@chave+''' '
   
   -- print @Script
   insert into @Difs   
   exec(@Script)   

  SET @Pos = @Pos + 1
END

select 
TableName,
Coluna,
TipoDado,
CASE WHEN Nulo = 'YES' THEN 'NULL' ELSE 'NOT NULL' END Nulo,
Diferenca
from @Difs


