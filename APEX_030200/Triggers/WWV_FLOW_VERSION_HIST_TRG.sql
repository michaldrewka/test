CREATE OR REPLACE trigger wwv_flow_version_hist_trg
    before insert on wwv_flow_version$
    for each row
begin
    select wwv_flow_version_seq.nextval,sysdate into :new.seq,:new.date_applied from dual;
end;
/