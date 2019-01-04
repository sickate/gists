-- get distinct count
select count(distinct mobile_id) from table where pt like '2018-04-%' and log_type='win';

-- save to local: will empty out 'save' directory!
insert overwrite local directory '/data1/home/yourname/save' row format delimited fields terminated by '|' select * from dbname.tablename;

-- save to hdfs: will empty out 'xxx' directory
insert overwrite directory '/user/yourname/hive/dmp/xxx' row format delimited fields terminated by '|' select * from dbname.tablename;

-- show column name
set hive.cli.print.header=true;
-- or: echo "SET hive.cli.print.header=true;" >> ~/.hiverc

-- handle null value
select * from table where column1 is not NULL and column1 <> '';
