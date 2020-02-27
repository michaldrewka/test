CREATE OR REPLACE FORCE VIEW apex_application_trees (workspace,application_id,application_name,tree_name,tree_type,tree_query,flow_item,maximum_levels,unexpanded_parent,unexpanded_parent_last,expanded_parent,expanded_parent_last,leaf_node,leaf_node_last,drill_up,name_link_anchor_tag,name_link_not_anchor_tag,indent_vertical_line,indent_vertical_line_last,before_tree,after_tree,level_1_template,level_2_template,level_3_template,level_4_template,level_5_template,level_6_template,level_7_template,level_8_template,last_updated_by,last_updated_on,component_comment,application_tree_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.TREE_NAME                      tree_name,
    t.TREE_TYPE                      tree_type,
    t.TREE_QUERY                     tree_query,
    t.FLOW_ITEM                      ,
    t.MAX_LEVELS                     maximum_levels,
    t.UNEXPANDED_PARENT              ,
    t.UNEXPANDED_PARENT_LAST         ,
    t.EXPANDED_PARENT                ,
    t.EXPANDED_PARENT_LAST           ,
    t.LEAF_NODE                      ,
    t.LEAF_NODE_LAST                 ,
    t.DRILL_UP                       ,
    t.NAME_LINK_ANCHOR_TAG           ,
    t.NAME_LINK_NOT_ANCHOR_TAG       ,
    t.INDENT_VERTICAL_LINE           ,
    t.INDENT_VERTICAL_LINE_LAST      ,
    t.BEFORE_TREE                    ,
    t.AFTER_TREE                     ,
    t.LEVEL_1_TEMPLATE               ,
    t.LEVEL_2_TEMPLATE               ,
    t.LEVEL_3_TEMPLATE               ,
    t.LEVEL_4_TEMPLATE               ,
    t.LEVEL_5_TEMPLATE               ,
    t.LEVEL_6_TEMPLATE               ,
    t.LEVEL_7_TEMPLATE               ,
    t.LEVEL_8_TEMPLATE               ,
    --
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    --
    t.TREE_COMMENT                   component_comment,
    t.id                             application_tree_id,
    --
    t.TREE_NAME
    ||' t='||t.TREE_TYPE
    ||substr(t.TREE_QUERY,1,50)||length(t.tree_query)
    ||' i='||t.FLOW_ITEM
    ||' l='||t.MAX_LEVELS
    ||'.'||length(t.UNEXPANDED_PARENT        )
    ||'.'||length(t.UNEXPANDED_PARENT_LAST   )
    ||'.'||length(t.EXPANDED_PARENT          )
    ||'.'||length(t.EXPANDED_PARENT_LAST     )
    ||'.'||length(t.LEAF_NODE                )
    ||'.'||length(t.LEAF_NODE_LAST           )
    ||'.'||length(t.DRILL_UP                 )
    ||'.'||length(t.NAME_LINK_ANCHOR_TAG     )
    ||'.'||length(t.NAME_LINK_NOT_ANCHOR_TAG )
    ||'.'||length(t.INDENT_VERTICAL_LINE     )
    ||'.'||length(t.INDENT_VERTICAL_LINE_LAST)
    ||'.'||length(t.BEFORE_TREE              )
    ||'.'||length(t.AFTER_TREE               )
    ||'.'||length(t.LEVEL_1_TEMPLATE         )
    ||'.'||length(t.LEVEL_2_TEMPLATE         )
    ||'.'||length(t.LEVEL_3_TEMPLATE         )
    ||'.'||length(t.LEVEL_4_TEMPLATE         )
    ||'.'||length(t.LEVEL_5_TEMPLATE         )
    ||'.'||length(t.LEVEL_6_TEMPLATE         )
    ||'.'||length(t.LEVEL_7_TEMPLATE         )
    ||'.'||length(t.LEVEL_8_TEMPLATE         )
    component_signature
from wwv_flow_trees t,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = t.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_trees IS 'Identifies a tree control which can be referenced and displayed by creating a region with a source of this tree';
COMMENT ON COLUMN apex_application_trees.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_trees.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_trees.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_trees.tree_name IS 'Component name';
COMMENT ON COLUMN apex_application_trees.tree_type IS 'Tree component type';
COMMENT ON COLUMN apex_application_trees.tree_query IS 'Query which will be used to generate this tree';
COMMENT ON COLUMN apex_application_trees.flow_item IS 'Identifies an application or page item which specifies the starting point of the tree';
COMMENT ON COLUMN apex_application_trees.maximum_levels IS 'This attribute specifies how many levels will appear when a tree first displays';
COMMENT ON COLUMN apex_application_trees.unexpanded_parent IS 'HTML template for unexpanded parent nodes';
COMMENT ON COLUMN apex_application_trees.unexpanded_parent_last IS 'HTML template for the last unexpanded parent node';
COMMENT ON COLUMN apex_application_trees.expanded_parent IS 'HTML template for the expanded parent node';
COMMENT ON COLUMN apex_application_trees.expanded_parent_last IS 'HTML template for the last expanded parent node';
COMMENT ON COLUMN apex_application_trees.leaf_node IS 'Controls the text that is painted before showing the text of the leaf node';
COMMENT ON COLUMN apex_application_trees.leaf_node_last IS 'Controls the text that is painted before showing the text of the last leaf node.';
COMMENT ON COLUMN apex_application_trees.drill_up IS 'Identifies the link text shown when drilling up is possible in the tree';
COMMENT ON COLUMN apex_application_trees.name_link_anchor_tag IS 'Identifies the manner in which a Name will render if the name has a link';
COMMENT ON COLUMN apex_application_trees.name_link_not_anchor_tag IS 'Tag for node names which are not links';
COMMENT ON COLUMN apex_application_trees.indent_vertical_line IS 'Controls vertical line or spacing between peers';
COMMENT ON COLUMN apex_application_trees.indent_vertical_line_last IS 'Indent Vertical Line Last, controls a blank space';
COMMENT ON COLUMN apex_application_trees.before_tree IS 'Text before displaying any nodes of the tree';
COMMENT ON COLUMN apex_application_trees.after_tree IS 'Text after displaying nodes of the tree';
COMMENT ON COLUMN apex_application_trees.level_1_template IS 'Parent Node Template';
COMMENT ON COLUMN apex_application_trees.level_2_template IS 'Node Text Template';
COMMENT ON COLUMN apex_application_trees.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_trees.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_trees.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_trees.application_tree_id IS 'Primary Key of this Application Tree shared component';
COMMENT ON COLUMN apex_application_trees.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';