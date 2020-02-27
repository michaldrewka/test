CREATE OR REPLACE package wwv_flow_upgrade_report
as

procedure show_counts(
    p_schema1   in varchar2,
    p_schema2   in varchar2 default null)
;


procedure show_log
;

procedure depend
;

procedure table_difs(
    p_schema1   in varchar2,
    p_schema2   in varchar2)
;

procedure column_difs(
    p_schema1   in varchar2,
    p_schema2   in varchar2)
;

end wwv_flow_upgrade_report;
/