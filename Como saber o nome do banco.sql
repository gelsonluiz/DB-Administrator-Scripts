DECLARE @DB NVARCHAR(500) 

set @DB = ( SELECT top 1 specific_catalog  FROM INFORMATION_SCHEMA.ROUTINES )
print @DB
-- OU
SET @DB = DB_NAME() 
print @DB