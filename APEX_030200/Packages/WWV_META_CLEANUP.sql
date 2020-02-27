CREATE OR REPLACE package wwv_meta_cleanup
as
--
--
--
--  Copyright (c) Oracle Corporation 2000 - 2002. All Rights Reserved.
--
--    NAME
--      meta_cleanup.sql
--
--    DESCRIPTION
--      Package to cleanup meta data between versions
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
--

    procedure template_head_update;

    procedure item_attributes;

    procedure row_template_condition;

    procedure copy_svg_series_attr;

    procedure menu_options_update;

    procedure lov_data_update;

    procedure svg_region_source_update;

    procedure report_columns_update;

    procedure fix_app_auth_logout_url;

    procedure enforce_page_alias_uniqueness;

    procedure fix_file_repository;

end wwv_meta_cleanup;
/