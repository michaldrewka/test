CREATE OR REPLACE package wwv_flow_sw_api
as
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--
--    DESCRIPTION
--      SQL Workshop API
--
--    NOTES
--
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      unknown
--
--    MULTI-CUSTOMER
--      unknown
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--    RUNTIME DEPLOYMENT: YES
--

empty_vc_arr    wwv_flow_global.vc_arr2;

g_raise_errors  boolean := false;
g_error_msg     varchar2(32767) := null;
g_success_msg   varchar2(32767) := null;
g_cursor        integer;
g_dbms_output   dbms_output.chararr;

--
-- gives how many rows got updated, deleted, and inserted
--
g_rowcnt        number := 0;

function array_element(
    p_vcarr in wwv_flow_global.vc_arr2,
    p_index in number )
    return varchar2;

function format_col_value (
    p_data_type varchar2,
    p_value     varchar2 default null
    ) return varchar2;

function gen_query (
    p_owner      in varchar2,
    p_table_name in varchar2)
    return varchar2;

function valid_workspace_schema (
    p_schema in varchar2
    ) return varchar2;

procedure check_priv (
    p_schema in varchar2
    );

procedure check_priv_object (
    p_application_id in number,
    p_schema         in varchar2,
    p_object         in varchar2
    );

procedure display_error_msg (
    p_command in varchar2 default null
    );

procedure create_plan_table (
    p_schema in varchar2
    );

procedure explain_plan (
    p_plan_id in number,
    p_sql     in varchar2,
    p_schema  in varchar2
    );

procedure save_history (
    p_security_group_id in number,
    p_user              in varchar2,
    p_sql_cmd           in varchar2,
    p_schema            in varchar2
    );


procedure run_sql_arr (
    p_sql             in dbms_sql.varchar2s,
    p_schema          in varchar2,
    p_values          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_get_dbms_output in varchar2 default 'N'
    );

procedure run_sql (
    p_sql_cmd    in varchar2,
    p_schema     in varchar2,
    p_values     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_print_msg  in varchar2 default 'N'
    );

procedure create_sw_qbe_collection (
    p_object_owner     varchar2,
    p_object_name      varchar2,
    p_column_ids       wwv_flow_global.vc_arr2,
    p_column_names     wwv_flow_global.vc_arr2,
    p_query_conditions wwv_flow_global.vc_arr2,
    p_data_types       wwv_flow_global.vc_arr2,
    p_comments         wwv_flow_global.vc_arr2,
    p_checked          wwv_flow_global.vc_arr2
    );

procedure create_record (
    p_schema       in varchar2,
    p_table_owner  in varchar2,
    p_table_name   in varchar2,
    p_col_values   in wwv_flow_global.vc_arr2,
    p_synonym_name in varchar2 default null
    );

-----------------------------------------
-- UPDATE_RECORD with md5 check calls original
--
procedure update_record (
    p_schema       in varchar2,
    p_table_owner  in varchar2,
    p_table_name   in varchar2,
    p_rowid        in varchar2,
    p_col_values   in wwv_flow_global.vc_arr2,
    p_synonym_name in varchar2 default null,
    p_md5_checksum   in varchar2
    );

-----------------------------------------
-- Original UPDATE_RECORD without md5 check
--
procedure update_record (
    p_schema       in varchar2,
    p_table_owner  in varchar2,
    p_table_name   in varchar2,
    p_rowid        in varchar2,
    p_col_values   in wwv_flow_global.vc_arr2,
    p_synonym_name in varchar2 default null
    );

procedure delete_record (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_rowid        in varchar2,
    p_synonym_name in varchar2 default null,
    p_md5_checksum in varchar2
    );

procedure delete_record (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_rowid        in varchar2,
    p_synonym_name in varchar2 default null
    );

procedure register_nls_lang(
    p_lang in varchar2 default null
    );

function get_binds(
    p_stmt   in varchar2
    ) return varchar2;

procedure perform_binds(
    p_cursor in number,
    p_stmt   in varchar2,
    p_values in wwv_flow_global.vc_arr2 default empty_vc_arr);

function gen_row_md5 ( p_table_name in varchar2,
                       p_owner in varchar2,
                       p_row_id in varchar2) return varchar2;

end wwv_flow_sw_api;
/