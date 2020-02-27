CREATE OR REPLACE package wwv_flow_list
as
procedure render(
    p_list_id           in number,
    p_list_template_id  in number default null
);
end wwv_flow_list;
/