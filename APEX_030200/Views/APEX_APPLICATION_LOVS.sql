CREATE OR REPLACE FORCE VIEW apex_application_lovs (workspace,application_id,application_name,list_of_values_name,lov_type,list_of_values_query,lov_entries,is_subscribed,subscribed_from,last_updated_by,last_updated_on,component_comment,lov_id,referenced_lov_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    l.LOV_NAME                       list_of_values_name,
    --
    decode(substr(l.lov_query,1,1),
    '.','Static','Dynamic')          lov_type,
    decode(substr(l.lov_query,1,1),
    '.',null,l.LOV_QUERY)
                                     list_of_values_query,
    (select count(*)
    from wwv_flow_list_of_values_data
    where flow_id = f.id and
          lov_id = l.id)             lov_entries,
    --
    decode(l.REFERENCE_ID,null,'No','Yes')
                                     is_subscribed,
    (select flow_id||'. '||name n
     from wwv_flow_lists_of_values$
     where id = l.reference_id)      subscribed_from,
    --
    l.LAST_UPDATED_BY                last_updated_by,
    l.LAST_UPDATED_ON                last_updated_on,
    l.LOV_COMMENT                    component_comment,
    --
    l.ID                             lov_id,
    l.REFERENCE_ID                   referenced_lov_id,
    --
    l.LOV_NAME
    ||' t='||decode(substr(l.lov_query,1,1),'.','Static','Dynamic')
    ||' q='||decode(substr(l.lov_query,1,1),'.',null,substr(l.LOV_QUERY,1,30)||length(l.LOV_QUERY))
    ||' ref='||decode(l.REFERENCE_ID,null,'No','Yes')
    component_signature
from wwv_flow_lists_of_values$ l,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = l.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_lovs IS 'Identifies a shared list of values that can be referenced by a Page Item or Report Column';
COMMENT ON COLUMN apex_application_lovs.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_lovs.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_lovs.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_lovs.list_of_values_name IS 'Identifies the name of the List of Values';
COMMENT ON COLUMN apex_application_lovs.lov_type IS 'List of Values type, Static or Dynamic.';
COMMENT ON COLUMN apex_application_lovs.list_of_values_query IS 'SQL SELECT statement used to identify dynamic Lists of Values.  Static Lists of Values are defined in a child List of Values Entries table.';
COMMENT ON COLUMN apex_application_lovs.lov_entries IS 'Count of List of Values static entries';
COMMENT ON COLUMN apex_application_lovs.is_subscribed IS 'Identifies if this List of Values is subscribed from another List of Values';
COMMENT ON COLUMN apex_application_lovs.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_lovs.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_lovs.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_lovs.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_lovs.lov_id IS 'Primary Key of the Shared List of Values';
COMMENT ON COLUMN apex_application_lovs.referenced_lov_id IS 'Foreign Key of referenced Shared List of Values';
COMMENT ON COLUMN apex_application_lovs.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';