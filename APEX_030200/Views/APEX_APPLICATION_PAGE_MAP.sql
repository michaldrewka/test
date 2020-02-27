CREATE OR REPLACE FORCE VIEW apex_application_page_map (workspace,application_id,application_name,page_id,page_name,page_title,breadcrumb,full_breadcrumb,help_text) AS
select w.short_name                 workspace,
       p.flow_id                    application_id,
       (select name
        from wwv_flows
        where id = p.flow_id)       application_name,
       p.id                         page_id,
       p.name                       page_name,
       p.step_title                 page_title,
       --
       breadcrumb                   breadcrumb,
       ltrim((select max(short_name)
       from wwv_flow_menu_options b2
       where c.ggggg_parent_id = b2.id) ||
       ggggg_parent||' > '||
       gggg_parent||' > '||
       ggg_parent||' > '||
       great_grand_parent||' > '||
       grand_parent||' > '||
       parent_breadcrumb||' > '||
       breadcrumb,' >')             full_breadcrumb,
       help_text
from wwv_flow_steps p,
     wwv_flow_companies w,
(
select flow_id, page_id, breadcrumb_id, breadcrumb, parent_breadcrumb, grand_parent,
       great_grand_parent, ggg_parent,gggg_parent,
       (select max(short_name) from wwv_flow_menu_options b2
       where b.gggg_parent_id = b2.id and b.flow_id = b2.flow_id) ggggg_parent,
       (select max(parent_id) from wwv_flow_menu_options b2
       where b.gggg_parent_id = b2.id and b.flow_id = b2.flow_id) ggggg_parent_id
from
(
select flow_id, page_id, breadcrumb_id, breadcrumb, parent_breadcrumb, grand_parent,
       great_grand_parent, ggg_parent,
       (select max(short_name) from wwv_flow_menu_options b2
       where a.ggg_parent_id = b2.id and a.flow_id = b2.flow_id) gggg_parent,
       (select max(parent_id) from wwv_flow_menu_options b2
       where a.ggg_parent_id = b2.id and a.flow_id = b2.flow_id) gggg_parent_id
from
(
select flow_id, page_id, breadcrumb_id, breadcrumb, parent_breadcrumb, grand_parent,
       great_grand_parent,
       (select max(short_name) from wwv_flow_menu_options b2
       where z.great_grand_parent_id = b2.id and z.flow_id = b2.flow_id) ggg_parent,
       (select max(parent_id) from wwv_flow_menu_options b2
       where z.great_grand_parent_id = b2.id and z.flow_id = b2.flow_id) ggg_parent_id
from
(
select flow_id, page_id, breadcrumb_id, breadcrumb, parent_breadcrumb, grand_parent,
       (select max(short_name) from wwv_flow_menu_options b2
       where y.grand_parent_id = b2.id and y.flow_id = b2.flow_id) great_grand_parent,
       (select max(parent_id) from wwv_flow_menu_options b2
       where y.grand_parent_id = b2.id and y.flow_id = b2.flow_id) great_grand_parent_id
from
(
select flow_id, page_id, breadcrumb_id, breadcrumb, parent_breadcrumb,
       (select max(short_name) from wwv_flow_menu_options b2
       where x.parent_id = b2.id) grand_parent,
       (select max(parent_id) from wwv_flow_menu_options b2
       where x.parent_id = b2.id and x.flow_id = b2.flow_id) grand_parent_id
from
(
select flow_id, b.id breadcrumb_id, page_id, short_name breadcrumb,
       (select max(short_name) from wwv_flow_menu_options b2
       where b.parent_id = b2.id and b.flow_id = b2.flow_id) parent_breadcrumb,
       (select max(parent_id) from wwv_flow_menu_options b2
       where b.parent_id = b2.id and b.flow_id = b2.flow_id) parent_id
from wwv_flow_menu_options b
) x
) y
) z
) a
) b
) c
where p.id = c.page_id(+)
and  p.flow_id = c.flow_id
and  w.provisioning_company_id = p.flow_id
and (user = (select owner from wwv_flows where id = p.flow_id) or
     p.security_group_id = (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual));
COMMENT ON TABLE apex_application_page_map IS 'Identifies the full breadcrumb path for each page with a breadcrumb entry';
COMMENT ON COLUMN apex_application_page_map.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_map.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_map.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_map.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_map.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_map.page_title IS 'Identifies the Page Title';
COMMENT ON COLUMN apex_application_page_map.breadcrumb IS 'Identifies the corresponding Page Breadcrumb Entry Text';
COMMENT ON COLUMN apex_application_page_map.full_breadcrumb IS 'Identifies the full breadcrumb hierarchy';
COMMENT ON COLUMN apex_application_page_map.help_text IS 'Identifies the help text associated with the page';