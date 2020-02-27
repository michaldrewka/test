CREATE OR REPLACE trigger wwv_flow_worksheet_row_trig
    before insert or update on wwv_flow_worksheet_rows
    for each row
begin
    --
    -- maintain pk and timestamps
    --
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := nvl(wwv_flow.g_user,user);
        :new.updated_on := sysdate;
        :new.updated_by := nvl(wwv_flow.g_user,user);
        for c1 in (select wwv_flow_worksheet_seq.nextval lo
                     from dual ) loop
            :new.load_order := c1.lo;
        end loop;
    elsif updating then
        :new.updated_on := sysdate;
        :new.updated_by := nvl(wwv_flow.g_user,user);
    end if;
    --
    -- history
    --
    if updating then
       if nvl(:old.c001,'mJjOoH') != nvl(:new.c001,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c001', :old.c001, :new.c001, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c002,'mJjOoH') != nvl(:new.c002,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c002', :old.c002, :new.c002, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c003,'mJjOoH') != nvl(:new.c003,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c003', :old.c003, :new.c003, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c004,'mJjOoH') != nvl(:new.c004,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c004', :old.c004, :new.c004, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c005,'mJjOoH') != nvl(:new.c005,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c005', :old.c005, :new.c005, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c006,'mJjOoH') != nvl(:new.c006,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c006', :old.c006, :new.c006, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c007,'mJjOoH') != nvl(:new.c007,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c007', :old.c007, :new.c007, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c008,'mJjOoH') != nvl(:new.c008,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c008', :old.c008, :new.c008, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c009,'mJjOoH') != nvl(:new.c009,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c009', :old.c009, :new.c009, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c010,'mJjOoH') != nvl(:new.c010,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c010', :old.c010, :new.c010, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c010,'mJjOoH') != nvl(:new.c010,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c010', :old.c010, :new.c010, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c011,'mJjOoH') != nvl(:new.c011,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c011', :old.c011, :new.c011, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c012,'mJjOoH') != nvl(:new.c012,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c012', :old.c012, :new.c012, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c013,'mJjOoH') != nvl(:new.c013,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c013', :old.c013, :new.c013, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c014,'mJjOoH') != nvl(:new.c014,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c014', :old.c014, :new.c014, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c015,'mJjOoH') != nvl(:new.c015,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c015', :old.c015, :new.c015, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c016,'mJjOoH') != nvl(:new.c016,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c016', :old.c016, :new.c016, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c017,'mJjOoH') != nvl(:new.c017,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c017', :old.c017, :new.c017, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c018,'mJjOoH') != nvl(:new.c018,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c018', :old.c018, :new.c018, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c019,'mJjOoH') != nvl(:new.c019,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c019', :old.c019, :new.c019, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c020,'mJjOoH') != nvl(:new.c020,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c020', :old.c020, :new.c020, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c021,'mJjOoH') != nvl(:new.c021,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c021', :old.c021, :new.c021, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c022,'mJjOoH') != nvl(:new.c022,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c022', :old.c022, :new.c022, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c023,'mJjOoH') != nvl(:new.c023,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c023', :old.c023, :new.c023, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c024,'mJjOoH') != nvl(:new.c024,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c024', :old.c024, :new.c024, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c025,'mJjOoH') != nvl(:new.c025,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c025', :old.c025, :new.c025, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c026,'mJjOoH') != nvl(:new.c026,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c026', :old.c026, :new.c026, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c027,'mJjOoH') != nvl(:new.c027,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c027', :old.c027, :new.c027, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c028,'mJjOoH') != nvl(:new.c028,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c028', :old.c028, :new.c028, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c029,'mJjOoH') != nvl(:new.c029,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c029', :old.c029, :new.c029, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.c030,'mJjOoH') != nvl(:new.c030,'mJjOoH') then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'c030', :old.c030, :new.c030, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       --
       -- numbers
       --
       if nvl(:old.n001,867530731415911111) != nvl(:new.n001,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n001', :old.n001, :new.n001, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n002,867530731415911111) != nvl(:new.n002,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n002', :old.n002, :new.n002, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n003,867530731415911111) != nvl(:new.n003,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n003', :old.n003, :new.n003, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n004,867530731415911111) != nvl(:new.n004,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n004', :old.n004, :new.n004, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n005,867530731415911111) != nvl(:new.n005,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n005', :old.n005, :new.n005, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n006,867530731415911111) != nvl(:new.n006,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n006', :old.n006, :new.n006, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n007,867530731415911111) != nvl(:new.n007,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n007', :old.n007, :new.n007, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n008,867530731415911111) != nvl(:new.n008,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n008', :old.n008, :new.n008, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n009,867530731415911111) != nvl(:new.n009,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n009', :old.n009, :new.n009, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n010,867530731415911111) != nvl(:new.n010,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n010', :old.n010, :new.n010, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n010,867530731415911111) != nvl(:new.n010,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n010', :old.n010, :new.n010, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n011,867530731415911111) != nvl(:new.n011,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n011', :old.n011, :new.n011, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n012,867530731415911111) != nvl(:new.n012,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n012', :old.n012, :new.n012, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n013,867530731415911111) != nvl(:new.n013,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n013', :old.n013, :new.n013, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n014,867530731415911111) != nvl(:new.n014,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n014', :old.n014, :new.n014, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n015,867530731415911111) != nvl(:new.n015,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n015', :old.n015, :new.n015, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n016,867530731415911111) != nvl(:new.n016,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n016', :old.n016, :new.n016, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n017,867530731415911111) != nvl(:new.n017,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n017', :old.n017, :new.n017, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n018,867530731415911111) != nvl(:new.n018,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n018', :old.n018, :new.n018, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n019,867530731415911111) != nvl(:new.n019,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n019', :old.n019, :new.n019, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.n020,867530731415911111) != nvl(:new.n020,867530731415911111) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'n020', :old.n020, :new.n020, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       --
       -- dates
       --
       if nvl(:old.d001,to_date('10000101','YYYYMMDD')) != nvl(:new.d001,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd001', :old.d001, :new.d001, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d002,to_date('10000101','YYYYMMDD')) != nvl(:new.d002,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd002', :old.d002, :new.d002, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d003,to_date('10000101','YYYYMMDD')) != nvl(:new.d003,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd003', :old.d003, :new.d003, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d004,to_date('10000101','YYYYMMDD')) != nvl(:new.d004,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd004', :old.d004, :new.d004, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d005,to_date('10000101','YYYYMMDD')) != nvl(:new.d005,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd005', :old.d005, :new.d005, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d006,to_date('10000101','YYYYMMDD')) != nvl(:new.d006,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd006', :old.d006, :new.d006, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d007,to_date('10000101','YYYYMMDD')) != nvl(:new.d007,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd007', :old.d007, :new.d007, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d008,to_date('10000101','YYYYMMDD')) != nvl(:new.d008,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd008', :old.d008, :new.d008, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d009,to_date('10000101','YYYYMMDD')) != nvl(:new.d009,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd009', :old.d009, :new.d009, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d010,to_date('10000101','YYYYMMDD')) != nvl(:new.d010,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd010', :old.d010, :new.d010, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d010,to_date('10000101','YYYYMMDD')) != nvl(:new.d010,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd010', :old.d010, :new.d010, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d011,to_date('10000101','YYYYMMDD')) != nvl(:new.d011,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd011', :old.d011, :new.d011, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d012,to_date('10000101','YYYYMMDD')) != nvl(:new.d012,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd012', :old.d012, :new.d012, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d013,to_date('10000101','YYYYMMDD')) != nvl(:new.d013,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd013', :old.d013, :new.d013, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d014,to_date('10000101','YYYYMMDD')) != nvl(:new.d014,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd014', :old.d014, :new.d014, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d015,to_date('10000101','YYYYMMDD')) != nvl(:new.d015,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd015', :old.d015, :new.d015, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d016,to_date('10000101','YYYYMMDD')) != nvl(:new.d016,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd016', :old.d016, :new.d016, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d017,to_date('10000101','YYYYMMDD')) != nvl(:new.d017,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd017', :old.d017, :new.d017, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d018,to_date('10000101','YYYYMMDD')) != nvl(:new.d018,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd018', :old.d018, :new.d018, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d019,to_date('10000101','YYYYMMDD')) != nvl(:new.d019,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd019', :old.d019, :new.d019, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
       if nvl(:old.d020,to_date('10000101','YYYYMMDD')) != nvl(:new.d020,to_date('10000101','YYYYMMDD')) then
           insert into wwv_flow_worksheet_history (row_id, worksheet_id, column_name, old_value,new_value,change_date,security_group_id,application_user_id)
           values (:new.id, :new.worksheet_id, 'd020', :old.d020, :new.d020, sysdate, :new.security_group_id,v('APP_USER'));
       end if;
    end if;
    --
    -- inserting remove chr 13
    --
    if instr(:new.c001,chr(13)) > 0 then :new.c001 := replace(:new.c001,chr(13),null); end if;
    if instr(:new.c002,chr(13)) > 0 then :new.c002 := replace(:new.c002,chr(13),null); end if;
    if instr(:new.c003,chr(13)) > 0 then :new.c003 := replace(:new.c003,chr(13),null); end if;
    if instr(:new.c004,chr(13)) > 0 then :new.c004 := replace(:new.c004,chr(13),null); end if;
    if instr(:new.c005,chr(13)) > 0 then :new.c005 := replace(:new.c005,chr(13),null); end if;
    if instr(:new.c006,chr(13)) > 0 then :new.c006 := replace(:new.c006,chr(13),null); end if;
    if instr(:new.c007,chr(13)) > 0 then :new.c007 := replace(:new.c007,chr(13),null); end if;
    if instr(:new.c008,chr(13)) > 0 then :new.c008 := replace(:new.c008,chr(13),null); end if;
    if instr(:new.c009,chr(13)) > 0 then :new.c009 := replace(:new.c009,chr(13),null); end if;
    if instr(:new.c010,chr(13)) > 0 then :new.c010 := replace(:new.c010,chr(13),null); end if;
    if instr(:new.c011,chr(13)) > 0 then :new.c011 := replace(:new.c011,chr(13),null); end if;
    if instr(:new.c012,chr(13)) > 0 then :new.c012 := replace(:new.c012,chr(13),null); end if;
    if instr(:new.c013,chr(13)) > 0 then :new.c013 := replace(:new.c013,chr(13),null); end if;
    if instr(:new.c014,chr(13)) > 0 then :new.c014 := replace(:new.c014,chr(13),null); end if;
    if instr(:new.c015,chr(13)) > 0 then :new.c015 := replace(:new.c015,chr(13),null); end if;
    if instr(:new.c016,chr(13)) > 0 then :new.c016 := replace(:new.c016,chr(13),null); end if;
    if instr(:new.c017,chr(13)) > 0 then :new.c017 := replace(:new.c017,chr(13),null); end if;
    if instr(:new.c018,chr(13)) > 0 then :new.c018 := replace(:new.c018,chr(13),null); end if;
    if instr(:new.c019,chr(13)) > 0 then :new.c019 := replace(:new.c019,chr(13),null); end if;
    if instr(:new.c020,chr(13)) > 0 then :new.c020 := replace(:new.c010,chr(23),null); end if;
    if instr(:new.c021,chr(13)) > 0 then :new.c021 := replace(:new.c001,chr(23),null); end if;
    if instr(:new.c022,chr(13)) > 0 then :new.c022 := replace(:new.c002,chr(23),null); end if;
    if instr(:new.c023,chr(13)) > 0 then :new.c023 := replace(:new.c003,chr(23),null); end if;
    if instr(:new.c024,chr(13)) > 0 then :new.c024 := replace(:new.c004,chr(23),null); end if;
    if instr(:new.c025,chr(13)) > 0 then :new.c025 := replace(:new.c005,chr(23),null); end if;
    if instr(:new.c026,chr(13)) > 0 then :new.c026 := replace(:new.c006,chr(23),null); end if;
    if instr(:new.c027,chr(13)) > 0 then :new.c027 := replace(:new.c007,chr(23),null); end if;
    if instr(:new.c028,chr(13)) > 0 then :new.c028 := replace(:new.c008,chr(23),null); end if;
    if instr(:new.c029,chr(13)) > 0 then :new.c029 := replace(:new.c009,chr(23),null); end if;
    if instr(:new.c030,chr(13)) > 0 then :new.c030 := replace(:new.c030,chr(13),null); end if;
    if instr(:new.c031,chr(13)) > 0 then :new.c031 := replace(:new.c031,chr(13),null); end if;
    if instr(:new.c032,chr(13)) > 0 then :new.c032 := replace(:new.c032,chr(13),null); end if;
    if instr(:new.c033,chr(13)) > 0 then :new.c033 := replace(:new.c033,chr(13),null); end if;
    if instr(:new.c034,chr(13)) > 0 then :new.c034 := replace(:new.c034,chr(13),null); end if;
    if instr(:new.c035,chr(13)) > 0 then :new.c035 := replace(:new.c035,chr(13),null); end if;
    if instr(:new.c036,chr(13)) > 0 then :new.c036 := replace(:new.c036,chr(13),null); end if;
    if instr(:new.c037,chr(13)) > 0 then :new.c037 := replace(:new.c037,chr(13),null); end if;
    if instr(:new.c038,chr(13)) > 0 then :new.c038 := replace(:new.c038,chr(13),null); end if;
    if instr(:new.c039,chr(13)) > 0 then :new.c039 := replace(:new.c039,chr(13),null); end if;
    if instr(:new.c040,chr(13)) > 0 then :new.c040 := replace(:new.c040,chr(13),null); end if;
    if instr(:new.c041,chr(13)) > 0 then :new.c041 := replace(:new.c041,chr(13),null); end if;
    if instr(:new.c042,chr(13)) > 0 then :new.c042 := replace(:new.c042,chr(13),null); end if;
    if instr(:new.c043,chr(13)) > 0 then :new.c043 := replace(:new.c043,chr(13),null); end if;
    if instr(:new.c044,chr(13)) > 0 then :new.c044 := replace(:new.c044,chr(13),null); end if;
    if instr(:new.c045,chr(13)) > 0 then :new.c045 := replace(:new.c045,chr(13),null); end if;
    if instr(:new.c046,chr(13)) > 0 then :new.c046 := replace(:new.c046,chr(13),null); end if;
    if instr(:new.c047,chr(13)) > 0 then :new.c047 := replace(:new.c047,chr(13),null); end if;
    if instr(:new.c048,chr(13)) > 0 then :new.c048 := replace(:new.c048,chr(13),null); end if;
    if instr(:new.c049,chr(13)) > 0 then :new.c049 := replace(:new.c049,chr(13),null); end if;
    if instr(:new.c050,chr(13)) > 0 then :new.c050 := replace(:new.c050,chr(13),null); end if;
    --
    -- update parent timestamp
    --
    update wwv_flow_worksheets
       set updated_on = :new.updated_on,
           updated_by = :new.updated_by
     where id = :new.worksheet_id;
    --
    -- set owner
    --
    if :new.owner is null then
        :new.owner := :new.created_by;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := wwv_flow.get_sgid;
    end if;
end;
/