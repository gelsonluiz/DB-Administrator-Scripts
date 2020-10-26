-- ESTE SCRIPT FAZ TUDO AUTOMÁTICO O PROBLEMA QUE NÃO CONSEGUI RESOLVER É QUE TRUNCA A LINHA NA COLUNA 2084
-- GRAVA NO ARQUIVO XML O RESULTADO DO SCRIPT

/*
-- CRIANDO ARQUIVO DE FORMATO (A PRINCÍPIO NÃO PRECISA)
DECLARE @sql VARCHAR(8000);
SELECT @sql = 'bcp [DBMIRAMS_IMPORT].[dbo].[TB_UndMdd] format nul -c -x -f C:\TempSQL\TB_UndMdd.xdp -T -S ' + @@SERVERNAME;
exec master..xp_cmdshell  @sql 

-- CRIANDO ARQUIVO XML
DECLARE @sql VARCHAR(8000);
SELECT @sql = 'bcp "SELECT * FROM [DBMIRAMS_IMPORT].[dbo].[TB_ItmCst] FOR XML raw ,ROOT(''Table'') "  queryout "C:\TempSQL\TB_ItmCst2.xml" -T -S -C -w' + @@SERVERNAME;
exec master..xp_cmdshell @sql;

SELECT * 
FROM TB_UndMdd 
FOR XML auto 
        --ELEMENTS -- Separando em nós
       ,ROOT('TB_UndMdd') -- nó raiz

*/

DECLARE 
@idoc int, 
@doc xml 

SET @doc = (SELECT CAST(BulkColumn AS XML)
            FROM OPENROWSET(BULK N'C:\TempSQL\TB_ItmCst2.xml', SINGLE_BLOB)
            AS Arquivo) 

EXEC sp_xml_preparedocument @idoc OUTPUT, @doc 

--INSERT INTO TB_UndMdd
SELECT * FROM OPENXML (@idoc, '/Table/row',0)  with TB_ItmCst

EXEC sp_xml_removedocument @idoc 

