USE [master]
GO
CREATE LOGIN [thiago.dias] WITH PASSWORD=N'123mudar' MUST_CHANGE, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

-- PARA 131 e 130
EXEC sys.sp_addsrvrolemember @loginame = N'thiago.dias', @rolename = N'sysadmin'
GO

-- PARA MS
USE [DBMIRAMS_IMPORT]
GO
CREATE USER [thiago.dias] FOR LOGIN [thiago.dias]
GO
EXEC sp_addrolemember N'db_owner', N'thiago.dias'
GO
EXEC sp_addrolemember N'db_datareader', N'thiago.dias'
GO
EXEC sp_addrolemember N'db_datawriter', N'thiago.dias'
GO
