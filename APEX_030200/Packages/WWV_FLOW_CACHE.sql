CREATE OR REPLACE package wwv_flow_cache
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--    DESCRIPTION
--      Flow cache management package.
--
--    NOTES
--      This package contains procedures and functions that
--      maintain and manipulate the flow session cache.
--
--    SECURITY
--      Requires Oracle user executing procedure be granted WWV_FLOW_BUILDER role.
--
--    RUNTIME DEPLOYMENT: YES
--
as
g_purged_sessions number :=0;

procedure purge_oldest_sessions (
    --
    -- Purge flow session state tables to avoid keeping session
    -- state no longer needed.  To avoid too much activity this
    -- procedure allows you to set a maximum number of sessions
    -- you would like to purge.
    --
    p_num_sessions_to_purge     in number default 1000,
    p_purge_sess_older_then_hrs in number default 12,
    p_security_group_id         in number default null)
    ;
procedure purge_sessions (
    --
    -- Purge flow session state tables to avoid keeping session
    -- state no longer needed.  Purge all sessions older then a certain
    -- age.  May result in a very large number of delete transactions.
    -- Commit is performed between delete commands.
    --
    p_purge_sess_older_then_hrs in number default 12,
    p_security_group_id         in number default null,
    p_report_results            in varchar2 default 'NO')
    ;
procedure purge_duplicate_sessions (
    --
    -- Purge flow session state tables to avoid keeping session
    -- state no longer needed.  Remove oldest session for users with
    -- multiple sessions.
    --
    p_security_group_id in number default null,
    p_report_results            in varchar2 default 'NO')
    ;
procedure show_session_state (
    --
    --
    --
    p_session in number)
    ;

procedure rebuild_indexes
    --
    -- Rebuilds the indexes associated with the caching tables.
    -- This is important since the session # is sequential,
    -- therefore the index will continually get skewed to the
    -- right.
    ;


procedure compute_stats
    --
    -- Computes statistics for all tables, indexes
    -- and indexed columns (Histograms) for all flows session
    -- related tables.
    ;

procedure purge_n_rebuild(
    --
    -- Runs purge sessions, rebuild_indexes, and compute_stats.
    p_purge_sess_older_then_hrs in number default 12,
    p_security_group_id         in number default null,
    p_report_results            in varchar2 default 'NO')
    ;

procedure set_flow_builder_state
    ;
procedure set_fb_flow_page_id
    ;

end wwv_flow_cache;



/