
SELECT db_name(),	count(*) FROM	sys.tables
WHERE	OBJECT_ID IN  (
			SELECT	OBJECT_ID 
			FROM	sys.columns 
			WHERE	name = 'CD_PsaFsc'
		       )
order by name