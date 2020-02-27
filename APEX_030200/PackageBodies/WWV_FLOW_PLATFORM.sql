CREATE OR REPLACE package body wwv_flow_platform
as

function get_preference (
   p_preference_name in varchar2)
   return varchar2
is
begin
   for c1 in (select value v from wwv_flow_platform_prefs where name = p_preference_name) loop
     return c1.v;
   end loop;
   return null;
end get_preference;

procedure set_preference (
   p_preference_name  in varchar2,
   p_preference_value in varchar2 )
is
begin
    --
    -- As null preference values are not permitted, a null value is an implicit delete
    --
    if p_preference_value is null then
        delete from wwv_flow_platform_prefs
         where name = p_preference_name;

       if p_preference_name = 'DISABLE_WS_PROV' then
          delete from wwv_flow_platform_prefs
           where name = 'DISABLE_WS_MSG';
       end if;
    else
        update wwv_flow_platform_prefs
           set value = p_preference_value
         where name = p_preference_name;
        --
        -- If the row wasn't found, then this implies insert
        --
        if SQL%ROWCOUNT = 0 then
            insert into wwv_flow_platform_prefs( name, value )
            values( p_preference_name, p_preference_value );
        end if;
    end if;
end set_preference;


end wwv_flow_platform;
/