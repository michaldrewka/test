CREATE OR REPLACE package wwv_flow_create_model_app
as
--  Copyright (c) Oracle Corporation 2005. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package creates an application on multiple tables based on information from following tables:
--      WWV_FLOW_MODELS,WWV_FLOW_MODEL_PAGES,WWV_FLOW_MODEL_PAGE_COLS
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

g_flow_id        number := null;
g_home_page_id   number := null;

procedure create_modules (
    p_flow_id                    in number,
    p_model_id                   in number,
    p_theme                      in varchar2 default null,
    p_create_tabs                in varchar2 default 'SINGLE_LEVEL_TABS',
    p_authentication             in varchar2 default null,
    p_flow_language              in varchar2 default null,
    p_flow_language_derived_from in varchar2 default null,
    p_date_format                in varchar2 default null,
    p_shared_components          in varchar2 default 'DEFAULT',
    p_copy_from_theme            in number default null,
    p_copy_from_flow_id          in number default null,
    p_copy_option                in varchar2 default null
    );

end wwv_flow_create_model_app;
/