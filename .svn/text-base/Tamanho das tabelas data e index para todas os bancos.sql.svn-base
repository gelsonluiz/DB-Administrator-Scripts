--sqlserver 2005 +
EXECUTE sp_foreachdb 
'USE [?];

select top 10
getdate() as snapdate,
serverproperty(''MachineName'') svr,
@@servicename sv, 
''?'' _dbname, 
nomTable= object_name(p.object_id),
p.partition_id,
p.partition_number,
lignes = sum(CASE
                 When (p.index_id < 2) and (a.type = 1) Then p.rows
                 Else 0
             END
             ),
''memory (kB)'' = cast(ltrim(str(sum(a.total_pages)* 8192 / 1024.,15,0)) as float),
''data (kB)'' = ltrim(str(sum(
       CASE
           When a.type <> 1 Then a.used_pages
           When p.index_id < 2 Then a.data_pages
           Else 0
       END
   ) * 8192 / 1024.,15,0)),
''indexes (kb)'' = ltrim(str((sum(a.used_pages)-sum(
       CASE
           When a.type <> 1 Then a.used_pages
           When p.index_id < 2 Then a.data_pages
           Else 0
       END) )* 8192 / 1024.,15,0)),p.data_compression,
p.data_compression_desc
from sys.partitions p, sys.allocation_units a ,sys.sysobjects s
where p.partition_id = a.container_id
and p.object_id = s.id and s.type = ''U''    -- User table type (system tables exclusion)
group by p.object_id,p.partition_id,p.partition_number,p.data_compression,p.data_compression_desc
order by 9 desc'
;

