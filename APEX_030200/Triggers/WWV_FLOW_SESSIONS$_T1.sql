CREATE OR REPLACE trigger WWV_FLOW_SESSIONS$_T1
BEFORE
delete on WWV_FLOW_SESSIONS$
for each row
begin
   delete from wwv_flow_debug where id = :old.id;
   delete from wwv_flow_worksheet_rpts where session_id = :old.id;
   --
   update wwv_flow_companies
   set last_login = trunc(:old.CREATED_ON)
   where provisioning_company_id = :old.security_group_id and
        (last_login < trunc(:old.CREATED_ON) or last_login is null);
end;
/