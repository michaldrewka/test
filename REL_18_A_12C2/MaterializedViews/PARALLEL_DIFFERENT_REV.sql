CREATE MATERIALIZED VIEW rel_18_a_12c2.parallel_different_rev (answer,nottheanswer)
ORGANIZATION HEAP 
PARALLEL
AS SELECT "MASTER_TABLE"."ANSWER" "ANSWER","MASTER_TABLE"."NOTTHEANSWER" "NOTTHEANSWER" FROM rel_18_a_12c2."MASTER_TABLE" "MASTER_TABLE";