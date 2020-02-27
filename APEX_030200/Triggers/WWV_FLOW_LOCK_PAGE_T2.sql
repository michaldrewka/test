CREATE OR REPLACE trigger wwv_flow_lock_page_t2
BEFORE
delete on wwv_flow_lock_page
for each row
begin
insert into wwv_flow_lock_page_log (
   lock_id,lock_flow,lock_page,ACTION,ACTION_DATE,DEVELOPER,lock_comment)
   values (
   :old.id, :old.flow_id, :old.object_id,'UNLOCK',sysdate,v('USER'),:old.lock_comment);
end;
/