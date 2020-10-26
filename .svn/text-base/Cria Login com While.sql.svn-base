-- 01 Script para criação dos login no SQLserver conforme usuarios ativos no sistema Mira.
-- Após executado esse script execute o 02 Script para liberar acesso ao banco de auditoria do Regional

USE DBMIRAAL
GO

DECLARE 
@Chave Int,
@Pos INT,  -- Posição
@Cnt INT,  -- Quantidade de registros do while

@CD_LgnUsr integer,
@NM_Usr varchar (800),
@NM_LgnUsr varchar(200),
@NM_UsrAnt varchar(600),
@Banco varchar(200),
@Erro integer,
@UF_Ant VarChar(3),
@UF varchar(30),
@nameschema varchar(6000),
@namelogin varchar(6000),
@exec_stmt nvarchar(4000),
@Sql Varchar(250)


Set @UF_Ant = 'AL'
set @Banco = 'DBMIRAAL'
set @UF = @UF_Ant
set @Erro = 0

--****** 
PRINT '01- Script para excluir o Schema'
--******

DECLARE @Tmp1 TABLE (
   ID int Identity Primary Key,
   Chave Varchar(6000)) -- Chave representa os campos da tabela

INSERT INTO @Tmp1
SELECT 
name 
FROM sys.schemas 
WHERE name like @UF+'_%'

SELECT @Cnt = Count(ID) FROM @Tmp1
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
   SELECT 
   @nameschema = Temp.chave 
   FROM @Tmp1 Temp
   WHERE ID = @Pos
  
	set @exec_stmt = 'DROP SCHEMA '+quotename(@nameschema)
	
	EXEC sp_executesql @exec_stmt

   SET @Pos = @Pos + 1
end

--------------------------------------------------------------------------------------------------------


--****** 
PRINT '02 - Script excluir o Login no SQLServer'
--******

DECLARE @Tmp2 TABLE (
ID int Identity Primary Key,
Chave  Varchar(6000)) -- Chave representa os campos da tabela
   
INSERT INTO @Tmp2    
SELECT 
name 
FROM sys.server_principals 
WHERE name like @UF+'_%'
	
SELECT @Cnt = Count(ID) FROM @Tmp2
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
   SELECT 
   @namelogin = Temp.chave 
   FROM @Tmp2 Temp
   WHERE ID = @Pos

	set @exec_stmt = 'DROP LOGIN '+quotename(@namelogin)
	EXEC sp_executesql @exec_stmt
	
   SET @Pos = @Pos + 1
end
------------------------------

-- ****
PRINT '03 - Script para retirar os Users do Banco'
-- ****

DECLARE @Tmp3 TABLE (
ID int Identity Primary Key,
Chave  Varchar(6000)) -- Chave representa os campos da tabela
   
INSERT INTO @Tmp3
SELECT 
name 
FROM sys.database_principals 
WHERE name like @UF+'_%'
	
SELECT @Cnt = Count(ID) FROM @Tmp3
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
   SELECT 
   @namelogin = Temp.chave 
   FROM @Tmp3 Temp
   WHERE ID = @Pos
   
   set @exec_stmt = 'DROP USER '+quotename(@namelogin)
	
	EXEC sp_executesql @exec_stmt

   SET @Pos = @Pos + 1
END
------------------------------


--******
PRINT '04 - CRIA OS LOGINS'
--******

/*
Cursor para listar os logins da TB_LgnUsr para ser criado no SQLServer
com a sua respectiva Unidade Federativa - armazenada/informada na variavel "@UF"
*/
set @exec_stmt = ' '

DECLARE @Tmp4 TABLE (
ID int Identity Primary Key,
Chave Int,
NM_Usr VarChar(max),
NM_LgnUsr Varchar(max)) -- Chave representa os campos da tabela
   
INSERT INTO @Tmp4   
SELECT 
TB_LgnUsr.CD_LgnUsr,
@UF+'_'+TB_LgnUsr.NM_Usr,
@UF+'_'+TB_LgnUsr.NM_LgnUsr
from
TB_LgnUsr TB_LgnUsr
where ID_StcLgnUsr not in (1)
ORDER BY TB_LgnUsr.NM_LgnUsr 

SELECT @Cnt = Count(ID) FROM @Tmp4
SET @Pos = 1

WHILE @Cnt >= @Pos
BEGIN
   SELECT 
   @CD_LgnUsr = Temp.chave, 
   @NM_Usr = Temp.NM_Usr,
   @NM_LgnUsr = Temp.NM_LgnUsr
   FROM @Tmp4 Temp
   WHERE ID = @Pos
   
     print 'Adicionando o Login ('+Cast(@Pos as VarChar(4)) + '/'+Cast(@Cnt as VarChar(4)) +'): ' +@NM_LgnUsr

	 set @exec_stmt = 'CREATE LOGIN  '+ QUOTENAME(rtrim(@NM_LgnUsr)) +' with Password = ''debenture'' , DEFAULT_DATABASE = '+ quotename(@Banco)+ ' , DEFAULT_LANGUAGE = english ,  CHECK_POLICY = OFF'+char(13)
	 --EXEC sp_executesql @exec_stmt
	   
	 set @exec_stmt = @exec_stmt + 'create user '+ QUOTENAME(@NM_Usr)+' for login '+ QUOTENAME( @NM_LgnUsr) +'with DEFAULT_SCHEMA = db_owner '+char(13)
	 --EXEC sp_executesql @exec_stmt	 
	 
	 set @exec_stmt = @exec_stmt + 'ALTER USER '+quotename(@NM_Usr) + ' WITH DEFAULT_SCHEMA=[db_owner]'+char(13)
	 --EXEC sp_executesql @exec_stmt
	 
	 set @exec_stmt = @exec_stmt + 'EXEC sp_addrolemember N''db_owner'','+ quotename(@NM_Usr)
	 
	 EXEC sp_executesql @exec_stmt

    SET @Pos = @Pos + 1
END

USE DBAUDIT_AL

SET @Pos = 1
SET @exec_stmt = ''

WHILE @Cnt >= @Pos
BEGIN
   SELECT 
   @CD_LgnUsr = Temp.chave, 
   @NM_Usr = Temp.NM_Usr,
   @NM_LgnUsr = Temp.NM_LgnUsr
   FROM @Tmp4 Temp
   WHERE ID = @Pos

	SET @exec_stmt = ''
   
    print 'Adicionando o Login AUDIT ('+Cast(@Pos as VarChar(4)) + '/'+Cast(@Cnt as VarChar(4)) +'): ' +@NM_LgnUsr

	  set @exec_stmt = 'create user '+ QUOTENAME(@NM_Usr)+' for login '+ QUOTENAME( @NM_LgnUsr) +'with DEFAULT_SCHEMA = db_owner '+char(13)
	 -- EXEC sp_executesql @exec_stmt	 
	 
	 set @exec_stmt = @exec_stmt + 'ALTER USER '+quotename(@NM_Usr) + ' WITH DEFAULT_SCHEMA=[db_owner]'+char(13)
	 --EXEC sp_executesql @exec_stmt
	 
	 set @exec_stmt = @exec_stmt + 'EXEC sp_addrolemember N''db_owner'','+ quotename(@NM_Usr)
	 
	 PRINT @exec_stmt

	 EXEC sp_executesql @exec_stmt

    SET @Pos = @Pos + 1
END
