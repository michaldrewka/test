CREATE OR REPLACE package apex_ui_default_update as

--  Copyright (c) Oracle Corporation 2008. All Rights Reserved.
--
--    NAME
--      apex_ui_default_update.sql
--
--    DESCRIPTION
--      API to allow update to select attributes via mechanism other than APEX.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      No known issues
--
--    MULTI-CUSTOMER
--      Because UI Defaults are schema specific, there is no SGID check
--      These can only be run for the current user
--

procedure upd_form_region_title (
    p_table_name            in varchar2,
    p_form_region_title     in varchar2 default null
    );

procedure upd_report_region_title (
    p_table_name            in varchar2,
    p_report_region_title   in varchar2 default null
    );

procedure upd_label (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_label                 in varchar2 default null
    );

procedure upd_item_help (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_help_text             in varchar2 default null
    );

procedure upd_display_in_form (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_display_in_form       in varchar2
    );

procedure upd_display_in_report (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_display_in_report     in varchar2
    );

procedure upd_item_display_width (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_display_width         in number
    );

procedure upd_item_display_height (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_display_height        in number
    );

procedure upd_report_alignment (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_report_alignment      in varchar2
    );

procedure upd_item_format_mask (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_format_mask           in varchar2 default null
    );

procedure upd_report_format_mask (
    p_table_name            in varchar2,
    p_column_name           in varchar2,
    p_format_mask           in varchar2 default null
    );

end apex_ui_default_update;
/