CREATE OR REPLACE function wwv_flow_epg_include_mod_local(
    procedure_name in varchar2)
return boolean
is
begin
    return false; -- remove this statement when you modify this function
    --
    -- Administrator note: the procedure_name input parameter may be in the format:
    --
    --    procedure
    --    schema.procedure
    --    package.procedure
    --    schema.package.procedure
    --
    -- If the expected input parameter is a procedure name only, the IN list code shown below
    -- can be modified to itemize the expected procedure names. Otherwise you must parse the
    -- procedure_name parameter and replace the simple code below with code that will evaluate
    -- all of the cases listed above.
    --
    if upper(procedure_name) in (
          '') then
        return TRUE;
    else
        return FALSE;
    end if;
end wwv_flow_epg_include_mod_local;
/