CREATE OR REPLACE FORCE VIEW wwv_flow_years (year_value) AS
select i+1919 from wwv_flow_dual100
union all
select i+2019 from wwv_flow_dual100 where i < 32;