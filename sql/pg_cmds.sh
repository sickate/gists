# sql
\list or \l: list all databases
\dt: list all tables in the current database
\connect database_name: To switch databases
\c db_name: switch database
psql -U pgadmin -l：list all databases in terminal
\d: show all tables
\du：show all users

# 修改密码：
alter user user_name with password 'new_password'; 

# 创建 db
create database xxx；

# Dump 一整个库
pg_dump databasename > data_base_dump
# restore （需要先 create database)
psql databasename < data_base_dump
# or
pg_restore -d dbname dump_file_name

# create user
#  -P 表示 prompt 密码设置
#  -s 表示 superuser
#  -d 表示可以创建 database
#  -e 表示显示发送到 server 的命令详情
createuser yourname -s -d -P -e
