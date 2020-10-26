-- 
--
-- set @table_name before to use it
--
declare @table_name varchar(200)
set @table_name = 'TB_CmlAdtCnl'

select 
	 cols.name
	,cols.column_id
	,cols.max_length as size
	,cols.precision
	,cols.scale
	,cols.is_identity
	,cols.is_nullable
	,tipus.name as [type]
	,domain.name as [user_type]
	,(select key_ordinal 
	  from sys.index_columns as ic
	  where ic.object_id = (select parent_object_id 
						         from sys.key_constraints 
						         where type = 'PK' 
							      and parent_object_id = cols.object_id)
		                     and ic.index_id = (select unique_index_id 
							      from sys.key_constraints 
							      where type = 'PK' 
								   and parent_object_id = cols.object_id)
		and ic.column_id = cols.column_id) as pk_ordinal
	,cols.name +' '+ tipus.name + Case when tipus.name = 'int' then '' Else '('+cast(cols.max_length as Varchar(20))+CASE WHEN cols.precision = 0 THEN '' ELSE ','+ CAST(cols.precision AS Varchar(6)) END+')' END 
   from sys.columns as cols
	left join sys.types as tipus on tipus.system_type_id = cols.system_type_id 
	and tipus.user_type_id = cols.system_type_id 
	and tipus.is_user_defined = 0
	left join sys.types as domain	on domain.user_type_id = cols.user_type_id 
	and domain.is_user_defined = 1
   where cols.object_id = (select object_id 
						         from sys.tables 
						         where name = @table_name)