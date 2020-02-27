CREATE OR REPLACE package wwv_flow_model_api as


    -----------------------------------------------------------------------------------------------
    -- get_model_id
    -- deletes incomplete models and returns new model ID

    function get_model_id return number;

    -----------------------------------------------------------------------------------------------
    -- add_form_report_w_analysis
    --    p_model_id:         model_id
    --    p_parent_page_num:  parent page
    --    p_owner:            parse as schema name
    --    p_table:            source table for report and form page

    procedure add_form_report_w_analysis (
        p_model_id         varchar2,
        p_page_type        varchar2 default null,
        p_parent_page_num  varchar2 default null,
        p_owner            varchar2 default null,
        p_table            varchar2 default null,
        p_sum_cols         varchar2 default null,
        p_aggregate_cols   varchar2 default null,
        p_agg_function     varchar2 default null,
        p_create_mode      varchar2 default null,
        p_chart_type       varchar2 default null
    );

    -----------------------------------------------------------------------------------------------
    -- add_page, return page_id
    -- p_model_id:        model_id
    -- p_page_name:       name of new page
    -- p_page_type:       page source type: REPORT, REPORTANDFORM, TABULARFORM, FORM, BLANK
    -- p_page_source:     page source type: TABLE, QUERY, SPREADSHEET
    -- p_parent_page_id:  parent page
    -- p_owner:           parse as schema name
    -- p_table:           source table for report and form page
    -- p_query:           source query for report page
    -- p_spreadsheet_data:source data for spreadsheet based table
    -- p_report_filter:   report filter
    -- p_form_and_report: flag to determine whether to create report (QUERY) or report and from (UPDATE)
    -- p_implementation:  flag to determine whether to create classic or interactive report
    -- p_master_table:    source table for the 1st page of master-detail form
    -- p_detail_table:    source table for the master-detail page of a master-detail form
    -- p_form_table:      source table for Forms Migrations Form Page generation
    -- p_block_id:        wwv_mig_frm_blocks.id value to identify converted Oracle Forms block
    -- p_report_id:       wwv_mig_rpts.id value to identify converted Oracle Report

    function add_page (
        p_model_id         varchar2,
        p_page_name        varchar2,
        p_page_type        varchar2,
        p_page_source      varchar2,
        p_parent_page_num  varchar2 default null,
        p_owner            varchar2 default null,
        p_table            varchar2 default null,
        p_query            varchar2 default null,
        p_spreadsheet_data varchar2 default null,
        p_report_filter    varchar2 default null,
        p_form_and_report  varchar2 default null,
        p_implementation   varchar2 default null,
        p_master_table     varchar2 default null,
        p_detail_table     varchar2 default null,
        p_form_table       varchar2 default null,
        p_block_id         number   default null,
        p_report_id        number   default null
    ) return number;

    -----------------------------------------------------------------------------------------------
    -- add_page
    -- p_model_id:        model_id
    -- p_page_name:       name of new page
    -- p_page_type:       page source type: REPORT, REPORTANDFORM, TABULARFORM, FORM, BLANK
    -- p_page_source:     page source type: TABLE, QUERY, SPREADSHEET
    -- p_parent_page_id:  parent page
    -- p_owner:           parse as schema name
    -- p_table:           source table for report and form page
    -- p_query:           source query for report page
    -- p_spreadsheet_data:source data for spreadsheet based table
    -- p_report_filter:   report filter
    -- p_form_and_report: flag to determine whether to create report (QUERY) or report and from (UPDATE)
    -- p_implementation:  flag to determine whether to create classic or interactive report
    -- p_master_table:    source table for the 1st page of master-detail form
    -- p_detail_table:    source table for the master-detail page of a master-detail form
    -- p_form_table:      source table for Forms Migrations Form Page generation
    -- p_block_id:        wwv_mig_frm_blocks.id value to identify converted Oracle Forms block
    -- p_report_id:       wwv_mig_rpts.id value to identify converted Oracle Report

    procedure add_page (
        p_model_id         varchar2,
        p_page_name        varchar2,
        p_page_type        varchar2,
        p_page_source      varchar2,
        p_parent_page_num  varchar2 default null,
        p_owner            varchar2 default null,
        p_table            varchar2 default null,
        p_query            varchar2 default null,
        p_spreadsheet_data varchar2 default null,
        p_report_filter    varchar2 default null,
        p_form_and_report  varchar2 default null,
        p_implementation   varchar2 default null,
        p_master_table     varchar2 default null,
        p_detail_table     varchar2 default null,
        p_form_table       varchar2 default null,
        p_block_id         number   default null,
        p_report_id        number   default null
    );

    -----------------------------------------------------------------------------------------------
    -- set_report_to_report_link
    -- p_report_tables:        Array of 2 table names: parent table and child table
    -- p_owner:                parse as schema name
    -- p_parent_page_num:      parent page

    procedure set_report_to_report_link (
        p_report_tables     wwv_flow_global.vc_arr2,
        p_owner             varchar2,
        p_parent_page_num   varchar2
    );


    -----------------------------------------------------------------------------------------------
    -- copy_model_pages
    -- p_owner:           parse as schema name
    -- p_model_id         new model ID
    -- p_source_model_id  source mode ID

    procedure copy_model_pages (
        p_owner                   varchar2,
        p_model_id                varchar2,
        p_source_model_id         varchar2,
        p_parent_page_id          number default null,
        p_source_parent_page_id   number default null
    );

end;
/