/*
   Utilizar 'exec [dbo].[sp_ForEachDB] null, 'SELECT * FROM TB_ArqGsf'' por exemplo
*/
--ALTER PROCEDURE [dbo].[sp_ForEachDB]
declare
 @Command1 varchar(max) = NULL, --Use ? to set the DBName, the If clause can be used to limit to only certain DBs.
 @Command2 varchar(max) = NULL,
 @Command3 varchar(max) = NULL,
 @ReplaceChar varchar(20) = '?', --Characters to replace with DBName, default to ?
 @PreCommand varchar(max) = NULL,
 @PostCommand varchar(max) = NULL

--AS
--BEGIN

SET NOCOUNT ON;

DECLARE @DBs as Table (DBName varchar(100), DBNumber int) --Temp table for DBs to run against
DECLARE @i int --Counter
DECLARE @DBCount int --Number of DBs to run over
DECLARE @DBName as varchar(100) --DB Name to run for instance within loop , used in a USE statement

DECLARE @SQL as varchar(8000) --Total SQL to run

DECLARE @WorkingSQL1 varchar(7900) = ''
DECLARE @WorkingSQL2 varchar(7900) = ''
DECLARE @WorkingSQL3 varchar(7900) = ''

-- PARA SABER O NOME DO BANCO USE DB_NAME(),

SET @Command1 = ' SELECT DB_NAME(), * FROM TB_CntSrvPdg  '

--Find all the Databases on server and put in temp table to run SQL over each
INSERT INTO @DBs
select name as DBName, ROW_NUMBER() OVER(PARTITION BY 1 ORDER BY name) AS DBNumber
from sys.databases
where name like 'DBMIRA%'
and not(name like '%SST%')
and not(name like '%GLOBAL%')
and not(name in ('DBMIRA_ANALYSIS','DBMIRA_BI','DBMIRA_SUPORTE'))

--Select * from @DBs

Select @DBCount = COUNT(*) from @DBs

Select @SQL = @PreCommand
exec(@SQL)

Set @i = 1
WHILE @i <= @DBCount --Start loop over all DB's
 BEGIN
 Select @DBName = DBname from @DBs where DBNumber = @i
 --Run First Command
 Select @WorkingSQL1 = replace(@Command1, @ReplaceChar, @DBName)
 Select @SQL = 'USE ' + @DBName + ' ' + @WorkingSQL1 
 PRINT @SQL
 exec(@SQL)
 --Run Second Command
 Select @WorkingSQL2 = replace(@Command2, @ReplaceChar, @DBName)
 Select @SQL = 'USE ' + @DBName + ' ' + @WorkingSQL2 
 PRINT @SQL
 exec(@SQL)
 --Run Third Command
 Select @WorkingSQL3 = replace(@Command3, @ReplaceChar, @DBName)
 Select @SQL = 'USE ' + @DBName + ' ' + @WorkingSQL3 
 PRINT @SQL
 exec(@SQL)
 
 Set @i = @i + 1
 END

Select @SQL = @PostCommand
exec(@SQL)
--END

GO