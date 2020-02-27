CREATE OR REPLACE FORCE VIEW apex_application_caching (workspace,application_id,application_name,page_id,page_name,cache_type,language,caching_user,cache_size,region_name,cached_on,cached_for_seconds,age_in_seconds,timeout_in_seconds,region_id,workspace_id) AS
select
    w.short_name                                        workspace,
    f.ID                                                application_id,
    f.NAME                                              application_name,
    decode(c.region_id,null,c.PAGE_ID,
    (select page_id from wwv_flow_page_plugs
     where id = c.region_id and flow_id = c.flow_id))   page_id,
    (select name
     from wwv_flow_steps
     where id in
     decode(c.region_id,null,c.PAGE_ID,
    (select page_id from wwv_flow_page_plugs
     where id = c.region_id and flow_id = c.flow_id))
      and  flow_id = f.id)                              page_name,
    decode(decode(chart_region_id,null,
    'X','Chart Region Cache'),'X',
    decode(region_id,null,'Page Cache','Region Cache')) cache_type,
    c.LANGUAGE                                          language,
    c.USER_NAME                                         caching_user,
    dbms_lob.getlength(c.PAGE_TEXT)                     cache_size,
    decode(region_id,null,null,
    (select plug_name
     from wwv_flow_page_plugs
     where id = c.region_id and flow_id = f.id))        region_name,
    c.CACHED_ON                                         cached_on,
    decode(region_id,null,
    (select cache_timeout_seconds
     from wwv_flow_steps
     where flow_id = f.id and id = c.page_id),
    (select PLUG_CACHING_MAX_AGE_IN_SEC
     from wwv_flow_page_plugs
     where id = c.region_id))                           cached_for_seconds,
    --
    round((sysdate - c.cached_on) * 3600 * 24,0)        age_in_seconds,
    --
    decode(region_id,null,
    (select cache_timeout_seconds -
             round((sysdate - c.cached_on)
             * 3600 * 24,0) a
     from wwv_flow_steps
     where flow_id = f.id and id = c.page_id),
    (select PLUG_CACHING_MAX_AGE_IN_SEC -
            round((sysdate - c.cached_on)
            * 3600 * 24,0) a
     from wwv_flow_page_plugs
     where id = c.region_id))                           timeout_in_seconds,
    c.REGION_ID                                         region_id,
    c.SECURITY_GROUP_ID                                 workspace_id
from
     wwv_flow_page_cache c,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      c.flow_id = f.id and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_caching IS 'Applications defined in the current workspace or database user.';
COMMENT ON COLUMN apex_application_caching.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_caching.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_caching.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_caching.page_id IS 'Identifies page number';
COMMENT ON COLUMN apex_application_caching.page_name IS 'Identifies page name';
COMMENT ON COLUMN apex_application_caching.cache_type IS 'Cache type, Page, Region, or Chart Region';
COMMENT ON COLUMN apex_application_caching.language IS 'Language of Cache';
COMMENT ON COLUMN apex_application_caching.caching_user IS 'User who caused the page or region to be cached';
COMMENT ON COLUMN apex_application_caching.cache_size IS 'Size of the cache, sum this column to see full cache size';
COMMENT ON COLUMN apex_application_caching.region_name IS 'Identifies region name, null for page caches';
COMMENT ON COLUMN apex_application_caching.cached_on IS 'Date cache was created';
COMMENT ON COLUMN apex_application_caching.cached_for_seconds IS 'Iimeout in seconds identified in page or region caching meta data';
COMMENT ON COLUMN apex_application_caching.age_in_seconds IS 'Seconds elapsed since cache was created';
COMMENT ON COLUMN apex_application_caching.timeout_in_seconds IS 'Seconds until cache will expire.  Negitive values indicate an expired cache';
COMMENT ON COLUMN apex_application_caching.region_id IS 'Corresponding primary key of region';
COMMENT ON COLUMN apex_application_caching.workspace_id IS 'Corresponding primary key of workspace';