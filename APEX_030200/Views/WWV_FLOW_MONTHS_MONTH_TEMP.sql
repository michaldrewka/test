CREATE OR REPLACE FORCE VIEW wwv_flow_months_month_temp (month_display,month_value) AS
select to_char(to_date(to_char(rownum,'00'),'MM'),'Month') month, rownum value from wwv_flow_dual100
where rownum < 13
union all
select '                    ', 20 from dual;