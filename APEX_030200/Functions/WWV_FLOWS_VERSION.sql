CREATE OR REPLACE function wwv_flows_version
return varchar
as
begin
    --
    -- *** NOTE ***  The corresponding date in api.sql will need
    --               to be modified if this version is changed
    return '2009.01.12';
end;
/