Select  volume_mount_point,
max(vs.total_bytes) /1024.0/1024/1024 TotalSpaceGB ,
min(available_bytes)/1024.0/1024/1024 FreespaceGB  ,
Count(*) as DBFileCount
from sys.master_files S cross apply Sys.dm_os_volume_stats(s.database_id,s.file_id) vs 
Group by volume_mount_point

Go
Select 
physical_name,
name, 
db_name(database_id) DBName,
size*8.0/1024 SizeMB, 
Name 
from sys.master_files 
order by size Desc
Go