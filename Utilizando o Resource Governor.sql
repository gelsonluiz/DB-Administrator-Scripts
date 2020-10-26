/*
 SP_CONFIGURE
 http://imasters.com.br/artigo/7620/sql-server/configuracoes-de-performance-no-sql-server-2005/

sp_CONFIGURE 'show adv'
sp_configure 'max ser', 28672
go
sp_configure 'min ser'
go
RECONFIGURE WITH OVERRIDE
GO
---------------------------------------------------------------------------------------------------
name	                     minimum	maximum	   config_value	run_value
min memory per query (KB)	512	   2147483647	1024	         1024

exec SP_CONFIGURE 'min memory per query',3072
GO
RECONFIGURE WITH OVERRIDE
GO
---------------------------------------------------------------------------------------------------
*/


--/*
-- http://zavaschi.com/index.php/2011/01/sql-server-resource-governor/
-- 

/*
-- disable resource governor
ALTER RESOURCE GOVERNOR DISABLE

ALTER RESOURCE GOVERNOR 

-- reconfigure the Resource Governor
--    RECONFIGURE enables resource governor
ALTER RESOURCE GOVERNOR RECONFIGURE
GO
*/

/*
-- change the value of MAX_MEMORY_PERCENT
ALTER RESOURCE POOL "default"
WITH ( MAX_MEMORY_PERCENT = 100 )

ALTER RESOURCE POOL "default"
WITH ( MAX_CPU_PERCENT = 70 )

ALTER RESOURCE POOL SistemaQueries
WITH ( MAX_MEMORY_PERCENT = 100 )

ALTER RESOURCE POOL SistemaQueries
WITH (MAX_CPU_PERCENT = 70)

ALTER RESOURCE POOL NormalQueries
WITH ( MAX_MEMORY_PERCENT = 80 )

ALTER RESOURCE POOL ModuloWeb
WITH ( MAX_MEMORY_PERCENT = 80 )
go

CREATE RESOURCE POOL MatriculaWeb
WITH ( MAX_MEMORY_PERCENT = 100 )
go

*/

/*

CREATE WORKLOAD GROUP AdhocAdm
USING NormalQueries

CREATE WORKLOAD GROUP UsuariosSistema
USING SistemaQueries

CREATE WORKLOAD GROUP UsuariosWeb
USING ModuloWeb

CREATE WORKLOAD GROUP UsMatWeb
USING MatriculaWeb
*/

/*
ALTER RESOURCE GOVERNOR DISABLE

ALTER RESOURCE GOVERNOR
WITH (CLASSIFIER_FUNCTION = Null)
go

CREATE FUNCTION fnClassificadora()
RETURNS SYSNAME WITH SCHEMABINDING
BEGIN
   DECLARE @x SYSNAME
   DECLARE @user VARCHAR(50) = SUSER_SNAME();

   IF (@user = 'DB_SISTEMA')
   BEGIN
      SET @x = 'UsMatWeb';
   END ELSE
   IF APP_NAME() LIKE 'Microsoft SQL Server Management Studio%'
   BEGIN
      SET @x = 'AdhocAdm';
   END ELSE   
   IF ((APP_NAME() LIKE 'EntityFramework%') OR (APP_NAME() LIKE '.Net SqlClient Data Provider'))
   BEGIN
      SET @x = 'UsuariosWeb';
   END ELSE
      SET @x = 'UsuariosSistema';
   
   RETURN @x;
END
go

ALTER RESOURCE GOVERNOR
WITH (CLASSIFIER_FUNCTION = dbo.fnClassificadora)

ALTER RESOURCE GOVERNOR RECONFIGURE

*/

/*
SELECT 
       pool_id
     , Name
     , min_cpu_percent
     , max_cpu_percent
     , min_memory_percent
     , max_memory_percent
     , max_memory_kb/1024 AS max_memory_mb
     , used_memory_kb/1024 AS used_memory_mb 
     , target_memory_kb/1024 AS target_memory_mb
   FROM sys.dm_resource_governor_resource_pools
  */ 

SELECT *
--sess.session_id, 
--sess.login_name, 
--sess.group_id, 
--grps.name,
--sess.program_name,
--sess.reads,
--sess.writes,
--sess.logical_reads,
--sess.memory_usage,
--sess.cpu_time,
--sess.total_elapsed_time
FROM sys.dm_exec_sessions AS sess
JOIN sys.dm_resource_governor_workload_groups AS grps
     ON sess.group_id = grps.group_id
WHERE sess.login_name LIKE 'DB_Sistema'
ORDER BY sess.login_name