
use DBMIRAPE;

select 
db_name() as databasename
,schema_name(schema_id) as schema_name
,object_name(parent_object_id) parent_name
, name as object_name 
,type_desc
,create_date
,modify_date
from sys.objects
where substring(name,1,1) != '#' 
and substring(isnull(object_name(parent_object_id),''),1,1) != '#' 
and modify_date >= 'Dec 20 2012  8:35AM'
order by db_name(), schema_name(schema_id), name;