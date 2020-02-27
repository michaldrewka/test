CREATE OR REPLACE package wwv_flow_xliff as


procedure generate_translation_document(
    p_flow_id             in number,
    p_page_id             in number default null,
    p_translation_flow_id in number,
    p_include_target      in varchar2 default 'N',
    p_include_all         in varchar2 default 'N',
    p_item_help           in varchar2 default null );

procedure print_translation_document(
    p_flow_id             in number,
    p_page_id             in number default null,
    p_translation_flow_id in number,
    p_include_target      in varchar2 default 'N',
    p_include_all         in varchar2 default 'N',
    p_download            in varchar2 default 'Y',
    p_item_help           in varchar2 default null );

procedure apply_xliff_translations(
    p_flow_id             in number,
    p_translation_flow_id in number,
    p_clob                in clob );

procedure apply_xliff_file(
    p_flow_id             in number,
    p_translation_flow_id in number,
    p_file_id             in number );

function get_translation_document(
    p_flow_id             in number,
    p_page_id             in number default null,
    p_translation_flow_id in number,
    p_include_target      in varchar2 default 'N',
    p_include_all         in varchar2 default 'N',
    p_item_help           in varchar2 default null )
return blob;

end wwv_flow_xliff;
/