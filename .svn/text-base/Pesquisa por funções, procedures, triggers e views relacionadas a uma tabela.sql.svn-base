select distinct 
 o.type_desc [ObjectType]
,o.name [ObjectName]
,c_display.colid [CodeSequence]
,c_display.[text] [Code]
from sys.objects o
inner join	sys.syscomments c_search on c_search.id = o.[object_id]
inner join	sys.syscomments c_display on c_display.id = o.[object_id]
where	o.type_desc not in ('INTERNAL_TABLE','SERVICE_QUEUE','SYSTEM_TABLE')
and c_search.[text] like '%TB_TmpHrrAlaGrl%'
order by	1, 2, 3