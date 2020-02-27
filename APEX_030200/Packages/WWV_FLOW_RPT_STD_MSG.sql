CREATE OR REPLACE package wwv_flow_rpt_std_msg
is
--
--
--
--  Copyright (c) Oracle Corporation 2008. All Rights Reserved.
--
--    NAME
--      wwv_flow_rpt_std_msg.sql
--
--    DESCRIPTION
--      Messages used in report engines
--
--    RUNTIME DEPLOYMENT: YES
--
--

t_msg_rows                    varchar2(255) := 'Rows';
t_msg_all                     varchar2(255) := 'All';
t_msg_go                      varchar2(255) := 'Go';
t_msg_select_columns          varchar2(255) := 'Select Columns';
t_msg_filter                  varchar2(255) := 'Filter';
t_msg_sort                    varchar2(255) := 'Sort';
t_msg_control_break           varchar2(255) := 'Control Break';
t_msg_highlight               varchar2(255) := 'Highlight';
t_msg_compute                 varchar2(255) := 'Compute';
t_msg_aggregate               varchar2(255) := 'Aggregate';
t_msg_chart                   varchar2(255) := 'Chart';
t_msg_flashback               varchar2(255) := 'Flashback';
t_msg_save_report             varchar2(255) := 'Save Report';
t_msg_reset                   varchar2(255) := 'Reset';
t_msg_help                    varchar2(255) := 'Help';
t_msg_download                varchar2(255) := 'Download';

t_msg_sort_ascending          varchar2(255) := 'Sort Ascending';
t_msg_sort_descending         varchar2(255) := 'Sort Descending';
--t_msg_remove_filter           varchar2(255) := 'Remove Filter';
t_msg_hide_column             varchar2(255) := 'Hide Column';
--t_msg_control_break           varchar2(255) := 'Control Break';
t_msg_column_info             varchar2(255) := 'Column Information';
--t_msg_compute                 varchar2(255) := 'Compute';

t_msg_report                  varchar2(255) := 'Report';
t_msg_delete_report           varchar2(255) := 'Delete Report';
t_msg_filters                 varchar2(255) := 'Filters';
t_msg_remove_filter           varchar2(255) := 'Remove Filter';
t_msg_remove_flashback        varchar2(255) := 'Remove Flashback';
t_msg_break                   varchar2(255) := 'Control Break';
t_msg_breaks                  varchar2(255) := 'Control Breaks';
t_msg_remove_break            varchar2(255) := 'Remove Breaks';
t_msg_highlights              varchar2(255) := 'Highlights';
t_msg_remove_highlight        varchar2(255) := 'Remove Highlight';

t_msg_next                    varchar2(255) := 'Next';
t_msg_previous                varchar2(255) := 'Previous';
t_msg_enable_disable_alt      varchar2(255) := 'Enable/Disable';
t_msg_edit_filter             varchar2(255) := 'Edit Filter';
t_msg_edit_highlight          varchar2(255) := 'Edit Highlight';
t_msg_rename_report           varchar2(255) := 'Rename Report';

t_msg_working_report          varchar2(255) := 'Working Report';
t_msg_view_chart              varchar2(255) := 'View Chart';
t_msg_edit_chart              varchar2(255) := 'Edit Chart';
t_msg_view_report             varchar2(255) := 'View Report';
t_msg_chart_initializing      varchar2(255) := 'Initializing...';

t_msg_agg_sum                 varchar2(255) := 'Sum';
t_msg_agg_avg                 varchar2(255) := 'Avg';
t_msg_agg_min                 varchar2(255) := 'Min';
t_msg_agg_max                 varchar2(255) := 'Max';
t_msg_agg_median              varchar2(255) := 'Median';
t_msg_agg_count               varchar2(255) := 'Count';


-- Classic Reports
t_PAGINATION_NEXT             varchar2(255) := 'Next';
t_PAGINATION_PREVIOUS         varchar2(255) := 'Previous';
t_PAGINATION_NEXT_SET         varchar2(255) := 'Next Set';
t_PAGINATION_PREVIOUS_SET     varchar2(255) := 'Previous Set';
t_SORT_BY_THIS_COLUMN         varchar2(255) := 'Sort by this column';

procedure init (
    p_mode in varchar2 default 'ALL');

end wwv_flow_rpt_std_msg;
/