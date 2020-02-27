CREATE OR REPLACE FORCE VIEW apex_component_signatures (page_id,page_name,"COMPONENT",component_name,component_signature,application_1,application_2) AS
select page_id,
page_name,
component,
component_name,
component_signature,
sum(decode(application_id,x.a1,1,0)) application_1,
sum(decode(application_id,x.a2,1,0)) application_2
from
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x,
(
select 'PAGE' component,
page_id,
page_name,
lpad(page_id,5,'00000')||'. '||page_title component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGES,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE')
union all
select 'PAGE.VALIDATION' component,
page_id,
page_name,
VALIDATION_NAME component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGE_VAL,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE.VALIDATION')
union all
select 'PAGE.BRANCH' component,
page_id,
page_name,
substr(BRANCH_ACTION,1,40)||length(branch_action) component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGE_BRANCHES,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
 (nvl(x.c,'0')='0' or x.c='PAGE.BRANCH')
union all
select 'PAGE.COMPUTATION' component,
page_id,
page_name,
ITEM_NAME component_name,
component_signature,
application_id
from apex_application_page_comp,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE.COMPUTATION')
union all
select 'PAGE.PROCESS' component,
page_id,
page_name,
PROCESS_NAME component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGE_PROC,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE.PROCESS')
union all
select 'PAGE.REGION' component,
page_id,
page_name,
region_name component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGE_REGIONS,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE.REGION')
union all
select 'PAGE.ITEM' component,
page_id,
page_name,
item_name component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGE_ITEMS,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE.ITEM')
union all
select 'PAGE.BUTTON' component,
page_id,
page_name,
button_name component_name,
component_signature,
application_id
from APEX_APPLICATION_PAGE_BUTTONS,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PAGE.BUTTON')
union all
select 'AUTHENTICATION' component,
0 page_id,
null page_name,
'a' component_name,
component_signature,
application_id
from apex_application_auth,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='AUTHENTICATION')
union all
select 'LOV.ENTRY' component,
0 page_id,
null page_name,
LIST_OF_VALUES_NAME||'.'||substr(display_value,1,50) component_name,
component_signature,
application_id
from apex_application_lov_entries,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='LOV.ENTRY')
union all
select 'LOV' component,
0 page_id,
null page_name,
LIST_OF_VALUES_NAME component_name,
component_signature,
application_id
from APEX_APPLICATION_LOVS,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='LOV')
union all
select 'APPLICATION.PROCESS' component,
0 page_id,
null page_name,
process_name component_name,
component_signature,
application_id
from apex_application_processes,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='APPLICATION.PROCESS')
union all
select 'APPLICATION.COMPUTATION' component,
0 page_id,
null page_name,
computation_item component_name,
component_signature,
application_id
from apex_application_computations,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='APPLICATION.COMPUTATION')
union all
select 'NAVBAR' component,
0 page_id,
null page_name,
ICON_SUBTEXT component_name,
component_signature,
application_id
from APEX_APPLICATION_NAV_BAR,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='NAVBAR')
union all
select 'TAB' component,
t.tab_page page_id,
(select name from wwv_flow_steps where flow_id=t.application_id and id=t.tab_page) page_name,
tab_name component_name,
component_signature,
application_id
from apex_application_tabs t,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TAB')
union all
select 'PARENT.TAB' component,
0 page_id,
null page_name,
tab_name component_name,
component_signature,
application_id
from apex_application_parent_tabs t,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='PARENT.TAB')
union all
select 'BREADCRUMB' component,
0 page_id,
null page_name,
BREADCRUMB_NAME component_name,
component_signature,
application_id
from APEX_APPLICATION_BREADCRUMBS,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='BREADCRUMB')
union all
select 'LIST' component,
0 page_id,
null page_name,
LIST_NAME component_name,
component_signature,
application_id
from apex_application_lists,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='LIST')
union all
select 'LIST.ENTRY' component,
 0 page_id,
null page_name,
list_name||'.'||entry_text component_name,
component_signature,
application_id
from apex_application_list_entries,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='LIST.ENTRY')
union all
select 'TREE' component,
0 page_id,
null page_name,
tree_name component_name,
component_signature,
application_id
from apex_application_trees,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TREE')
union all
select 'SHORTCUT' component,
0 page_id,
null page_name,
shortcut_name component_name,
component_signature,
application_id
from apex_application_shortcuts,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='SHORTCUT')
union all
select 'APPLICATION.ITEM' component,
0 page_id,
null page_name,
ITEM_NAME component_name,
component_signature,
application_id
from apex_application_items,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='APPLICATION.ITEM')
union all
select 'BUILD.OPTION' component,
0 page_id,
null page_name,
build_option_name component_name,
component_signature,
application_id
from apex_application_build_options,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='BUILD.OPTION')
union all
select 'BREADCRUMB.ENTRY' component,
DEFINED_FOR_PAGE page_id,
(select name from wwv_flow_steps where id = DEFINED_FOR_PAGE and flow_id = application_id) page_name,
ENTRY_LABEL component_name,
component_signature,
application_id
from APEX_APPLICATION_BC_ENTRIES,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='BREADCRUMB.ENTRY')
union all
select 'APPLICATION.ATTRIBUTES' component,
0 page_id,
null page_name,
application_name component_name,
component_signature,
application_id
from APEX_APPLICATIONS,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='APPLICATION.ATTRIBUTES')
union all
select 'PAGE.REGION' component,
       page_id,
       (select name from wwv_flow_steps where id = v.page_id and flow_id = v.application_id) page_name,
       (select plug_name from wwv_flow_page_plugs where flow_id = v.application_id and id = v.region_id)||' - IR' component_name,
       component_signature,
       application_id
from   apex_application_page_ir v,
       (select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where  v.application_id in (x.a1,x.a2) and
       (nvl(x.c,'0')='0' or x.c='PAGE.REGION')
union all
select 'REPORT.COLUMN' component,
       page_id,
       (select name from wwv_flow_steps where id = v.page_id and flow_id = v.application_id) page_name,
       v.report_label component_name,
       component_signature,
       application_id
from   apex_application_page_ir_col v,
       (select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where  v.application_id in (x.a1,x.a2) and
       (nvl(x.c,'0')='0' or x.c='REPORT.COLUMN')
union all
select 'REPORT.COLUMN' component,
page_id,
page_name,
REGION_NAME||'.'||substr(column_alias,1,255) component_name,
component_signature,
application_id
from apex_application_page_rpt_cols,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='REPORT.COLUMN')
union all
select 'AUTHORIZATION' component,
0 page_id,
null page_name,
AUTHORIZATION_SCHEME_NAME component_name,
component_signature,
application_id
from apex_application_authorization,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='AUTHORIZATION')
union all
select 'THEME' component,
0 page_id,
null page_name,
theme_name component_name,
component_signature,
application_id
from apex_application_themes,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='THEME')
union all
select 'TEMPLATE.CALENDAR' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_calendar,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.CALENDAR')
union all
select 'TEMPLATE.BUTTON' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_button,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.BUTTON')
union all
select 'TEMPLATE.POPUP' component,
0 page_id,
null page_name,
'POPUP' component_name,
component_signature,
application_id
from apex_application_temp_popuplov,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.POPUP')
union all
select 'TEMPLATE.REPORT' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_report,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.REPORT')
union all
select 'TEMPLATE.BREADCRUMB' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_bc,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.BREADCRUMB')
union all
select 'TEMPLATE.LIST' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_list,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.LIST')
union all
select 'TEMPLATE.LABEL' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_label,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.LABEL')
union all
select 'TEMPLATE.REGION' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from APEX_APPLICATION_TEMP_REGION,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.REGION')
union all
select 'TEMPLATE.PAGE' component,
0 page_id,
null page_name,
template_name component_name,
component_signature,
application_id
from apex_application_temp_page,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='TEMPLATE.PAGE')
union all
select 'FLASH_CHART' component,
page_id,
page_name,
region_name||'.'||chart_type component_name,
component_signature,
application_id
from apex_application_page_flash_ch,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='FLASH_CHART')
union all
select 'FLASH_CHART.SERIES' component,
page_id,
page_name,
region_name||'.'||series_name component_name,
component_signature,
application_id
from apex_application_page_flash_s,
(select nv('APEX_APPLICATION_1') a1, nv('APEX_APPLICATION_2') a2, v('APEX_COMPONENT') c from dual) x
where application_id in (x.a1,x.a2) and
(nvl(x.c,'0')='0' or x.c='FLASH_CHART.SERIES')
) d
group by page_id, page_name, component, component_signature, component_name;
COMMENT ON TABLE apex_component_signatures IS 'Identifies two applications using APEX_APPLICATION_1 and APEX_APPLICATION_2 session date, APEX_COMPONENT must be 0 (all), or the name of an APEX component';
COMMENT ON COLUMN apex_component_signatures.page_id IS 'Identifies the page number for application components that are specific to a page';
COMMENT ON COLUMN apex_component_signatures.page_name IS 'Identifies the page name for application components that are specific to a page name';
COMMENT ON COLUMN apex_component_signatures."COMPONENT" IS 'Identifies the application component type';
COMMENT ON COLUMN apex_component_signatures.component_name IS 'Identifies the application component name';
COMMENT ON COLUMN apex_component_signatures.component_signature IS 'Identifies the signature of the components attributes';
COMMENT ON COLUMN apex_component_signatures.application_1 IS 'Returns 1 if the component exists in application 1, returns 0 if not';
COMMENT ON COLUMN apex_component_signatures.application_2 IS 'Returns 1 if the component exists in application 2, returns 0 if not';