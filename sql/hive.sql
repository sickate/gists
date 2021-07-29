-- get distinct count
select count(distinct mobile_id) from table where pt like '2018-04-%' and log_type='win';

-- save to local: will empty out 'save' directory!
insert overwrite local directory '/data1/home/yourname/save' row format delimited fields terminated by '|' select * from dbname.tablename;

-- save to hdfs: will empty out 'xxx' directory
insert overwrite directory '/user/yourname/hive/dmp/xxx' row format delimited fields terminated by '|' select * from dbname.tablename;

-- write to table with partition
LOAD DATA INPATH '/data/hive_dw/pbs.db/t_dw_m_uv_fact/pt=2019-04-16' INTO TABLE pbs_fact PARTITION(pt='2019-04-16');

-- write to table from hdfs
-- 需要注意创建 table 时指定的 delimeter 要和 export data 时指定的一致
LOAD DATA INPATH '/data/hive_dw/pbs.db/t_dim_all_mapping' OVERWRITE INTO TABLE kylin_dw.dim_all_mapping;

-- show column name
set hive.cli.print.header=true;
-- or: echo "SET hive.cli.print.header=true;" >> ~/.hiverc

-- handle null value
select * from table where column1 is not NULL and column1 <> '';

-- pyspark, the same
select count(1) from (select user_id from dmp.dmp_mobile_tags) as a join (select ext_id from dmp.dmp_mac_all) as b on a.user_id=b.ext_id;

-- remove paritition
ALTER TABLE logs DROP IF EXISTS PARTITION(year = 2012, month = 12, day = 18);


-- regex
select user_ip, http_uri, count(*) as pv from pbs.t_pbs_log where user_ip RLIKE '^([1-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}$' group by user_ip, http_uri order by pv desc limit 20;


-- # cross（笛卡尔积）：不指定 on id，慎用
SELECT a.id,
a.name,
b.age
FROM a
CROSS JOIN b;

-- semi
SELECT a.id,
a.name
FROM a
LEFT SEMI JOIN b
ON (a.id = b.id);

-- # full （hive won’t use MapJoin 来优化）
SELECT a.id,
a.name,
b.age
FROM a
FULL OUTER JOIN b
ON (a.id = b.id);

-- # inner
SELECT a.id,
a.name,
b.age
FROM a
join b
ON (a.id = b.id);


--- settings ---
-- 是否开启动态分区功能，默认false关闭。使用动态分区时候，该参数必须设置成true;
SET hive.exec.dynamic.partition=true;

-- 动态分区的模式，默认strict，表示必须指定至少一个分区为静态分区，nonstrict模式表示允许所有的分区字段都可以使用动态分区。
SET hive.exec.dynamic.partition.mode=nonstrict;

-- 在每个执行MR的节点上，最大可以创建多少个动态分区。该参数需要根据实际的数据来设定。比如：源数据中包含了一年的数据，即day字段有365个值，那么该参数就需要设置成大于365，如果使用默认值100，则会报错。
SET hive.exec.max.dynamic.partitions.pernode = 1000;

-- 在所有执行MR的节点上，最大一共可以创建多少个动态分区。
SET hive.exec.max.dynamic.partitions=1000;

-- 整个MR Job中，最大可以创建多少个HDFS文件。默认值：100000
SET hive.exec.max.created.files=999999;

-- 当有空分区生成时，是否抛出异常。一般不需要设置。默认值：false
SET hive.error.on.empty.partition=false;

-- create partitioned table
CREATE EXTERNAL TABLE tab_a (
id INT,
ip STRING COMMENT 'user IP',
avg_view_depth DECIMAL(5,1),
bounce_rate DECIMAL(6,5)
) COMMENT 'comment string'
PARTITIONED BY (month STRING, day STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile;

-- insert data into partitioned table
INSERT overwrite TABLE tab_a PARTITION (month,day)
SELECT url, substr(day,1,7) AS month, day
FROM src_table;

-- 覆盖分区数据：
INSERT overwrite TABLE tab_a PARTITION (month = '2019-04',day = '15')
SELECT * FROM src_table;

-- add more partition
ALTER TABLE tab_a ADD PARTITION (month = '2019-04',day = '31') location 'hdfs://data/stagelog/month=2019-04/day=31/';

-- drop partition
ALTER TABLE tab_a DROP PARTITION (month = '2019-04',day = '31');

-- show table partition
show partitions tab_a;

-- show detail paritition info
desc formatted tab_a partition (month = '2019-04', day = '31');

-- create view
CREATE VIEW IF NOT EXISTS v_url (url COMMENT 'url')
COMMENT 'view url'
AS SELECT url FROM tab_a
WHERE url LIKE 'http://%'
LIMIT 100;


-- drop view
DROP VIEW IF EXISTS v_url;

-- alter view
ALTER VIEW v_url AS
SELECT url FROM tab_a limit 500;

--- ADMINS ------
set role ADMIN;

show roles;

SHOW CURRENT ROLES;

create role readonly;

grant role readonly to user readonly_user;

grant select on table batting to role readonly;

-- Verify grants for role readonly
show grant role readonly;

-- create db
CREATE DATABASE|SCHEMA [IF NOT EXISTS] db_name;

-- truncate
TRUNCATE TABLE tab;

--- show tblproperties
SHOW TBLPROPERTIES tblname;

-- show create table
SHOW create table t_dw_m_uv_fact;

-- output 
OK
CREATE TABLE `t_dw_m_uv_fact`(
  `hr` string,
  `ad_id` string,
  `deal_id` string,
  `mtid` string,
  `ad_place_id` string,
  `ad_plan_id` string,
  `media_id` string,
  `dmp` string,
  `dmp_project_id` string,
  `dmp_people_id` string,
  `ta` string,
  `device_type` string,
  `optimize` string,
  `user_id` string,
  `city_code` string,
  `bid_cnt` bigint,
  `win_cnt` bigint,
  `ck_cnt` bigint)
PARTITIONED BY (
  `pt` string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
  'hdfs://cdh5/hivedata/warehouse/pbs.db/t_dw_m_uv_fact'
TBLPROPERTIES (
  'transient_lastDdlTime'='1499831943')
