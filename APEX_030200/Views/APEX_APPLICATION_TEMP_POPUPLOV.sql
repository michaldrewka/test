CREATE OR REPLACE FORCE VIEW apex_application_temp_popuplov (workspace,application_id,application_name,popup_icon,popup_icon_attr,popup_icon2,popup_icon_attr2,page_title,page_html_head,page_body_attr,before_field_text,after_field_text,page_heading_text,page_footer_text,before_result_set,after_result_set,filter_width,filter_max_width,filter_text_attr,find_button_text,find_button_image,find_button_attr,close_button_text,close_button_image,close_button_attr,next_button_text,next_button_image,next_button_attr,prev_button_text,prev_button_image,prev_button_attr,scrollbars,resizable,width,height,result_row_x_of_y,result_rows_per_pg,when_no_data_found_message,before_first_fetch_message,minimum_characters_required,theme_number,theme_class,is_subscribed,subscribed_from,last_updated_on,last_updated_by,translatable,component_comment,template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.POPUP_ICON                     ,
    t.POPUP_ICON_ATTR                ,
    t.POPUP_ICON2                    ,
    t.POPUP_ICON_ATTR2               ,
    --t.PAGE_NAME                      ,
    t.PAGE_TITLE                     ,
    t.PAGE_HTML_HEAD                 ,
    t.PAGE_BODY_ATTR                 ,
    t.BEFORE_FIELD_TEXT              ,
    t.AFTER_FIELD_TEXT               ,
    t.PAGE_HEADING_TEXT              ,
    t.PAGE_FOOTER_TEXT               ,
    t.BEFORE_RESULT_SET              ,
    t.AFTER_RESULT_SET               ,
    t.FILTER_WIDTH                   ,
    t.FILTER_MAX_WIDTH               ,
    t.FILTER_TEXT_ATTR               ,
    t.FIND_BUTTON_TEXT               ,
    t.FIND_BUTTON_IMAGE              ,
    t.FIND_BUTTON_ATTR               ,
    t.CLOSE_BUTTON_TEXT              ,
    t.CLOSE_BUTTON_IMAGE             ,
    t.CLOSE_BUTTON_ATTR              ,
    t.NEXT_BUTTON_TEXT               ,
    t.NEXT_BUTTON_IMAGE              ,
    t.NEXT_BUTTON_ATTR               ,
    t.PREV_BUTTON_TEXT               ,
    t.PREV_BUTTON_IMAGE              ,
    t.PREV_BUTTON_ATTR               ,
    t.SCROLLBARS                     ,
    t.RESIZABLE                      ,
    t.WIDTH                          ,
    t.HEIGHT                         ,
    t.RESULT_ROW_X_OF_Y              ,
    t.RESULT_ROWS_PER_PG             ,
    t.WHEN_NO_DATA_FOUND_MESSAGE     ,
    t.BEFORE_FIRST_FETCH_MESSAGE     ,
    t.MINIMUM_CHARACTERS_REQUIRED    ,
    t.THEME_ID                       theme_number,
    --
    decode(t.THEME_CLASS_ID,
     '1','Standard',
     t.THEME_CLASS_ID)               theme_class,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_POPUP_LOV_TEMPLATE
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.LAST_UPDATED_ON                last_updated_on,
    t.LAST_UPDATED_BY                last_updated_by,
    decode(t.TRANSLATE_THIS_TEMPLATE,
      'N','No','Y','Yes','Yes')      translatable,
    t.TEMPLATE_COMMENT               component_comment,
    t.id                             template_id,
    --
    'pop'
    ||' ='||substr(POPUP_ICON                 ,1,20)||length(POPUP_ICON                 )
    ||' ='||substr(POPUP_ICON_ATTR            ,1,20)||length(POPUP_ICON_ATTR            )
    ||' ='||substr(POPUP_ICON2                ,1,20)||length(POPUP_ICON2                )
    ||' ='||substr(POPUP_ICON_ATTR2           ,1,20)||length(POPUP_ICON_ATTR2           )
    ||' ='||substr(PAGE_TITLE                 ,1,20)||length(PAGE_TITLE                 )
    ||' ='||substr(PAGE_HTML_HEAD             ,1,20)||length(PAGE_HTML_HEAD             )
    ||' ='||substr(PAGE_BODY_ATTR             ,1,20)||length(PAGE_BODY_ATTR             )
    ||' ='||substr(BEFORE_FIELD_TEXT          ,1,20)||length(BEFORE_FIELD_TEXT          )
    ||' ='||substr(AFTER_FIELD_TEXT           ,1,20)||length(AFTER_FIELD_TEXT           )
    ||' ='||substr(PAGE_HEADING_TEXT          ,1,20)||length(PAGE_HEADING_TEXT          )
    ||' ='||substr(PAGE_FOOTER_TEXT           ,1,20)||length(PAGE_FOOTER_TEXT           )
    ||' ='||substr(BEFORE_RESULT_SET          ,1,20)||length(BEFORE_RESULT_SET          )
    ||' ='||substr(AFTER_RESULT_SET           ,1,20)||length(AFTER_RESULT_SET           )
    ||' ='||substr(FILTER_WIDTH               ,1,20)||length(FILTER_WIDTH               )
    ||' ='||substr(FILTER_MAX_WIDTH           ,1,20)||length(FILTER_MAX_WIDTH           )
    ||' ='||substr(FILTER_TEXT_ATTR           ,1,20)||length(FILTER_TEXT_ATTR           )
    ||' ='||substr(FIND_BUTTON_TEXT           ,1,20)||length(FIND_BUTTON_TEXT           )
    ||' ='||substr(FIND_BUTTON_IMAGE          ,1,20)||length(FIND_BUTTON_IMAGE          )
    ||' ='||substr(FIND_BUTTON_ATTR           ,1,20)||length(FIND_BUTTON_ATTR           )
    ||' ='||substr(CLOSE_BUTTON_TEXT          ,1,20)||length(CLOSE_BUTTON_TEXT          )
    ||' ='||substr(CLOSE_BUTTON_IMAGE         ,1,20)||length(CLOSE_BUTTON_IMAGE         )
    ||' ='||substr(CLOSE_BUTTON_ATTR          ,1,20)||length(CLOSE_BUTTON_ATTR          )
    ||' ='||substr(NEXT_BUTTON_TEXT           ,1,20)||length(NEXT_BUTTON_TEXT           )
    ||' ='||substr(NEXT_BUTTON_IMAGE          ,1,20)||length(NEXT_BUTTON_IMAGE          )
    ||' ='||substr(NEXT_BUTTON_ATTR           ,1,20)||length(NEXT_BUTTON_ATTR           )
    ||' ='||substr(PREV_BUTTON_TEXT           ,1,20)||length(PREV_BUTTON_TEXT           )
    ||' ='||substr(PREV_BUTTON_IMAGE          ,1,20)||length(PREV_BUTTON_IMAGE          )
    ||' ='||substr(PREV_BUTTON_ATTR           ,1,20)||length(PREV_BUTTON_ATTR           )
    ||' ='||substr(SCROLLBARS                 ,1,20)||length(SCROLLBARS                 )
    ||' ='||substr(RESIZABLE                  ,1,20)||length(RESIZABLE                  )
    ||' ='||substr(WIDTH                      ,1,20)||length(WIDTH                      )
    ||' ='||substr(HEIGHT                     ,1,20)||length(HEIGHT                     )
    ||' ='||substr(RESULT_ROW_X_OF_Y          ,1,20)||length(RESULT_ROW_X_OF_Y          )
    ||' ='||RESULT_ROWS_PER_PG
    ||' ='||substr(WHEN_NO_DATA_FOUND_MESSAGE ,1,20)||length(WHEN_NO_DATA_FOUND_MESSAGE )
    ||' ='||substr(BEFORE_FIRST_FETCH_MESSAGE ,1,20)||length(BEFORE_FIRST_FETCH_MESSAGE )
    ||' ='||substr(MINIMUM_CHARACTERS_REQUIRED,1,20)||length(MINIMUM_CHARACTERS_REQUIRED)
    ||' r='||decode(t.REFERENCE_ID,null,'N','Y')
    component_signature
from WWV_FLOW_POPUP_LOV_TEMPLATE t,
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
COMMENT ON TABLE apex_application_temp_popuplov IS 'Identifies the HTML template markup and some functionality of all Popup List of Values controls for this application';
COMMENT ON COLUMN apex_application_temp_popuplov.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_popuplov.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_popuplov.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_popuplov.popup_icon IS 'Name of the image used for all Popup List of Values Icons within this application';
COMMENT ON COLUMN apex_application_temp_popuplov.popup_icon_attr IS 'HTML IMG attributes used to render the Popup List of Values Image';
COMMENT ON COLUMN apex_application_temp_popuplov.popup_icon2 IS 'Name of the image used for Color Picker Popup List of Values Icon within this application';
COMMENT ON COLUMN apex_application_temp_popuplov.popup_icon_attr2 IS 'HTML IMG attributes used to render the Color Picker Popup List of Values Image';
COMMENT ON COLUMN apex_application_temp_popuplov.page_title IS 'Page title of the popup list of values page';
COMMENT ON COLUMN apex_application_temp_popuplov.page_html_head IS 'HTML Page Heading';
COMMENT ON COLUMN apex_application_temp_popuplov.page_body_attr IS 'Defines text that is added into the popup list of values HTML BODY';
COMMENT ON COLUMN apex_application_temp_popuplov.before_field_text IS 'Defines text to display before the popup list of values search field displays';
COMMENT ON COLUMN apex_application_temp_popuplov.after_field_text IS 'Defines text to display after displaying the search field, the search button, and the close button';
COMMENT ON COLUMN apex_application_temp_popuplov.page_heading_text IS 'Defines text to display after opening the form, but before displaying any text';
COMMENT ON COLUMN apex_application_temp_popuplov.page_footer_text IS 'Defines text to display after displaying the popup page including the search list results';
COMMENT ON COLUMN apex_application_temp_popuplov.before_result_set IS 'Display this text before displaying the result set. The result set is the result of the list of values query';
COMMENT ON COLUMN apex_application_temp_popuplov.after_result_set IS 'Display this text after displaying the result set. The result set is the result of the list of values query';
COMMENT ON COLUMN apex_application_temp_popuplov.filter_width IS 'Display the HTML INPUT TYPE = TEXT widget using this width';
COMMENT ON COLUMN apex_application_temp_popuplov.filter_max_width IS 'Display the HTML INPUT TYPE = TEXT widget using this maximum width';
COMMENT ON COLUMN apex_application_temp_popuplov.filter_text_attr IS 'Display the HTML INPUT TYPE = TEXT widget using these attributes';
COMMENT ON COLUMN apex_application_temp_popuplov.find_button_text IS 'Defines text that displays on the name of the button used to search on the popup page';
COMMENT ON COLUMN apex_application_temp_popuplov.find_button_image IS 'Defines button image of the button used to search on the popup page';
COMMENT ON COLUMN apex_application_temp_popuplov.find_button_attr IS 'Defines additional attributes for the Find button';
COMMENT ON COLUMN apex_application_temp_popuplov.close_button_text IS 'Defines the name of the close button. The close button dismisses the popup list of values page';
COMMENT ON COLUMN apex_application_temp_popuplov.close_button_image IS 'Defines close button image. The close button dismisses the popup list of values page';
COMMENT ON COLUMN apex_application_temp_popuplov.close_button_attr IS 'Defines additional attributes of the Close button';
COMMENT ON COLUMN apex_application_temp_popuplov.next_button_text IS 'Defines the name of the Next button used when paginating result sets';
COMMENT ON COLUMN apex_application_temp_popuplov.next_button_image IS 'Defines the button image of the Next button used when paginating result sets';
COMMENT ON COLUMN apex_application_temp_popuplov.next_button_attr IS 'Defines additional attributes for the Next button';
COMMENT ON COLUMN apex_application_temp_popuplov.prev_button_text IS 'Defines the name of Previous page button. This button is used to paginate result sets';
COMMENT ON COLUMN apex_application_temp_popuplov.prev_button_image IS 'Defines the button image of Previous page button. This button is used to paginate result sets.';
COMMENT ON COLUMN apex_application_temp_popuplov.prev_button_attr IS 'Defines additional attributes of the Previous button';
COMMENT ON COLUMN apex_application_temp_popuplov.scrollbars IS 'Popup lists of values are executed using JavaScript. Use this attribute to control the values of scrollbars';
COMMENT ON COLUMN apex_application_temp_popuplov.resizable IS 'Popup lists of values are executed using JavaScript. Use this attribute to control the value of resizable';
COMMENT ON COLUMN apex_application_temp_popuplov.width IS 'Popup lists of values are executed using JavaScript. Use this attribute to control the values of width';
COMMENT ON COLUMN apex_application_temp_popuplov.height IS 'Popup lists of values are executed using JavaScript. Use this attribute to control the values of height';
COMMENT ON COLUMN apex_application_temp_popuplov.result_row_x_of_y IS 'Defines how row count results display';
COMMENT ON COLUMN apex_application_temp_popuplov.result_rows_per_pg IS 'Defines the number of rows per page';
COMMENT ON COLUMN apex_application_temp_popuplov.theme_number IS 'Identifies the templates corresponding theme';
COMMENT ON COLUMN apex_application_temp_popuplov.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_popuplov.is_subscribed IS 'Identifies if this Popup List of Values Template is subscribed from another Popup List of Values Template';
COMMENT ON COLUMN apex_application_temp_popuplov.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_popuplov.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_popuplov.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_popuplov.translatable IS 'Identifies if this component is to be identified as translatable (yes or no)';
COMMENT ON COLUMN apex_application_temp_popuplov.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_popuplov.template_id IS 'Primary Key of this Popup List of Values Template';
COMMENT ON COLUMN apex_application_temp_popuplov.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';