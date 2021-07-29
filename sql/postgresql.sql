---export csv with head
copy (select id, name, encrypted_pid, id_status, version, updated_at from people) to '/mnt/people.csv' delimiter '|' CSV header;
copy (select id, name, encrypted_pid, id_status, version, updated_at from people) to '/mnt/people.csv' WITH (FORMAT CSV, HEADER TRUE, FORCE_QUOTE *)

---import csv file data into a PSQL table
copy rule_lifts from '/data/40_rule_lift.csv' delimiter ',' CSV header;


---import partical columns copy applications(id,state,applicant_id,search_index) from '/tmp/app.csv' delimiter '|' CSV;

---export from multiple tables
copy (select a.encode_number, r.risk, r.result from rule_results as r, applications as a where a.tid=247 and r.application_id = a.id) to '/mnt/a.csv' with csv DELIMITER '|';

-- insert from other table
insert into partial (id, part_pid)  select tmp_people.id, substring(tmp_people.pid from 7) from tmp_people;

-- update from other table
insert into partial (id, part_pid)  select tmp_people.id, substring(tmp_people.pid from 7) from tmp_people where tmp_people.pid = '2342vssdf2342';


-------------------------
--- alter table commands
-------------------------

-- remove not null constraints
alter table users alter column email drop not null;

-- update one table according to another table with join
update categories set collections = tt.collections, should_crawl=tt.should_crawl from tt where tt.uid = categories.uid;

-- create table
create table tt(uid text, should_crawl integer, collections text[]);


-------------------------
--- Maintainance commands
-------------------------

createuser yzhang -s -d -P -e


--- get db size 
select t1.datname AS db_name,
       pg_size_pretty(pg_database_size(t1.datname)) as db_size
from pg_database t1
order by pg_database_size(t1.datname) desc;

-- set nextval index: repair internal sequence
-- If it's not higher... run this set the sequence last to your highest pid it. 
-- (wise to run a quick pg_dump first...)
SELECT setval('your_table_id_seq', (SELECT MAX(id) FROM your_table));

-- Then run...
-- This should be higher than the last result.
SELECT nextval('your_table_id_seq');

-- terminate all active user connection
SELECT pid, pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = current_database() AND pid <> pg_backend_pid();

-- 删除重复的 row (deduplicate)
-- ctid is: The physical location of the row version within its table. 
-- Note that although the ctid can be used to locate the row version very quickly, a row's ctid will change each time it is updated or moved by VACUUM FULL. Therefore ctid is useless as a long-term row identifier.
DELETE FROM hot_searches a USING (
   SELECT MIN(ctid) as ctid, hot_on, keyword
     FROM hot_searches
     GROUP BY hot_on, keyword HAVING COUNT(*) > 1
   ) b
   WHERE a.hot_on = b.hot_on and a.keyword = b.keyword
   AND a.ctid <> b.ctid
