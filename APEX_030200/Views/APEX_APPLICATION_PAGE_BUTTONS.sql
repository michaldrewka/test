CREATE OR REPLACE FORCE VIEW apex_application_page_buttons (workspace,application_id,application_name,page_id,page_name,button_sequence,region,region_id,button_name,button_template,image_name,"LABEL",display_position,alignment,redirect_url,condition_type,condition_expression1,condition_expression2,image_attributes,button_attributes,database_action,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,button_position,button_id,component_signature) AS
select
     w.short_name                  workspace,
     p.flow_id                     application_id,
     f.name                        application_name,
     p.id                          page_id,
     p.name                        page_name,
     --
     b.BUTTON_SEQUENCE             button_sequence,
     (select plug_name
      from wwv_flow_page_plugs
      where id=b.BUTTON_PLUG_ID)   region,
     b.button_plug_id              region_id,
     b.BUTTON_NAME                 button_name,
     (select template_name
      from wwv_flow_button_templates
      where b.BUTTON_IMAGE =
         'template:'||to_char(id)
      and flow_id = f.id)          button_template,
     decode(substr(b.BUTTON_IMAGE,1,9),'template:',null,b.BUTTON_IMAGE) image_name,
     b.BUTTON_IMAGE_ALT            label,
     b.BUTTON_POSITION             display_position,
     b.BUTTON_ALIGNMENT            alignment,
     b.BUTTON_REDIRECT_URL         redirect_url,
     --
     nvl((select r from apex_standard_conditions where d = b.BUTTON_CONDITION_TYPE),b.BUTTON_CONDITION_TYPE)
                                   condition_type,
     b.BUTTON_CONDITION            condition_expression1,
     b.BUTTON_CONDITION2           condition_expression2,
     b.BUTTON_IMAGE_ATTRIBUTES     image_attributes,
     b.BUTTON_CATTRIBUTES          button_attributes,
     decode(
        b.DATABASE_ACTION,
        'DELETE','SQL DELETE action',
        'INSERT','SQL INSERT action',
        'UPDATE','SQL UPDATE action',
        b.DATABASE_ACTION)         database_action,
     --
     (select case when b.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id= abs(b.REQUIRED_PATCH))   build_option,
     --
     decode(substr(b.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(b.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     b.SECURITY_SCHEME)            authorization_scheme,
     b.SECURITY_SCHEME             authorization_scheme_id,
     --
     b.LAST_UPDATED_BY             last_updated_by,
     b.LAST_UPDATED_ON             last_updated_on,
     b.BUTTON_COMMENT              component_comment,
     'Region Position'             button_position,
     b.id                          button_id,
     --
     b.BUTTON_NAME
     ||',s='||rpad(b.BUTTON_SEQUENCE,5,'00000')
     ||',r='||(select plug_name from wwv_flow_page_plugs where id=b.BUTTON_PLUG_ID)
     ||' t='||(select template_name from wwv_flow_button_templates where b.BUTTON_IMAGE = 'template:'||to_char(id) and flow_id = f.id)
     ||' label='||b.BUTTON_IMAGE_ALT
     ||' p='||b.BUTTON_POSITION
     ||' a='||b.BUTTON_ALIGNMENT
     ||' u='||substr(b.BUTTON_REDIRECT_URL,1,30)||length(b.BUTTON_REDIRECT_URL)
     ||' c='||b.BUTTON_CONDITION_TYPE
     ||substr(b.BUTTON_CONDITION,1,20)||length(b.BUTTON_CONDITION)||'.'
     ||substr(b.BUTTON_CONDITION2,1,20)||length(b.BUTTON_CONDITION2)
     ||' ii='||substr(b.BUTTON_IMAGE_ATTRIBUTES,1,20)||length(b.BUTTON_IMAGE_ATTRIBUTES)
     ||' ca='||substr(b.BUTTON_CATTRIBUTES,1,20)||length(b.BUTTON_CATTRIBUTES)
     ||' b='||decode(
        b.DATABASE_ACTION,
        'DELETE','SQLDELETE',
        'INSERT','SQLINSERT',
        'UPDATE','SQLUPDATE',
        b.DATABASE_ACTION)
     ||' b='||(select PATCH_NAME
     from wwv_flow_patches
     where id= abs(b.REQUIRED_PATCH))
     ||' s='||decode(substr(b.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(b.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     b.SECURITY_SCHEME)
     component_signature
from wwv_flow_step_buttons b,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.security_group_id = b.security_group_id and
      f.id = p.flow_id and
      f.id = b.flow_id and
      p.id = b.flow_step_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10)
union all
select
    w.short_name                    workspace,
    p.flow_id                       application_id,
    f.name                          application_name,
    p.id                            page_id,
    p.name                          page_name,
    --
    i.ITEM_SEQUENCE                 button_sequence,
    (select plug_name
     from wwv_flow_page_plugs
     where id = i.ITEM_PLUG_ID)     region,
    i.item_plug_id                  region_id,
    i.name                          button_name,
    --
    null                            button_template,
    decode(substr(i.BUTTON_IMAGE,1,9),'template:',null,i.BUTTON_IMAGE) image_name,
    i.PROMPT                        label,
    null                            display_position,
    null                            alignment,
    null                            redirect_url,
    --
    nvl((select r from apex_standard_conditions where d = i.DISPLAY_WHEN_TYPE),i.DISPLAY_WHEN_TYPE)
                                    condition_type,
    i.DISPLAY_WHEN                  condition_expression1,
    i.DISPLAY_WHEN2                 condition_expression2,
    --
    null                            image_attributes,
    null                            button_attributes,
    null                            database_action,
    (select case when i.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(i.REQUIRED_PATCH))   build_option,
    --
    decode(substr(i.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(i.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     i.SECURITY_SCHEME)             authorization_scheme,
    i.SECURITY_SCHEME               authorization_scheme_id,
    i.LAST_UPDATED_BY               last_updated_by,
    i.LAST_UPDATED_ON               last_updated_on,
    i.ITEM_COMMENT                  component_comment,
    'Among region items'            button_position,
    i.id                            button_id,
    --
    lpad(i.ITEM_SEQUENCE,5,'00000')
    ||' r='||(select plug_name
     from wwv_flow_page_plugs
     where id = i.ITEM_PLUG_ID)
    ||' n='||i.name
    ||' l='||substr(i.PROMPT,1,40)||length(i.PROMPT)
    ||' c='||i.DISPLAY_WHEN_TYPE
    ||'.'||substr(i.DISPLAY_WHEN,1,20)||length(i.DISPLAY_WHEN)
    ||'.'||substr(i.DISPLAY_WHEN2,1,20)||length(i.DISPLAY_WHEN2)
    ||' bo='||(select case when i.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(i.REQUIRED_PATCH))
    ||' sec='||decode(substr(i.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(i.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     i.SECURITY_SCHEME)
    ||' ItemButton'
    component_signature
from wwv_flow_step_items i,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.id = p.flow_id and
      f.id = i.flow_id and
      p.id = i.flow_step_id and
      nvl(i.display_as,'x') = 'BUTTON' and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_buttons IS 'Identifies buttons associated with a Page and Region';
COMMENT ON COLUMN apex_application_page_buttons.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_buttons.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_buttons.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_buttons.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_buttons.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_buttons.button_sequence IS 'Identifies the display sequence of the button within the region and display position';
COMMENT ON COLUMN apex_application_page_buttons.region IS 'Identifies the Page Region in which this Button is displayed';
COMMENT ON COLUMN apex_application_page_buttons.region_id IS 'Identifies the Page Region foreign key to the apex_application_page_regions view';
COMMENT ON COLUMN apex_application_page_buttons.button_name IS 'Identifies the name of the button, which when submitted becomes the REQUEST value';
COMMENT ON COLUMN apex_application_page_buttons.button_template IS 'Identifies the template used to display this button';
COMMENT ON COLUMN apex_application_page_buttons.image_name IS 'Name of image for non template based buttons';
COMMENT ON COLUMN apex_application_page_buttons."LABEL" IS 'Identifies the Button Label';
COMMENT ON COLUMN apex_application_page_buttons.display_position IS 'Identifies the Display Position with the Region';
COMMENT ON COLUMN apex_application_page_buttons.alignment IS 'Identifies the button alignment used for selected display positions';
COMMENT ON COLUMN apex_application_page_buttons.redirect_url IS 'Identifies an optional Page or URL to redirect to when this button is pressed.  If no Redirect URL is provided then the button will submit the page, a redirect will not submit the page.';
COMMENT ON COLUMN apex_application_page_buttons.condition_type IS 'Identifies the condition type used to conditionally display the Page Button';
COMMENT ON COLUMN apex_application_page_buttons.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_buttons.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_buttons.image_attributes IS 'Identifies the HTML IMG tag attributes for the image used to display the button';
COMMENT ON COLUMN apex_application_page_buttons.button_attributes IS 'Identifies the HTML INPUT tag attributes';
COMMENT ON COLUMN apex_application_page_buttons.database_action IS 'A button can be used to trigger table row processing (insert, update, and delete). This attribute determines the type of DML action to be performed.';
COMMENT ON COLUMN apex_application_page_buttons.build_option IS 'Button will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_page_buttons.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this button to be displayed';
COMMENT ON COLUMN apex_application_page_buttons.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_buttons.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_buttons.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_buttons.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_page_buttons.button_position IS 'Identifies where the button displays';
COMMENT ON COLUMN apex_application_page_buttons.button_id IS 'Primary key of this page button';
COMMENT ON COLUMN apex_application_page_buttons.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';