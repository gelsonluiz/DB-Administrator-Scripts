Declare @TEMP table (
spid smallint , -- The system process ID.
ecid smallint , /* The execution context ID of a given thread associated with a specific SPID.
		ECID = {0, 1, 2, 3, ...n}, where 0 always represents the main or parent thread, and {1, 2, 3, ...n} represent the sub-threads. */
 
status nchar(30) , -- The process status. 
loginame nchar(128) , --The login name associated with the particular process. 
hostname nchar(128), --  The host or computer name for each process. 
blk char(5) , /*  The system process ID for the blocking process, if one exists. Otherwise, this column is zero. 
When a transaction associated with a given spid is blocked by an orphan distributed transaction, this column will return a '-2' for the blocking orphan transaction. */
 
dbname nchar(128),  -- The database used by the process. 
cmd nchar(16), -- The SQL Server command (Transact-SQL statement, SQL Server internal engine process, and so on) executing for the process. 
request_id int
)
declare 
@blk_char char(5),
@blk_int int,
@loginame nchar(128)

insert into @TEMP exec sp_who

select 
* from @Temp 
--where blk = 1
where loginame = 'giulliano.cassio'


--drop table #TEMP
/*

	select 
	@blk_char = #TEMP.blk,
	@loginame = loginame
	from #TEMP
	where #TEMP.blk <> '0'
	if @blk_char <> '0'
	begin
		set @blk_int = cast(@blk_char as int)
--		select loginame from #TEMP where #TEMP.blk = @blk_char
		print 'Finalizar o processo : ' + @blk_char + ' do login : ' + @loginame

--		kill @blk_int
	end else
	begin
		print 'Não foi encontrado travamentos no banco de dados!'
	end


drop table #TEMP
*/