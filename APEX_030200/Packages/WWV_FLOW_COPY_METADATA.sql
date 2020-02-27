CREATE OR REPLACE package wwv_flow_copy_metadata
as
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--
--    DESCRIPTION
--      Used to subscribe and pull flow objects.
--
--    NOTES
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

procedure remove_page_reference_id (
    --
    -- This procedure removes reference id from page templates.
    --
    p_id in number
    );

procedure remove_region_reference_id (
    --
    -- This procedure removes reference id from region templates.
    --
    p_id in number
    );

procedure remove_list_reference_id (
    --
    -- This procedure removes reference id from list templates.
    --
    p_id in number
    );

procedure remove_report_reference_id (
    --
    -- This procedure removes reference id from report templates.
    --
    p_id in number
    );

procedure remove_field_reference_id (
    --
    -- This procedure removes reference id from field templates.
    --
    p_id in number
    );

procedure remove_popuplov_reference_id (
    --
    -- This procedure removes reference id from a popup LOV template.
    --
    p_id in number
    );

procedure remove_menu_reference_id (
    --
    -- This procedure removes reference id from a menu template.
    --
    p_id in number
    );

procedure remove_button_reference_id (
    --
    -- This procedure removes reference id from a button template.
    --
    p_id in number
    );

procedure remove_calendar_reference_id (
    --
    -- This procedure removes reference id from a calendar template.
    --
    p_id in number
    );
procedure remove_scheme_reference_id (
    --
    -- This procedure removes reference id from a security scheme.
    --
    p_id in number
    );

procedure remove_shortcut_reference_id (
    --
    -- This procedure removes reference id from a shortcut.
    --
    p_id in number
    );

procedure remove_navbar_reference_id (
    --
    -- This procedure removes reference id from a navbar.
    --
    p_id in number
    );

procedure remove_lov_reference_id (
    --
    -- This procedure removes reference id from a lov.
    --
    p_id in number
    );

procedure remove_auth_setup_reference_id (
    --
    -- This procedure removes reference id from an authentication setup.
    --
    p_id in number
    );

procedure remove_item_help_reference_id (
    --
    -- This procedure removes reference id from an item help
    --
    p_id in number
    );

procedure subscribe_page_template (
    --
    -- This procedure pulls content from the master template and
    -- copies it to the subscribing template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_region_template (
    --
    -- This procedure pulls content from the master region template and
    -- copies it to the subscribing region template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_list_template (
    --
    -- This procedure pulls content from the master list template and
    -- copies it to the subscribing list template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_report_template (
    --
    -- This procedure pulls content from the master report template and
    -- copies it to the subscribing report template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_field_template (
    --
    -- This procedure pulls content from the master field template and
    -- copies it to the subscribing field template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_popuplov_template (
    --
    -- This procedure pulls content from the master popup lov template and
    -- copies it to the subscribing popup lov template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_menu_template (
    --
    -- This procedure pulls content from the master menu template and
    -- copies it to the subscribing menu template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_button_template (
    --
    -- This procedure pulls content from the master button template and
    -- copies it to the subscribing button template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_calendar_template (
    --
    -- This procedure pulls content from the master calendar template and
    -- copies it to the subscribing calendar template.
    --
    p_master_template_id         in number,
    p_subscribing_template_id    in number
    );

procedure subscribe_security_scheme (
    --
    -- This procedure pulls content from the master security scheme and
    -- copies it to the subscribing security scheme.
    --
    p_master_scheme_id         in number,
    p_subscribing_scheme_id    in number
    );

procedure subscribe_shortcut (
    --
    -- This procedure pulls content from the master short cut and
    -- copies it to the subscribing short cut.
    --
    p_master_shortcut_id         in number,
    p_subscribing_shortcut_id    in number
    );

procedure subscribe_navbar (
    --
    -- This procedure pulls content from the master navbar and
    -- copies it to the subscribing navbar.
    --
    p_master_navbar_id         in number,
    p_subscribing_navbar_id    in number
    );

procedure subscribe_lov (
    --
    -- This procedure pulls content from the master lov and
    -- copies it to the subscribing lov.
    --
    p_master_lov_id         in number,
    p_subscribing_lov_id    in number
    );

procedure subscribe_auth_setup (
    --
    -- This procedure pulls content from the master auth setup and
    -- copies it to the subscribing auth setup.
    --
    p_master_setup_id         in number,
    p_subscribing_setup_id    in number
    );

procedure subscribe_item_help (
    --
    -- This procedure pulls content from the master item help and
    -- copies it to the subscribing item help.
    p_master_item_id         in number,
    p_subscribing_item_id    in number
    );

procedure push_page_template (
    --
    -- This procedure pushes content of the page template to
    -- all templates that reference this page template.
    --
    p_template_id in number
    );

procedure push_region_template (
    --
    -- This procedure pushes content of the region template to
    -- all templates that reference this region template.
    --
    p_template_id in number
    );

procedure push_list_template (
    --
    -- This procedure pushes content of the list template to
    -- all templates that reference this list template.
    --
    p_template_id in number
    );

procedure push_report_template (
    --
    -- This procedure pushes content of the report template to
    -- all templates that reference this report template.
    --
    p_template_id in number
    );

procedure push_field_template (
    --
    -- This procedure pushes content of the field template to
    -- all templates that reference this field template.
    --
    p_template_id in number
    );

procedure push_popuplov_template (
    --
    -- This procedure pushes content of the popup LOV template to
    -- all templates that reference this popup LOV template.
    --
    p_template_id in number
    );

procedure push_menu_template (
    --
    -- This procedure pushes content of the menu template to
    -- all templates that reference this menu template.
    --
    p_template_id in number
    );

procedure push_button_template (
    --
    -- This procedure pushes content of the button template to
    -- all templates that reference this button template.
    --
    p_template_id in number
    );

procedure push_calendar_template (
    --
    -- This procedure pushes content of the calendar template to
    -- all templates that reference this calendar template.
    --
    p_template_id in number
    );

procedure push_security_scheme (
    --
    -- This procedure pushes content of the security scheme to
    -- all security schemes that reference this security scheme.
    --
    p_scheme_id in number
    );

procedure push_shortcut (
    --
    -- This procedure pushes content of the short cut to
    -- all short cuts that reference this short cut.
    --
    p_shortcut_id in number
    );

procedure push_navbar (
    --
    -- This procedure pushes content of the navbar to
    -- all navbars that reference this navbar.
    --
    p_navbar_id in number
    );

procedure push_lov (
    --
    -- This procedure pushes content of the lov to
    -- all lovs that reference this lov.
    --
    p_lov_id in number
    );

procedure push_auth_setup (
    --
    -- This procedure pushes content of the auth setup to
    -- all setups that reference this auth setup
    --
    p_setup_id in number
    );

procedure push_item_help (
    --
    -- This procedure pushes content of the item help to
    -- all item helps that reference this item help.
    --
    p_item_id in number
    );

procedure refresh_page_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_region_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_report_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_list_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_field_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_popuplov_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_menu_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_button_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_calendar_template (
    --
    -- If the master template ID is not passed, get the master template ID
    -- and refresh subscribing template.
    --
    p_subscribing_template_id    in number
    );

procedure refresh_navbar (
    --
    -- If the master navbar ID is not passed, get the master navbar ID
    -- and refresh subscribing navbar.
    p_subscribing_navbar_id    in number
    );

procedure refresh_lov (
    --
    -- If the master LOV ID is not passed, get the master LOV ID
    -- and refresh subscribing LOV.
    --
    p_subscribing_lov_id   in number
    );

procedure refresh_shortcut (
    --
    -- If the master shortcut ID is not passed, get the master shortcut ID
    -- and refresh subscribing shortcut.
    --
    p_subscribing_shortcut_id    in number
    );

procedure refresh_security_scheme (
    --
    -- If the master security scheme ID is not passed, get the master security scheme ID
    -- and refresh subscribing security scheme.
    --
    p_subscribing_scheme_id   in number
    );

procedure refresh_auth_setup (
    --
    -- If the master auth_setup ID is not passed, get the auth_setup ID
    -- and refresh auth_setup.
    --
    p_subscribing_setup_id   in number
    );

procedure refresh_item_help (
    --
    -- If the master item help ITEM ID is not passed, get the master item help ITEM ID
    -- and refresh subscribing item help.
    --
    p_subscribing_item_id    in number
    );

end wwv_flow_copy_metadata;
/