CREATE OR REPLACE trigger wwv_flow_worksheets_ad_trig
    after delete on wwv_flow_worksheets
begin
    wwv_flow_worksheet.g_delete_in_progress := false;
end;
/