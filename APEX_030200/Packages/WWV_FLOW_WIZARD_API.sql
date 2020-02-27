CREATE OR REPLACE package wwv_flow_wizard_api
as

empty_vc_arr wwv_flow_global.vc_arr2;

function flash_chart_region_source (
       p_page_id    in number,
       p_chart_type in varchar2 default null
       ) return varchar2;

function array_element(
       p_vcarr in wwv_flow_global.vc_arr2,
       p_index in number )
       return varchar2;

function get_pk (
       p_table_owner  in varchar2,
       p_table_name   in varchar2
       ) return varchar2;

function get_column_data_type (
      p_table_owner in varchar2,
      p_table_name  in varchar2,
      p_column_name in varchar2
      ) return varchar2;

function table_view_exists (
      p_name in varchar2,
      p_owner in varchar2
      ) return boolean;

function updateable_query_exists (
      p_flow_id in number,
      p_page_id in number)
   return boolean;

function ir_report_exists (
      p_flow_id in number,
      p_page_id in number)
   return boolean;

function page_exists (p_flow_id in number, p_page_id in number) return boolean;

function get_owner (
   -- If the owner user chose is equal to flows' owner,
   -- return #OWNER#.
   --
      p_flow_id    in number,
      p_owner      in varchar2 )
   return varchar2;

function get_flow_owner (
   -- Get the owner of current flow.
   --
       p_flow_id   in number)
   return varchar2;

function shortcut_exist(
   --
   -- check whether TEXT_ESCAPE_JS shortcut type exists or not
   --
   p_flow_id in number,
   p_shortcut_name in varchar2)
   return boolean;

-- -----------------------------------------------------------------------------------
-- get valid item name
-- p_column_name
-- returns valid item name for given column name

function get_valid_item_name (
    p_column_name varchar2,
    p_page_id     number default null
) return varchar2;

-- -----------------------------------------------------------------------------------
-- get query columns
-- p_owner: parse-as schema name
-- p_query: sql query

procedure get_query_columns (
      p_owner        in varchar2,
      p_query        in varchar2,
      p_include_blob in varchar2 default 'N',
      p_columns      out wwv_flow_global.vc_arr2,
      p_types        out wwv_flow_global.vc_arr2,
      p_col_max_len  out wwv_flow_global.vc_arr2
);

 procedure get_varchar_query_columns (
      p_owner         in varchar2,
     p_query          in varchar2,
      p_columns     out wwv_flow_global.vc_arr2
  );

 function is_old_ppr_template (
    p_flow_id            in number,
	p_report_template_id in number
 ) return boolean;

procedure create_updateable_report (
   p_flow_id            in number,
   p_page_id            in number,
   p_page_name          in varchar2,
   p_use_ui_default     in varchar2 default 'Y',
   --
   p_tabset             in varchar2 default null,
   p_tab_name           in varchar2 default null, -- current tab name
   p_tab_text           in varchar2 default null,
   p_select_columns     in varchar2 default null,
   p_updatable_columns  in varchar2 default null,
   p_table_pk1          in varchar2 default null,
   p_table_pk1_src_type in varchar2 default null,
   p_table_pk1_src      in varchar2 default null,
   p_table_pk2          in varchar2 default null,
   p_table_pk2_src_type in varchar2 default null,
   p_table_pk2_src      in varchar2 default null,
   p_table_pk3          in varchar2 default null,
   p_table_pk3_src_type in varchar2 default null,
   p_table_pk3_src      in varchar2 default null,
   p_table_fk           in varchar2 default null,
   p_table_fk_src_type  in varchar2 default null,
   p_table_fk_src       in varchar2 default null,
   p_implement_type     in number   default null,
   p_security_group_id  in number   default null,
   --
   p_query              in varchar2,
   p_region_title       in varchar2,
   p_region_template    in number,
   p_report_template    in number,
   p_cancel_branch      in number,
   p_submit_branch      in number,
   p_process            in varchar2,
   p_cancel_button_name in varchar2 default null,
   p_delete_button_name in varchar2 default null,
   p_add_button_name    in varchar2 default null,
   p_submit_button_name in varchar2 default null)
   ;

procedure create_form_on_sp (
   p_flow_id            in number,
   p_page_id            in number,
   p_page_name          in varchar2,
   p_tab_set            in varchar2 default null,
   p_tab_name           in varchar2 default null, -- current tab name
   p_tab_text           in varchar2 default null,
   p_region_title       in varchar2 default null,
   p_region_template    in number,
   p_schema             in varchar2,
   p_procedure          in varchar2,
   p_collection_name    in varchar2 default 'SP_WIZARD',
   p_cancel_branch      in number,
   p_submit_branch      in number,
   p_cancel_button_name in varchar2 default 'Cancel',
   p_submit_button_name in varchar2 default 'Submit',
   --
   p_button_label       in varchar2 default 'RUN',
   p_invoking_page_id   in varchar2 default null,
   p_invoking_region_id in varchar2 default null,
   p_invoking_button_p  in varchar2 default null)
   ;

procedure create_form_on_table (
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_page_name               in varchar2 default 'form',
    p_use_ui_default          in varchar2 default 'Y',
    --
    p_tab_set                 in varchar2 default null,
    p_tab_name                in varchar2 default null, -- current tab name
    p_tab_text                in varchar2 default null,
    --
    p_region_title            in varchar2 default null,
    p_region_template         in number default null,
    p_table_owner             in varchar2 default null,
    p_table_name              in varchar2 default null,
    p_table_pk_column_name    in varchar2 default null,
    p_table_pk_src_type       in varchar2 default null,
    p_table_pk_src            in varchar2 default null,
    p_table_pk2_column_name   in varchar2 default null,
    p_table_pk2_src_type       in varchar2 default null,
    p_table_pk2_src            in varchar2 default null,
    p_display_column_list     in varchar2 default null,
    --
    p_create_button_name      in varchar2 default 'Create',
    p_save_button_name        in varchar2 default 'Apply Changes',
    p_delete_button_name      in varchar2 default 'Delete',
    p_cancel_button_name      in varchar2 default 'Cancel',
    p_branch                  in number default null,
    p_cancel_branch           in number default null,
    --
    p_insert                  in varchar2 default 'Y',
    p_update                  in varchar2 default 'Y',
    p_delete                  in varchar2 default 'Y'
    );

procedure create_form_on_ws (
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_ws_id                   in number,
    p_operation_id            in number,
    p_page_name               in varchar2 default 'form',
    --
    p_tab_set                 in varchar2 default null,
    p_tab_name                in varchar2 default null, -- current tab name
    p_tab_text                in varchar2 default null,
    --
    p_region_title            in varchar2 default null,
    p_region_template         in number default null,
    p_inputs_collection       in varchar2,
    p_outputs_collection      in varchar2,
    p_auth_collection         in varchar2
    );

procedure create_form_on_ws_rpt (
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_ws_id                   in number,
    p_operation_id            in number,
    p_page_name               in varchar2 default 'form',
    --
    p_tab_set                 in varchar2 default null,
    p_tab_name                in varchar2 default null, -- current tab name
    p_tab_text                in varchar2 default null,
    --
    p_region_title            in varchar2 default null,
    p_region_template         in number default null,
    p_region_title2           in varchar2 default null,
    p_region_template2        in number default null,
    p_report_template         in varchar2,
    p_inputs_collection       in varchar2,
    p_auth_collection         in varchar2,
    p_array_parm              in number,
    p_report_collection_name  in varchar2,
    p_array_parms_collection  in varchar2
    );


procedure create_query_and_update_page (
    p_flow_id                 in number   default null,
    p_form_page_id            in number   default null,
    p_report_page_id          in varchar2 default null,
    p_form_page_name          in varchar2 default 'form',
    p_report_page_name        in varchar2 default 'report',
    p_use_ui_default          in varchar2 default 'Y',
    --
    p_tab_set                 in varchar2 default null,
    p_tab_name                in varchar2 default null, -- current tab name
    p_tab_text                in varchar2 default null,
    --
    p_report_type             in varchar2 default null,
    --
    p_table_owner             in varchar2 default null,
    p_table_name              in varchar2 default null,
    p_table_pk_column_name    in varchar2 default null,
    p_table_pk_src_type       in varchar2 default null,
    p_table_pk_src            in varchar2 default null,
    p_table_pk2_column_name   in varchar2 default null,
    p_table_pk2_src_type       in varchar2 default null,
    p_table_pk2_src            in varchar2 default null,
    --
    p_display_column_list     in varchar2 default null,
    p_report_select_list      in varchar2 default null,
    --
    p_rpt_region_template     in number default null,
    p_rpt_template            in number default null,
    p_rpt_region_name         in varchar2 default null,
    p_form_region_template    in number default null,
    p_form_region_name         in varchar2 default null,
    --
    p_where_clause            in varchar2 default null,
    p_pagination_size         in varchar2 default '10',
    p_edit_link               in varchar2 default 'Edit',
    --
    p_form_insert             in varchar2 default 'Y',
    p_form_update             in varchar2 default 'Y',
    p_form_delete             in varchar2 default 'Y'
    );

procedure create_chart_page (
    p_flow_id                  in number   default null,
    p_flow_step_id             in number   default null,
    p_page_name                in varchar2 default null,
    p_chart_sql                in varchar2 default null,
    p_tab_set                  in varchar2 default null,
    p_tab_name                 in varchar2 default null, -- current tab name
    p_tab_text                 in varchar2 default null,
    p_scale                    in varchar2 default '400',
    p_axis                     in varchar2 default 'ZERO',
    p_num_mask                 in varchar2 default '999,999,999,990',
    p_plug_chart_show_summary  in varchar2 default null,
    p_region_template          in number   default null,
    p_region_name              in varchar2 default null,
    p_region_display_column    in varchar2 default '1');

procedure create_report_page (
    p_flow_id                   in number   default null,
    p_page_id                   in number   default null,
    p_page_name                 in varchar2 default null,
    p_report_sql                in varchar2 default null,
    p_report_template           in varchar2 default null,
    p_tab_set                   in varchar2 default null,
    p_tab_name                  in varchar2 default null, -- current tab name
    p_tab_text                  in varchar2 default null,
    p_plug_template             in varchar2 default null,
    p_plug_name                 in varchar2 default null,
    p_plug_display_column       in varchar2 default '1',
    p_max_rows                  in varchar2 default '15',
    p_report_type               in varchar2 default null,
    p_plug_query_options        in varchar2 default null,
    p_plug_query_max_columns    in varchar2 default null,
    p_plug_query_break_cols     in varchar2 default null,
    p_csv_output                in varchar2 default null,
    p_csv_link_text             in varchar2 default null,
    p_prn_output                in varchar2 default null,
    p_prn_format                in varchar2 default null,
    p_prn_label                 in varchar2 default null,
    p_column_heading_sort       in varchar2 default null,
    p_enable_search             in varchar2 default null,
    p_search_list               in varchar2 default null
    );

procedure create_report_page_structured (
    p_flow_id             in number   default null,
    p_page_id             in number   default null,
    p_page_name           in varchar2 default null,
    p_report_template     in varchar2 default null,
    p_tab_set             in varchar2 default null,
    p_tab_name            in varchar2 default null, -- current tab name
    p_tab_text            in varchar2 default null,
    p_plug_template       in varchar2 default null,
    p_plug_name           in varchar2 default null,
    p_use_ui_default      in varchar2 default 'Y',
    p_plug_display_column in varchar2 default '1',
    p_max_rows            in varchar2 default '15',
    p_column_heading_sort in varchar2 default 'N')
    ;


procedure create_calendar_page (
   p_flow_id               in number,
   p_page_id               in number,
   p_page_name             in varchar2,
   p_region_template       in number,
   p_region_name           in varchar2 default null,
   p_tab_set               in varchar2 default null,
   p_tab_name              in varchar2 default null, -- current tab name
   p_tab_text              in varchar2 default null,
   p_owner                 in varchar2 default null,
   p_table                 in varchar2 default 'EMP',
   --
   p_sql                   in varchar2 default null,
   p_calendar_type         in varchar2 default 'CALENDAR',
   --
   p_date_column           in varchar2 default 'HIREDATE',
   p_display_column        in varchar2 default null,
   p_display_type          in varchar2 default null
   )
   ;

procedure create_report_query (
    p_flow_id             in number,
    p_report_query_name   in varchar2,
    p_report_layout_id    in number,
    p_source_queries      in wwv_flow_global.vc_arr2,
    p_output_format       in varchar2,
    p_format_item         in varchar2,
    p_file_name           in varchar2,
    p_xml_structure       in varchar2,
    p_items               in varchar2
);

procedure update_report_query_sql_stmts (
    p_flow_id             in number,
    p_report_query_id     in number,
    p_source_queries      in wwv_flow_global.vc_arr2
);

function generate_updatable_rpt_query (
   --
   -- arguments:
   --   p_select_columns       c1:c2:c3  (all columns in query)
   --   p_updatable_columns    c2:c3     (columns that are updateable)
   --   p_table_owner          SCOTT
   --   ...
   --
   p_select_columns     in varchar2 default null,
   p_updatable_columns  in varchar2 default null,
   p_where              in varchar2 default null,
   p_table_owner        in varchar2 default null,
   p_table_name         in varchar2 default null,
   p_table_pk1          in varchar2 default null,
   p_table_pk2          in varchar2 default null,
   p_table_pk3          in varchar2 default null,
   p_table_fk           in varchar2 default null,
   p_table_fk_src_type  in varchar2 default null,
   p_table_fk_src       in varchar2 default null,
   p_implement_type     in number   default null )
   return varchar2
   ;

procedure create_form_on_equijoin (
   p_flow_id            in number,
   p_page_id            in number,
   p_page_name          in varchar2,
   p_tab_set            in varchar2 default null,
   p_tab_name           in varchar2 default null, -- current tab name
   p_tab_text           in varchar2 default null,
   p_region_title       in varchar2 default null,
   p_region_template    in number,
   p_statement          in varchar2,
   p_cancel_branch      in number,
   p_branch             in number,
   p_cancel_button_name in varchar2 default 'Cancel',
   p_create_button_name in varchar2 default 'Create',
   p_save_button_name   in varchar2 default 'Save',
   p_delete_button_name in varchar2 default 'Delete')
   ;

procedure create_wizard (
   p_flow_id                in number,
   p_steps                  in number,
   --
   p_tab_type               in varchar2 default null,
   --
   p_tab_set                in varchar2 default null,
   p_tab_name               in varchar2 default null,
   p_tab_text               in varchar2 default null,
   p_region_template        in number,
   --
   p_info_region            in varchar2 default null,
   p_info_region_template   in number default null,
   p_info_default_text      in varchar2 default null,
   --
   p_cancel_branch          in number default null,
   p_finish_branch          in number default null,
   p_cancel_button_name     in varchar2 default 'Cancel',
   p_finish_button_name     in varchar2 default 'Finish',
   p_previous_button_name   in varchar2 default '< Previous',
   p_next_button_name       in varchar2 default 'Next >')
   ;

procedure create_tree (
   p_flow_id                 in number,
   p_page_id                 in number,
   p_page_name               in varchar2,
   --
   p_tabset                  in varchar2 default null,
   p_tab_name                in varchar2 default null, -- current tab name
   p_tab_text                in varchar2 default null,
   --
   p_start_option            in varchar2,
   p_tree_name               in varchar2,
   p_tree_type               in varchar2,
   p_tree_template           in varchar2,
   p_tree_query              in varchar2,
   p_max_levels              in number,
   p_named_lov               in number default null,
   p_lov                     in varchar2 default null,
   p_sql                     in varchar2 default null,
   p_static                  in varchar2 default null,
   --
   p_region_title            in varchar2,
   p_region_template         in number,
   p_go_branch               in number,
   p_go_button_name          in varchar2 default 'GO',
   --
   p_tree_button_option      in varchar2 default null
   );

function generate_tree_query (
         p_flow_id     in number,
         p_owner       in varchar2,
         p_table_name  in varchar2,
         p_id          in varchar2,
         p_pid         in varchar2,
         p_name        in varchar2,
         p_link_option in varchar2,
         p_link_page_id in varchar2 default null,
         p_link_item    in varchar2 default null,
         p_where       in varchar2 default null,
         p_order_by    in varchar2 default null)
return varchar2;


procedure create_summary_page (
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_page_name               in varchar2 default 'Summary',
    --
    p_tab_set                 in varchar2 default null,
    p_tab_name                in varchar2 default null, -- current tab name
    p_tab_text                in varchar2 default null,
    --
    p_region_id               in number   default null,
    p_region_title            in varchar2 default null,
    p_region_template         in number   default null,
	--
    p_field_template          in number   default null,
    p_label_align             in varchar2 default null,
    p_tag_attr                in varchar2 default null,
    p_field_align             in varchar2 default null
);

procedure create_svg_chart (
    p_flow_id           in number   default null,
    p_flow_step_id      in number   default null,
    p_page_name         in varchar2 default null,
    p_tab_set           in varchar2 default null,
    p_tab_name          in varchar2 default null, -- current tab name
    p_tab_text          in varchar2 default null,
    p_region_template   in number   default null,
    p_region_name       in varchar2 default null,
    --
    p_chart_type        in varchar2 default null,
    p_chart_sql         in varchar2 default null,
    p_max_rows          in number   default null,
    p_no_data_found     in varchar2 default null,
    p_chart_color_theme in varchar2 default null
    );

procedure create_flash_chart (
    p_flow_id            in number   default null,
    p_page_id            in number   default null,
    p_page_name          in varchar2 default null,
    p_tab_set            in varchar2 default null,
    p_tab_name           in varchar2 default null,
    p_tab_text           in varchar2 default null,
    p_region_template    in number   default null,
    p_region_name        in varchar2 default null,
    --
    p_breadcrumb_id      in number   default null,
    p_bc_region_template in number   default null,
    p_breadcrumb_name    in varchar2 default null,
    p_bc_display_point   in varchar2 default null,
    p_breadcrumb_template in number  default null,
    p_parent_bc_id       in  number  default null,
    --
    p_chart_query        in varchar2 default null,
    p_max_rows           in number   default null,
    p_no_data_found      in varchar2 default null,
    --
    p_default_chart_type in varchar2 default null,
    p_chart_title        in varchar2 default null,
    p_chart_animation    in varchar2 default null,
    --
    p_bgtype             in varchar2 default null,
    p_bgcolor1           in varchar2 default null,
    p_bgcolor2           in varchar2 default null,
    p_gradient_rotation  in varchar2 default null,
    p_color_scheme       in varchar2 default null,
    p_custom_colors      in varchar2 default null,
    --
    p_x_axis_title       in varchar2 default null,
    p_y_axis_title       in varchar2 default null,
    --
    p_show_hints         in varchar2 default null,
    p_show_names         in varchar2 default null,
    p_show_values        in varchar2 default null,
    p_show_legend        in varchar2 default null,
    p_show_grid          in varchar2 default null
    );

procedure create_flash_chart_region (
    p_flow_id            in number   default null,
    p_page_id            in number   default null,
    p_region_template    in number   default null,
    p_region_name        in varchar2 default null,
    p_display_seq        in number   default null,
    p_display_col        in number   default null,
    p_display_point      in varchar2 default null,
    p_region_source_type in varchar2 default null,
    p_display_cond       in varchar2 default null,
    p_display_cond2      in varchar2 default null,
    p_display_cond_type  in varchar2 default null,
    p_auth_scheme        in varchar2 default null,
    --
    p_default_chart_type in varchar2 default null,
    p_chart_title        in varchar2 default null,
    p_chart_query        in varchar2 default null,
    p_chart_animation    in varchar2 default null,
    --
    p_bgtype             in varchar2 default null,
    p_bgcolor1           in varchar2 default null,
    p_bgcolor2           in varchar2 default null,
    p_gradient_rotation  in varchar2 default null,
    p_color_scheme       in varchar2 default null,
    p_custom_colors      in varchar2 default null,
    --
    p_x_axis_title       in varchar2 default null,
    p_y_axis_title       in varchar2 default null,
    p_max_rows           in number   default null,
    p_no_data_found      in varchar2 default null,
    --
    p_show_hints         in varchar2 default null,
    p_show_names         in varchar2 default null,
    p_show_values        in varchar2 default null,
    p_show_legend        in varchar2 default null,
    p_show_grid          in varchar2 default null
    );



procedure create_dynamic_query_region (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_id                       in number   default null,
    p_migrate_from_region           in number   default null,
    p_plug_name                     in varchar2 default null,
    p_plug_template                 in varchar2 default null,
    p_plug_display_sequence         in varchar2 default null,
    p_plug_display_column           in varchar2 default null,
    p_plug_display_point            in varchar2 default null,
    p_plug_source                   in varchar2 default null,
    p_plug_source_type              in varchar2 default null,
    p_plug_display_error_message    in varchar2 default null,
    --
    p_plug_required_role            in varchar2 default null,
    p_plug_display_when_condition   in varchar2 default null,
    p_plug_display_when_cond2       in varchar2 default null,
    p_plug_display_condition_type   in varchar2 default null,
    p_plug_header                   in varchar2 default null,
    p_plug_footer                   in varchar2 default null,
    --
    p_plug_customized               in varchar2 default null,
    p_plug_customized_name          in varchar2 default null,
    --
    p_plug_query_num_rows           in number   default null,
    p_plug_query_show_nulls_as      in varchar2 default null,
    p_plug_query_no_data_found      in varchar2 default null,
    p_plug_query_row_count_max      in number   default null,
    --
    p_pagination_display_position   in varchar2 default null,
    --
    p_required_patch                in varchar2 default null,
    p_plug_comment                  in varchar2 default null,
    --
    p_show_detail_link              in varchar2 default null,
    p_base_pk1                      in varchar2 default null,
    p_base_pk2                      in varchar2 default null,
    p_base_pk3                      in varchar2 default null);

procedure create_ir_region_on_col_info (
    p_flow_id                 in number,
    p_page_id                 in number,
    p_region_id               in number,
    p_region_title            in varchar2 default null,
    p_sql                     in varchar2 default null,
    --
    p_show_detail_link        in varchar2 default null,
    p_detail_link             in varchar2 default null,
    p_detail_link_text        in varchar2 default null,
    --
    p_table_name              in varchar2 default null,
    p_pk1                     in varchar2 default null,
    p_pk2                     in varchar2 default null,
    --
    p_db_column_name          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_display_order           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_column_label            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_report_label            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_column_type             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_display_text_as         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_format_mask             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_column_alignment        in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_help_text               in wwv_flow_global.vc_arr2 default empty_vc_arr);

procedure create_query_region (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_id                       in number   default null,
    p_plug_name                     in varchar2 default null,
    p_plug_template                 in varchar2 default null,
    p_plug_display_sequence         in varchar2 default null,
    p_plug_display_column           in varchar2 default null,
    p_plug_display_point            in varchar2 default null,
    p_plug_source                   in varchar2 default null,
    p_plug_source_type              in varchar2 default null,
    p_plug_display_error_message    in varchar2 default null,
    p_plug_create_link_text         in varchar2 default null,
    p_plug_create_link_target       in varchar2 default null,
    p_plug_create_image             in varchar2 default null,
    p_plug_create_image_attributes  in varchar2 default null,
    p_plug_edit_link_text           in varchar2 default null,
    p_plug_edit_link_target         in varchar2 default null,
    p_plug_edit_image               in varchar2 default null,
    p_plug_edit_image_attributes    in varchar2 default null,
    p_plug_expand_link_text         in varchar2 default null,
    p_plug_expand_link_target       in varchar2 default null,
    p_plug_expand_image             in varchar2 default null,
    p_plug_expand_image_attributes  in varchar2 default null,
    p_plug_close_link_text          in varchar2 default null,
    p_plug_close_link_target        in varchar2 default null,
    p_plug_close_image              in varchar2 default null,
    p_plug_close_image_attributes   in varchar2 default null,
    p_plug_required_role            in varchar2 default null,
    p_plug_display_when_condition   in varchar2 default null,
    p_plug_display_when_cond2       in varchar2 default null,
    p_plug_display_condition_type   in varchar2 default null,
    p_plug_header                   in varchar2 default null,
    p_plug_footer                   in varchar2 default null,
    p_plug_override_reg_pos         in varchar2 default null,
    p_plug_customized               in varchar2 default null,
    p_plug_customized_name          in varchar2 default null,
    --
    p_plug_query_row_template       in number   default null,
    p_plug_query_headings           in varchar2 default null,
    p_plug_query_headings_type      in varchar2 default 'COLON_DELMITED_LIST',
    p_plug_query_num_rows           in number   default null,
    p_plug_query_options            in varchar2 default null,
    p_plug_query_format_out         in varchar2 default null, -- obsolte, msewtz 10/28/02
    p_plug_query_show_nulls_as      in varchar2 default null,
    p_plug_query_col_allignments    in varchar2 default null,
    p_plug_query_break_cols         in varchar2 default null,
    p_plug_query_sum_cols           in varchar2 default null,
    p_plug_query_number_formats     in varchar2 default null,
    p_plug_query_table_border       in varchar2 default null, -- obsolte, msewtz 10/28/02
    p_plug_column_width             in varchar2 default null,
    p_plug_query_no_data_found      in varchar2 default null,
    p_plug_query_more_data          in varchar2 default null,
    p_plug_ignore_pagination        in number   default null, -- obsolte, msewtz 10/28/02
    p_plug_query_num_rows_item      in varchar2 default null,
    p_plug_query_num_rows_type      in varchar2 default null,
    p_plug_query_row_count_max      in number   default null,
    --
    p_pagination_display_position   in varchar2 default null,
    p_report_total_text_format      in varchar2 default null,
    p_break_column_text_format      in varchar2 default null,
    p_break_before_row              in varchar2 default null,
    p_break_generic_column          in varchar2 default null,
    p_break_after_row               in varchar2 default null,
    p_break_type_flag               in varchar2 default null,
    p_break_repeat_heading_format   in varchar2 default null,
    p_csv_output                    in varchar2 default null,
    p_csv_output_link_text          in varchar2 default null,
    --
    p_plug_url_text_begin           in varchar2 default null,
    p_plug_url_text_end             in varchar2 default null,
    p_java_entry_point              in varchar2 default null,
    --
    p_plug_caching                  in varchar2 default null,
    p_plug_caching_session_state    in varchar2 default null,
    p_plug_caching_max_age_in_sec   in varchar2 default null,
    --
    p_plug_chart_font_size          in varchar2 default null,
    p_plug_chart_max_rows           in varchar2 default null,
    p_plug_chart_num_mask           in varchar2 default null,
    p_plug_chart_scale              in varchar2 default null,
    p_plug_chart_axis               in varchar2 default null,
    p_plug_chart_show_summary       in varchar2 default null,
    --
    p_menu_template_id              in number   default null,
    --
    p_required_patch                in varchar2 default null,
    p_plug_comment                  in varchar2 default null,
    --
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME',
    p_prn_output                    in varchar2 default null,
    p_prn_format                    in varchar2 default null,
    p_prn_label                     in varchar2 default null,
    p_column_heading_sort           in varchar2 default null,
    p_enable_search                 in   varchar2     default null,
    p_search_list                   in   varchar2     default null
    );

procedure create_next_prev_pk_process (
    p_flow_id          in number,
    p_page_id          in number,
    p_owner            in varchar2 default null,
    p_table            in varchar2 default null,
    p_nav_region       in varchar2 default null,
    p_pk_column        in varchar2 default null,
    p_pk_column2       in varchar2 default null,
    p_sort_column      in varchar2 default null,
    p_sort_column2     in varchar2 default null,
    p_item_pk          in varchar2 default null,
    p_item_pk2         in varchar2 default null,
    p_where            in varchar2 default null);


procedure create_master_detail (
    p_flow_id                   in number   default null,
    p_master_page_id            in number   default null,
    p_detail_page_id            in number   default null,
    p_detail2_page_id           in number   default null,
    p_layout                    in varchar2 default '2_PAGE',
    p_use_ui_default            in varchar2 default 'Y',
    --
    p_master_page_title         in varchar2 default null,
    p_detail_page_title         in varchar2 default null,
    p_detail2_page_title        in varchar2 default null,
    p_master_region_title       in varchar2 default null,
    p_detail_region_title       in varchar2 default null,
    p_detail_region_title2      in varchar2 default null,
    p_detail2_region_title      in varchar2 default null,
    --
    p_tab_set                   in varchar2 default null,
    p_tab_name                  in varchar2 default null,
    p_tab_text                  in varchar2 default null,
    --
    p_master_table_owner        in varchar2 default null,
    p_master_table_name         in varchar2 default null,
    p_master_sort_column        in varchar2 default null,
    p_master_sort_column2       in varchar2 default null,
    p_include_master_report     in varchar2 default 'Y',
    p_include_master_row_nav    in varchar2 default 'Y',
    --
    p_master_table_pk1          in varchar2 default null,
    p_master_table_pk1_src_type in varchar2 default null,
    p_master_table_pk1_src      in varchar2 default null,
    p_master_table_pk2          in varchar2 default null,
    p_master_table_pk2_src_type in varchar2 default null,
    p_master_table_pk2_src      in varchar2 default null,
    --
    p_detail_table_owner        in varchar2 default null,
    p_detail_table_name         in varchar2 default null,
    p_detail_table_pk1          in varchar2 default null,
    p_detail_table_pk1_src_type in varchar2 default null,
    p_detail_table_pk1_src      in varchar2 default null,
    p_detail_table_pk2          in varchar2 default null,
    p_detail_table_pk2_src_type in varchar2 default null,
    p_detail_table_pk2_src      in varchar2 default null,
    --
    p_parent_menu_id            in number default null,
    p_menu_region_template_id   in number default null,
    p_menu_id                   in number default null,

    p_breadcrumb_name1          in varchar2 default null,
    p_breadcrumb_name2          in varchar2 default null,
    p_breadcrumb_name3          in varchar2 default null

    );

procedure update_html_header_w_shortcut (
    p_flow_id         in number,
    p_page_id         in number,
    p_shortcut_name   in varchar2,
    p_html_header_new in varchar2 default null
    );


procedure create_access_control (
    p_flow_id             in number   default null,
    p_page_id             in number   default null,
    p_page_name           in varchar2 default null,
    p_tab_set             in varchar2 default null,
    p_tab_name            in varchar2 default null, -- current tab name
    p_tab_text            in varchar2 default null
    );

procedure create_dynamic_query (
    p_flow_id            in number   default null,
    p_page_id            in number   default null,
    p_page_name          in varchar2 default null,
    p_region_name        in varchar2 default null,
    p_region_template    in varchar2 default null,
    p_tab_set            in varchar2 default null,
    p_tab_name           in varchar2 default null,
    p_tab_text           in varchar2 default null,
    --
    p_breadcrumb_id      in number   default null,
    p_bc_region_template in number   default null,
    p_breadcrumb_name    in varchar2 default null,
    p_bc_display_point   in varchar2 default null,
    p_breadcrumb_template in number  default null,
    p_parent_bc_id       in  number  default null,
    --
    p_query              in varchar2 default null,
    p_show_detail_link   in varchar2 default null,
    p_base_pk1           in varchar2 default null,
    p_base_pk2           in varchar2 default null,
    p_base_pk3           in varchar2 default null
    );

procedure create_report_on_ws (
    p_flow_id            in number   default null,
    p_page_id            in number   default null,
    p_page_name          in varchar2 default null,
    p_region_name        in varchar2 default null,
    p_region_template    in varchar2 default null,
    p_tab_set            in varchar2 default null,
    p_tab_name           in varchar2 default null,
    p_tab_text           in varchar2 default null,
    --
    p_report_template    in varchar2 default null,
    p_rows_per_page      in varchar2 default null,
    --
    p_breadcrumb_id      in number   default null,
    p_bc_region_template in number   default null,
    p_breadcrumb_name    in varchar2 default null,
    p_bc_display_point   in varchar2 default null,
    p_breadcrumb_template in number  default null,
    p_parent_bc_id       in  number  default null,
    --
    p_query              in varchar2 default null
    );

end wwv_flow_wizard_api;
/