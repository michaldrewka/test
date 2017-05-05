CREATE OR REPLACE FORCE VIEW rel_18_a_12c2.xx_bjo2 ("OWNER",table_name,tablespace_name) AS
select "OWNER", "TABLE_NAME", "TABLESPACE_NAME"
from ALL_TABLES
where table_name like 'bin%';