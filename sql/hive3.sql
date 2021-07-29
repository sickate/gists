-- show largest table in hive
use sys;
SELECT tbl_name, total_size
FROM table_stats_view v, tbls t
WHERE t.tbl_id = v.tbl_id ORDER BY
cast(v.total_size as int) DESC LIMIT 3;

-- find which table has a column named 'ssn'
use information_schema;
SELECT table_schema, table_name
FROM information_schema.columns
WHERE column_name LIKE '%ssn%'


-- table mapping
-- in psql
CREATE TABLE postgres_table
(
 id INT,
 name varchar
);

-- in hive
-- psql -h shanghai -p 30008 -U dlabuser -d graphy_production 
-- password: aQ%By6zgNTFb]PD
-- table_name: hymis_pbs_id_relations

CREATE EXTERNAL TABLE hymis_id_mapping
(
 mtid STRING,
 hymis_media_id STRING,
 hymis_pos_id STRING
)
STORED BY
'org.apache.hive.storage.jdbc.JdbcStorageHandler'
TBLPROPERTIES (
 "hive.sql.database.type" = "POSTGRES",
 "hive.sql.jdbc.driver"="org.postgresql.Driver",
 "hive.sql.jdbc.url"="jdbc:postgresql://shanghai:30008/graphy_production",
 "hive.sql.dbcp.username"="dlabuser",
 "hive.sql.dbcp.password"="aQ%By6zgNTFb]PD",
 "hive.sql.query"="select material_id, hymis_media_id, hymis_pos_id from hymis_pbs_id_relations",
 "hive.sql.column.mapping" = "mtid=material_id, hymis_media_id=hymis_media_id, hymis_pos_id=hymis_pos_id ",
 "hive.jdbc.update.on.duplicate" = "true"
);


-- ACID V1
CREATE TABLE hello_acid (load_date date, key int, value int)
CLUSTERED BY(key) INTO 3 BUCKETS
STORED AS ORC TBLPROPERTIES ('transactional'='true');

-- ACID V2
CREATE TABLE hello_acid_v2 (load_date date, key int, value int);
