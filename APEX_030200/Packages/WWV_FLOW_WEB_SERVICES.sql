CREATE OR REPLACE package wwv_flow_web_services as

    --------------------------------------------------
    -- globals for response, clob and xmltype
    --
    type flow_soap_response_clob    is table of clob index by binary_integer;
    g_flow_soap_response_clob       flow_soap_response_clob;

    type flow_soap_response_xmltype is table of xmltype index by binary_integer;
    g_flow_soap_response_xmltype    flow_soap_response_xmltype;

    type flow_soap_idx              is table of number index by binary_integer;
    g_flow_soap_idx                 flow_soap_idx;

    g_flow_soap_error_code          dbms_sql.varchar2_table;
    g_flow_soap_error_message       dbms_sql.varchar2_table;

    empty_vc_arr                    wwv_flow_global.vc_arr2;
    g_body                          varchar2(32000);
    g_header                        varchar2(32000);

function generate_envelope(
    p_operation in varchar2,
    p_style     in varchar2,
    p_ns        in varchar2,
    p_body      in clob,
    p_header    in clob )
return clob;

function make_request(
    p_url            in varchar2,
    p_action         in varchar2,
    p_envelope       in clob,
    p_username       in varchar2,
    p_password       in varchar2,
    p_proxy_override in varchar2 default null,
    p_charset        in varchar2 default null,
    p_wallet_path    in varchar2,
    p_wallet_pwd     in varchar2 )
return clob;

procedure make_request(
    p_id             in number,
    p_process_id     in number,
    p_charset        in varchar2 default null );

procedure make_request(
    p_id             in number,
    p_operation_id   in number,
    p_process_id     in number,
    p_charset        in varchar2 default null );

function render_request(
    p_service_id     in number,
    p_stylesheet     in clob   default null,
    p_occurrence     in number default 1,
    p_stylesheet_id  in number default null)
return clob;

procedure print_rendered_result(
    p_service_id     in number,
    p_stylesheet     in clob   default null,
    p_occurrence     in number default 1,
    p_stylesheet_id  in number default null );

function parse( p_clob in clob )
return clob ;

function get_last_error_message
return varchar2;

function find_proxy(
    p_flow_id   in varchar2)
return varchar2;

function get_parm_value(
    p_parm_id       in number,
    p_process_id    in number )
return varchar2;

function get_parm_value(
    p_name          in varchar2,
    p_parm_name     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_parm_value    in wwv_flow_global.vc_arr2 default empty_vc_arr )
return varchar2;

procedure append_element(
    p_process_id    in number default null,
    p_parm_id       in number,
    p_name          in varchar2,
    p_is_xsd        in varchar2,
    p_type          in varchar2,
    p_operation_id  in number,
    p_in_msg_style  in varchar2,
    p_soap_style    in varchar2,
    p_parm_name     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_parm_value    in wwv_flow_global.vc_arr2 default empty_vc_arr );

procedure append_element2(
    p_process_id    in number default null,
    p_parm_id       in number,
    p_name          in varchar2,
    p_is_xsd        in varchar2,
    p_type          in varchar2,
    p_operation_id  in number,
    p_in_msg_style  in varchar2,
    p_ns            in varchar2,
    p_soap_style    in varchar2,
    p_parm_name     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_parm_value    in wwv_flow_global.vc_arr2 default empty_vc_arr );

procedure generate_body(
    p_process_id    in number default null,
    p_operation_id  in number,
    p_in_msg_style  in varchar2,
    p_soap_style    in varchar2,
    p_parm_name     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_parm_value    in wwv_flow_global.vc_arr2 default empty_vc_arr );

procedure generate_header(
    p_process_id    in number default null,
    p_operation_id  in number,
    p_in_msg_style  in varchar2,
    p_ns            in varchar2,
    p_soap_style    in varchar2,
    p_parm_name     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_parm_value    in wwv_flow_global.vc_arr2 default empty_vc_arr );

function get_path(
    p_parm_id       in number,
    p_level         in number default 0 )
return varchar2;

function generate_query(
    p_operation_id              in number,
    p_array_parm                in number,
    p_report_collection_name    in varchar2,
    p_array_parms_collection    in varchar2 )
return varchar2;

function generate_query_manual(
    p_result_node               in varchar2,
    p_soap_style                in varchar2,
    p_message_format            in varchar2,
    p_namespace                 in varchar2,
    p_report_collection_name    in varchar2,
    p_array_parms_collection    in varchar2 )
return varchar2;

function UDDI_request(
    p_uddi_url              in varchar2,
    p_request_type          in varchar2,
    p_request_parameter     in varchar2,
    p_proxy_url             in varchar2,
    p_request_parameter2    in varchar2 default null,
    p_uddi_version          in varchar2 default '2.0' )
return xmltype;

procedure find_services_by_servname(
    p_uddi_url              in varchar2,
    p_request_parameter2    in varchar2,
    p_flow_id               in varchar2,
    p_services_collection   in varchar2,
    p_exact                 in varchar2 default 'N',
    p_case_sensitive        in varchar2 default 'N',
    p_uddi_version          in varchar2 default '2.0' );

procedure find_services_by_busname(
    p_uddi_url              in varchar2,
    p_request_parameter     in varchar2,
    p_flow_id               in varchar2,
    p_services_collection   in varchar2,
    p_exact                 in varchar2 default 'N',
    p_case_sensitive        in varchar2 default 'N',
    p_uddi_version          in varchar2 default '2.0' );

procedure get_service_details(
    p_uddi_url              in varchar2,
    p_request_parameter     in varchar2,
    p_flow_id               in varchar2,
    p_services_collection   in varchar2,
    p_details_collection    in varchar2,
    p_uddi_version          in varchar2 default '2.0' );

function WSDL_analyze(
    p_wsdl_url                      in varchar2,
    p_flow_id                       in varchar2,
    p_uddi_details_collection       in varchar2,
    p_web_service_collection        in varchar2,
    p_operations_collection         in varchar2,
    p_inputs_collection             in varchar2,
    p_outputs_collection            in varchar2,
    p_username                      in varchar2,
    p_password                      in varchar2 )
return varchar2;

procedure create_web_service(
    p_id                            in number,
    p_flow_id                       in varchar2,
    p_name                          in varchar2,
    p_url                           in varchar2,
    p_target_ns                     in varchar2,
    p_xsd_prefix                    in varchar2,
    p_soap_style                    in varchar2,
    p_operations_collection         in varchar2,
    p_inputs_collection             in varchar2,
    p_outputs_collection            in varchar2,
    p_basic_auth                    in varchar2 );

procedure update_process_parms(
    p_process_id                    in number,
    p_in_parm_ids                   in wwv_flow_global.vc_arr2,
    p_in_parm_map_types             in wwv_flow_global.vc_arr2,
    p_in_parm_values                in wwv_flow_global.vc_arr2,
    p_out_map_type                  in varchar2,
    p_out_parm_ids                  in wwv_flow_global.vc_arr2,
    p_out_parm_values               in wwv_flow_global.vc_arr2,
    p_auth_parm_ids                 in wwv_flow_global.vc_arr2,
    p_auth_parm_map_types           in wwv_flow_global.vc_arr2,
    p_auth_parm_values              in wwv_flow_global.vc_arr2 );

procedure create_process_parms(
    p_process_id                    in number,
    p_in_parm_collection_name       in varchar2,
    p_out_map_type                  in varchar2,
    p_out_parm_collection_name      in varchar2 );

procedure create_auth_parms(
    p_process_id                    in number,
    p_auth_collection_name       in varchar2 );

end wwv_flow_web_services;
/