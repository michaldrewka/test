CREATE MATERIALIZED VIEW rel_18_a_12c2.refresh_mode_different (answer,nottheanswer)
ORGANIZATION HEAP 
AS SELECT "MASTER_TABLE"."ANSWER" "ANSWER","MASTER_TABLE"."NOTTHEANSWER" "NOTTHEANSWER" FROM rel_18_a_12c2."MASTER_TABLE" "MASTER_TABLE";