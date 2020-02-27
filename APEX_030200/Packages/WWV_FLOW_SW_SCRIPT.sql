CREATE OR REPLACE package wwv_flow_sw_script
as
--  Copyright (c) Oracle Corporation 2005. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package is used to manage script files from SQL Workshop Script Repository.
--
--    NOTES
--      Some existing procedures from sw_api and wwv_flow_parser has been moved to this package.
--
--      This package has following limitation:
--      1.  Cannot run SELECT statement greater than 32KB.
--
--    SECURITY
--      No grants, must be run as schema owner.
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

g_result_id              number := null;

function get_success_cnt(p_result_id in number) return varchar2;

function get_failure_cnt(p_result_id in number) return varchar2;

function get_free_space return number;

function script_w_warning (p_file_id in number) return boolean;

function array_element(
    p_vcarr in wwv_flow_global.vc_arr2,
    p_index in number )
    return varchar2;

function invalid_script(p_file_id in number) return number;

function chunk_lines(p_stmt in  varchar2) return dbms_sql.varchar2s;

function getlengthb (
    p_clob in clob) return number;

function valid_script_name (
    p_script_name in varchar2
    ) return boolean;

function create_script_file (
    p_script_name in varchar2,
    p_description in varchar2 default null,
    p_script      in varchar2 default null
    ) return number;

function draw_quotameter2(
         p_max_size     in number,
         p_current_size in number)
         return varchar2;

function draw_quotameter return varchar2;

procedure clean_out_orphan_long_op;

procedure escape_sc_clob (p_str in clob);

procedure print_clob (p_str in clob);

procedure display_invalid_stmt(
    p_file_id          in number,
    p_date_time_format in varchar2);

procedure display_run_confirm (
    p_file_id          in number,
    p_date_time_format in varchar2);

procedure print_result (
    p_id in number);

procedure print_stmt (
    p_id in number);

procedure create_script_file (
    p_script_name in varchar2,
    p_script      in varchar2,
    p_description in varchar2 default null,
    p_file_id     in number   default null
    );

procedure create_script_from_clob (
    p_script_name in varchar2,
    p_script      in clob,
    p_description in varchar2 default null,
    p_file_id     in number   default null
    );

procedure save_file_attrib (
    p_flow_id           in number,
    p_security_group_id in number,
    p_name              in varchar2,
    p_created_by        in varchar2,
    p_filename          in varchar2 default null,
    p_description       in varchar2 default null,
    p_file_type         in varchar2 default 'SCRIPT',
    p_file_charset      in varchar2 default null
    );

procedure update_script_file (
    p_file_id     in number,
    p_script_name in varchar2,
    p_script      in clob
    );

procedure delete_file (
    p_id in number
    );

procedure run_file(
    p_result_id        in number,
    p_file_id          in number,
    p_schema           in varchar2,
    p_run_by           in varchar2,
    p_session          in number default null,
    p_job_id           in number default null,
    p_error_raised     in varchar2 default 'N'
    );

function submit_to_run (
    p_file_id  in number,
    p_run_by   in varchar2,
    p_run_as   in varchar2
    ) return number;

procedure cancel_script (
    p_job_id    in number,
    p_result_id in number
    );
end wwv_flow_sw_script;
/