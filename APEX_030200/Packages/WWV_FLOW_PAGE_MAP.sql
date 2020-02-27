CREATE OR REPLACE package wwv_flow_page_map
as
function page_type (
   p_application_id in number,
   p_page_id in number)
return varchar2;

procedure set_page (
   p_application_id in number,
   p_page_id        in number);

function page_list (
   p_application in number,
   p_string      in varchar2)
   return varchar2;

procedure set_current_application (
   p_application_id in number,
   p_date           in date default null);

end wwv_flow_page_map;
/