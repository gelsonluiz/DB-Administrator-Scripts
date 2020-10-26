-- Clique em New Query para criar uma nova query, em seguida digite o código abaixo:
USE master
GO
/* Criando o Linked Server */
EXEC master.dbo.sp_addlinkedserver
@server = N'PROD_SVR', -- Nome do Linked
@srvproduct=N'LinkedServerComProducao',  -- Descrição
@provider=N'SQLNCLI10', -- Provider para SQL Server Native Client 10.0
@datasrc=N'200.189.102.130' -- Caminho do banco, ou no caso, IP do Servidor

/* Criando o login de acesso do Linked Server*/
EXEC master.dbo.sp_addlinkedsrvlogin
@rmtsrvname=N'PROD_SVR', -- Nome criado do Linked
@useself=N'False', -- Se outros usuários usarão
@locallogin=N'gelson.luiz', -- Usuário do banco local que terá acesso
@rmtuser=N'gelson.luiz', -- login do banco do outro servidor
@rmtpassword='debenture' -- senha do banco do outro servidor


EXEC sp_droplinkedsrvlogin 'PROD_SVR', 'gelson.luiz'
GO


/****** Object:  LinkedServer [PROD_SVR]    Script Date: 08/08/2016 14:44:46 ******/
IF EXISTS (SELECT srv.name FROM sys.servers srv WHERE srv.server_id != 0 AND srv.name = N'PROD_SVR')
   EXEC master.dbo.sp_dropserver @server=N'PROD_SVR', @droplogins='droplogins'
GO

-- Leia mais em: http://www.webartigos.com/artigos/como-criar-um-linked-server-com-sql-server-2008-e-sua-utilidade/90714/#ixzz4GkUOCSIF


select * from [PROD_SVR].[DBMIRAAC].[dbo].TB_Psi