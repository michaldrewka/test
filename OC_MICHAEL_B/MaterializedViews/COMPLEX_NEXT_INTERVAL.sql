CREATE MATERIALIZED VIEW oc_michael_b.complex_next_interval ("HelloNewColumn")
ORGANIZATION HEAP 
REFRESH COMPLETE START WITH TO_DATE('2030-1-1 13:0:0', 'yyyy-mm-dd hh24:mi:ss') NEXT cast(trunc(sysdate,'HH') as timestamp) + interval'1'hour 
AS ( 
SELECT answer FROM oc_michael_b.master_table
);