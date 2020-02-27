CREATE OR REPLACE FORCE VIEW wwv_flow_minutes_5 (minute_value) AS
select (i-1)*5 from wwv_flow_dual100 where i < 13;