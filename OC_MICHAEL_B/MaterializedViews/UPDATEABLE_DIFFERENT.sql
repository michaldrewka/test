CREATE MATERIALIZED VIEW oc_michael_b.updateable_different (answer,nottheanswer)
ORGANIZATION HEAP 
AS SELECT "MASTER_TABLE"."ANSWER" "ANSWER","MASTER_TABLE"."NOTTHEANSWER" "NOTTHEANSWER" FROM oc_michael_b."MASTER_TABLE" "MASTER_TABLE";