CREATE OR REPLACE FORCE VIEW wwv_flow_months_month (month_display,month_value) AS
select "MONTH_DISPLAY","MONTH_VALUE" from wwv_flow_months_month_temp where month_value < 13;