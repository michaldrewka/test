CREATE OR REPLACE FORCE VIEW apex_application_web_services (workspace,application_id,application_name,web_service_name,url,"ACTION",proxy_override,soap_envelope,flow_items_comma_delimited,static_parm_01,static_parm_02,static_parm_03,static_parm_04,static_parm_05,static_parm_06,static_parm_07,static_parm_08,static_parm_09,static_parm_10,stylesheet,is_subscribed,subscribed_from,last_updated_by,last_updated_on,web_service_id) AS
select
    ws.short_name                          workspace,
    f.ID                                   application_id,
    f.NAME                                 application_name,
    --
    w.NAME                                 web_service_name,
    w.URL                                  ,
    w.ACTION                               ,
    w.PROXY_OVERRIDE                       ,
    w.SOAP_ENVELOPE                        ,
    w.FLOW_ITEMS_COMMA_DELIMITED           ,
    w.STATIC_PARM_01                       ,
    w.STATIC_PARM_02                       ,
    w.STATIC_PARM_03                       ,
    w.STATIC_PARM_04                       ,
    w.STATIC_PARM_05                       ,
    w.STATIC_PARM_06                       ,
    w.STATIC_PARM_07                       ,
    w.STATIC_PARM_08                       ,
    w.STATIC_PARM_09                       ,
    w.STATIC_PARM_10                       ,
    w.STYLESHEET                           ,
    --
    decode(w.REFERENCE_ID,
        null,'No','Yes')                   is_subscribed,
    (select flow_id||'. '||name n
     from wwv_flow_shared_web_services
     where id = w.id)                      subscribed_from,
    --
    w.LAST_UPDATED_BY                      last_updated_by,
    w.LAST_UPDATED_ON                      last_updated_on,
    --
    w.id                                   web_service_id
from wwv_flow_shared_web_services w,
     wwv_flows f,
     wwv_flow_companies ws,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = ws.PROVISIONING_COMPANY_ID and
      s.security_group_id = ws.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = w.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      ws.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or ws.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_web_services IS 'Web Services referenceable from this Application';
COMMENT ON COLUMN apex_application_web_services.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_web_services.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_web_services.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_web_services.web_service_name IS 'Identifies the name of the Web Service';
COMMENT ON COLUMN apex_application_web_services.url IS 'Specifies the URL used to post the SOAP request over HTTP';
COMMENT ON COLUMN apex_application_web_services."ACTION" IS 'Indicates the intent of the SOAP HTTP request';
COMMENT ON COLUMN apex_application_web_services.proxy_override IS 'Overrides the system defined HTTP proxy for request';
COMMENT ON COLUMN apex_application_web_services.soap_envelope IS 'Specifies the SOAP envelope to be used for the SOAP request to the Web service';
COMMENT ON COLUMN apex_application_web_services.flow_items_comma_delimited IS 'Comma delimited list of application items';
COMMENT ON COLUMN apex_application_web_services.static_parm_01 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_02 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_03 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_04 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_05 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_06 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_07 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_08 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_09 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.static_parm_10 IS 'Identifies static parameters';
COMMENT ON COLUMN apex_application_web_services.stylesheet IS 'Stylesheet will be used to apply an XML transformation against the result of the SOAP Request';
COMMENT ON COLUMN apex_application_web_services.is_subscribed IS 'Identifies if this Web Service is subscribed from another Web Service';
COMMENT ON COLUMN apex_application_web_services.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_web_services.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_web_services.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_web_services.web_service_id IS 'Identifies the primary key of the Web Service';