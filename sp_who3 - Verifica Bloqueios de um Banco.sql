-- Informe a procedure e o nome do banco 
ALTER PROCEDURE sp_who3 @DBName VarChar(120) = null
AS

--DECLARE @DBName VarChar(120)
--SET @DBName = 'DBMIRAPE'

DECLARE @TEMP TABLE (
[spid] smallint , -- The system process ID.
[Status] VarChar(30),
[Login] Varchar(128) , --The login name associated with the particular process. 
[Hostname] Varchar(128), --  The host or computer name for each process. 
[BlkBy] char(10) , /*  The system process ID for the blocking process, if one exists. Otherwise, this column is zero. When a transaction associated with a given spid is blocked by an orphan distributed transaction, this column will return a '-2' for the blocking orphan transaction. */
[DBName] Varchar(128),  -- The database used by the process. 
[Command] Varchar(60),
[CPUTime] Int,
[DiskIO] Int,
[LastBatch] Varchar(15),
[ProgramName] VarChar(160),
[SPID_II] SmallInt,
[RequestID] SmallInt
)

insert into @TEMP EXEC sp_who2

SELECT * FROM @TEMP WHERE ((@DBName IS NULL) OR (DBName = @DBName))
