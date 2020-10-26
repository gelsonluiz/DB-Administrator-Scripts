CREATE PROCEDURE pr_ComparaTabelas(@BancoOrigem VarChar(255), @BancoDestino VarChar(255), @Tabela VarChar(255))
AS
Begin
Declare @Script VarChar(max)

   set @Script = 'DECLARE @Tabela VarChar(255) = '''+@Tabela +''';
   WITH A AS (SELECT TABLE_NAME,COLUMN_NAME, DATA_TYPE + case when CHARACTER_MAXIMUM_LENGTH is null then '''' else ''(''+CAST(CHARACTER_MAXIMUM_LENGTH as varchar(10))+'')'' end as DATA_TYPE, IS_NULLABLE
              FROM ['+@BancoOrigem+'].INFORMATION_SCHEMA.COLUMNS
              WHERE TABLE_NAME LIKE @Tabela) ,
        B AS (SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE + case when CHARACTER_MAXIMUM_LENGTH is null then '''' else ''(''+CAST(CHARACTER_MAXIMUM_LENGTH as varchar(10))+'')'' end as DATA_TYPE, IS_NULLABLE
              FROM ['+@BancoDestino+'].INFORMATION_SCHEMA.COLUMNS
              WHERE TABLE_NAME LIKE @Tabela),
        C AS (SELECT TABLE_NAME, ''IN A NOT B'' [CASE], COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
              FROM (SELECT  TABLE_NAME, COLUMN_NAME, DATA_TYPE , IS_NULLABLE
                    FROM A
                    EXCEPT
                    SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
                    FROM B) Q),
        D AS (SELECT TABLE_NAME, ''IN B NOT A'' [CASE], COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
              FROM (SELECT  TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
                    FROM B EXCEPT SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE FROM A) Q)

   SELECT *
   FROM C
   UNION ALL
   SELECT *
   FROM D
   ORDER BY TABLE_NAME, COLUMN_NAME; '

   exec(@Script)   

End


-- EXEC pr_ComparaTabelas 'DBMIRA', 'DBMIRA_WEB_HOMOLOGA', 'TB_CmlAdtCnl'