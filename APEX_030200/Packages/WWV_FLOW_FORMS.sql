CREATE OR REPLACE package wwv_flow_forms
as

--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--    DESCRIPTION
--      Flow form rendering engine package specification.
--
--    SECURITY
--
--    INTERNATIONALIZATION
--
--    NOTES
--      This program generates HTML form fields, this package is a utility package to wwv_flow.
--
--    RUNTIME DEPLOYMENT: YES
--

g_current_form_element  varchar2(256) := null;
g_current_item_sequence int := 0; -- generated fXX seq
g_i                     int := 0; -- index of wwv_flow.g_item_cattributes
g_current_x             char(2) := '00'; -- current number of x attribute from wwv_flow.accept

function increment_item_sequence (
    p_current_item_seq_value in number)
    return number
    ;

procedure display_positional_form (
    p_box_border         in varchar2 default '0',
    p_current_plug_id    in number   default 0)
    ;

procedure display_template_form
    ;

end wwv_flow_forms;
/