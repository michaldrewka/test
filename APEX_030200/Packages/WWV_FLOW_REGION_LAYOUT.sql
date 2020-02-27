CREATE OR REPLACE package wwv_flow_region_layout
as

    g_first_process boolean := true;

-- show hide 4150
procedure page_rendering_icons (
    p_page in varchar2 default null)
    ;
procedure shared_component_icons (
    p_page in varchar2 default null)
    ;
procedure page_processing_icons (
    p_page in varchar2 default null)
    ;


-- apex 2.2 4150 rendering
procedure show_on_load_page (
    p_page                 in number,
    p_flow                 in number,
    p_session              in number)
    ;
procedure show_on_load_regions (
    p_page                 in number,
    p_flow                 in number,
    p_session              in number)
    ;
procedure show_page_buttons (
    p_page          in number,
    p_flow          in number,
    p_session       in number)
    ;
procedure show_page_items (
    p_page          in number,
    p_flow          in number,
    p_session       in number)
    ;
procedure show_on_load_computations (
    p_page                 in number,
    p_flow                 in number,
    p_session              in number)
    ;
procedure show_on_load_processes (
    p_page                 in number,
    p_flow                 in number,
    p_session              in number)
    ;

-- on submit
procedure show_on_submit_comp (
    p_page in number,
    p_flow in number,
    p_session in number)
    ;
procedure show_on_submit_val (
    p_page in number,
    p_flow in number,
    p_session in number)
    ;
procedure show_on_submit_proc (
    p_page    in number,
    p_flow    in number,
    p_session in number)
    ;

procedure show_on_submit_branch (
    p_page    in number,
    p_flow    in number,
    p_session in number)
    ;

-- shared
procedure show_shared_tabs (
    p_page in number,
    p_flow in number,
    p_session in number)
    ;
procedure show_shared_lov (
    p_page in number,
    p_flow in number,
    p_session in number)
    ;
procedure show_shared_bc (
    p_page     in number,
    p_flow     in number,
    p_session  in number)
    ;
procedure show_shared_lists (
    p_page     in number,
    p_flow     in number,
    p_session  in number)
    ;
procedure show_shared_theme (
    p_page     in number,
    p_flow     in number,
    p_session  in number)
    ;
procedure show_shared_templates (
    p_page     in number,
    p_flow     in number,
    p_session  in number)
    ;
procedure show_shared_security (
    p_page     in number,
    p_flow     in number,
    p_session  in number)
    ;
procedure show_shared_navbar (
    p_page     in number,
    p_flow     in number,
    p_session  in number)
    ;



-- 4150 helper functions

 procedure show_apex_home_pg_elink (
    p_page     in number default null,
    p_flow     in number default null,
    p_session  in number default null)
    ;
 procedure set_lock_status (
    p_flow in number,
    p_page in number)
    ;



-- other


procedure show_page_template (
    p_flow          in number,
    p_page          in number default null,
    p_template      in varchar2 default null,
    p_template_id   in number   default null)
    ;

procedure page_temp_substitution (
    p_flow          in number,
    p_template_id   in number)
    ;

procedure show_on_load_flow (
    p_page          in number,
    p_flow          in number,
    p_session       in number,
    p_show_all      in boolean default false)
    ;

procedure show_on_accept_flow (
    p_page          in number,
    p_flow          in number,
    p_session       in number,
    p_show_all      in boolean default false)
    ;

procedure show_related_pages_report (
    p_flow          in number,
    p_session       in number)
    ;


procedure show_region_template (
    p_flow          in number,
    p_template_id   in number);

procedure region_temp_substitution (
    p_flow          in number,
    p_template_id   in number);

procedure set_most_recently_edited (
    p_security_group_id in number,
    p_user              in varchar2);

procedure show_title (
       p_title in varchar2,
       p_t1    in varchar2 default null,
       p_n1    in varchar2 default null,
       p_t2    in varchar2 default null,
       p_n2    in varchar2 default null,
       p_t3    in varchar2 default null,
       p_n3    in varchar2 default null,
       p_t4    in varchar2 default null,
       p_n4    in varchar2 default null,
       p_t5    in varchar2 default null,
       p_n5    in varchar2 default null,
       p_t6    in varchar2 default null,
       p_n6    in varchar2 default null,
       p_button_class in varchar2 default null,
       p_title_tab_attributes in varchar2 default null,
       p_help  in varchar2,
       p_name  in varchar2 default null);

end wwv_flow_region_layout;
/