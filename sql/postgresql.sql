---export csv with head
copy (select id, name, encrypted_pid, id_status, version, updated_at from people) to '/mnt/people.csv' delimiter '|' CSV header;

---import csv file data into a PSQL table
copy rule_lifts from '/data/40_rule_lift.csv' delimiter ',' CSV header;

---import partical columns
copy applications(id,state,applicant_id,search_index) from '/tmp/app.csv' delimiter '|' CSV;

---export from multiple tables
copy (select a.encode_number, r.risk, r.result from rule_results as r, applications as a where a.tid=247 and r.application_id = a.id) to '/mnt/a.csv' with csv DELIMITER '|';

-- insert from other table
insert into partial (id, part_pid)  select tmp_people.id, substring(tmp_people.pid from 7) from tmp_people;

-- update from other table
insert into partial (id, part_pid)  select tmp_people.id, substring(tmp_people.pid from 7) from tmp_people where tmp_people.pid = '2342vssdf2342';

-------------------------
--- Maintainance commands
-------------------------

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
