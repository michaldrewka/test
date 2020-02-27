CREATE OR REPLACE package wwv_flow_instance_admin as


procedure set_parameter(
    p_parameter           in varchar2,
    p_value               in varchar2 default 'N' );


function get_parameter(
    p_parameter           in varchar2 )
return varchar2;

function get_schemas(
    p_workspace           in varchar2 )
return varchar2;

procedure add_schema(
    p_workspace           in varchar2,
    p_schema              in varchar2 );

procedure remove_schema(
    p_workspace           in varchar2,
    p_schema              in varchar2 );

procedure add_workspace(
    p_workspace_id        in number default null,
    p_workspace           in varchar2,
    p_primary_schema      in varchar2,
    p_additional_schemas  in varchar2 );

procedure remove_workspace(
    p_workspace           in varchar2,
    p_drop_users          in varchar2 default 'N',
    p_drop_tablespaces    in varchar2 default 'N' );

procedure remove_saved_reports(
    p_application_id      in number default null );

end wwv_flow_instance_admin;
/