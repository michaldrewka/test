CREATE OR REPLACE package wwv_render_report3 as

  type num_arr is table of number index by binary_integer;
  type totals_table is table of num_arr index by binary_integer;
  type preview_table is table of varchar2(255) index by binary_integer;
  type col_names_index_type is table of number index by varchar2(4000);

  type row_template_type is record (
    template                    varchar2(32767),
    type                        varchar2(32767),
    before_rows                 varchar2(32767),
    after_rows                  varchar2(32767),
    before_first                varchar2(32767),
    after_last                  varchar2(32767),
    tab_attr                    varchar2(32767),
    row_style_mouse_over        varchar2(255),
    row_style_mouse_out         varchar2(255),
    row_style_checked           varchar2(255),
    row_style_unchecked         varchar2(255),
    pagination                  varchar2(32767),
    pagination_template         varchar2(32767),
    next_page_template          varchar2(32767),
    previous_page_template      varchar2(32767),
    next_set_template           varchar2(32767),
    previous_set_template       varchar2(32767),
    report_total_text_format    varchar2(32767),
    break_column_text_format    varchar2(32767),
    break_before_row            varchar2(32767),
    break_generic_column        varchar2(32767),
    break_after_row             varchar2(32767),
    break_type_flag             varchar2(255),
    break_repeat_heading_format varchar2(32767)
  );

  -- ----------------------------------------------------------------------------------------
  -- globals
  g_status                      varchar(5000)   := null;    -- execution status
  empty_vc_arr                  wwv_flow_global.vc_arr2;
  empty_num_arr                 num_arr;
  g_empty_cell                  varchar2(8) := '&nbsp;';
  g_ok_to_continue              boolean := true;
  g_is_xml_export               boolean := false;
  g_has_derived_columns         boolean := false;
  g_has_row_selector            boolean := false;
  g_has_row_highlighting        boolean := false;
  g_show_nulls                  varchar2(255);

  g_report_column_id              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_query_column_id               wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_form_element_id               wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_derived_column                wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_alias                  wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_heading                wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_format                 wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_html_expression        wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_css_class              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_css_style              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_hit_highlight          wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_link                   wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_linktext               wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_link_attr              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_link_checksum_type     wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_alignment              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_heading_alignment             wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_default_sort_column_sequence  wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_default_sort_dir              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_disable_sort_column           wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_sum_column                    wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_hidden_column                 wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_asc_image                     wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_asc_image_attr                wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_desc_image                    wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_desc_image_attr               wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_display_when_cond_type        wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_display_when_condition        wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_display_when_condition2       wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_required_role          wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_query_options                 wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_max_generic_cols              wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_display_as                    wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_include_in_page               wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_named_lov                     wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_inline_lov                    wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_lov_show_nulls                wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_lov_null_text                 wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_lov_null_value                wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_lov_display_extra             wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_width                  wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_height                 wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_cattributes                   wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_cattributes_element           wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_default                wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_column_default_type           wwv_flow_global.vc_arr2 := empty_vc_arr;

  g_empty_idx                     col_names_index_type;
  g_report_alias_idx              col_names_index_type := g_empty_idx;
  g_column_alias_idx              col_names_index_type := g_empty_idx;
  g_use_generic_columns           boolean := false;
  g_use_legacy_reports            boolean := false;
  g_sort_enabled                  boolean := false;
  g_is_tabular_form               boolean := false;
  g_break_cols                    wwv_flow_global.vc_arr2 := empty_vc_arr;

  g_include_in_export             wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_print_col_width               wwv_flow_global.vc_arr2 := empty_vc_arr;
  g_print_col_align               wwv_flow_global.vc_arr2 := empty_vc_arr;

  g_show_total_row_count_max      number := 1000;  -- max number when count the query's rows
  g_max_columns                   number := 60;

  -- ----------------------------------------------------------------------------------------
  -- pagination globals
  g_rows_per_page               number := null;          -- number of rows shown on each page
  g_total_rows                  number := null;          -- number of rows returned
  g_num_rows                    number := null;          -- number of rows returned
  g_internet_pagination         varchar2(32767) := null;
  g_row_ranges                  varchar2(32767) := null;
  g_row_ranges_in_select_list   varchar2(32767) := null;
  g_next_link                   varchar2(1000)  := null;
  g_previous_link               varchar2(1000)  := null;


  g_prn_number_of_cols          number := 0;
  g_prn_page_width              number := 792;
  g_prn_page_height             number := 612;

  g_prn_template_table_cells    varchar2(32767) := null;
  g_prn_template_header_row     varchar2(32767) := null;
  g_prn_template_body_row       varchar2(32767) := null;

  g_prn_template_clob           clob;
  g_prn_template_type           varchar2(255);

--------------------------------------------------------------------------------------------------------------
-- generic XSL-FO definition

  g_prn_template_table_cell_fop  varchar2(32767) := '<fo:table-column column-width="#COLUMN_WIDTH#pt"/>';

  g_prn_template_header_col_fop  varchar2(32767) := '
<fo:table-cell xsl:use-attribute-sets="cell header-color border">
    <fo:block xsl:use-attribute-sets="text #TEXT_ALIGN#">
        <fo:inline xsl:use-attribute-sets="header-font">#COLUMN_HEADING#</fo:inline>
    </fo:block>
</fo:table-cell>
';


  g_prn_template_body_col_fop    varchar2(32767) :='
<fo:table-cell xsl:use-attribute-sets="cell border">
    <fo:block xsl:use-attribute-sets="text #TEXT_ALIGN#">
        <fo:inline xsl:use-attribute-sets="body-font">
            <xsl:value-of select=".//#COLUMN_HEADER_NAME#"/>
        </fo:inline>
    </fo:block>
</fo:table-cell>
';


  g_prn_template_fop             varchar2(32767) := '<?xml version = ''1.0'' encoding = ''utf-8''?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink">
      <xsl:variable name="_XDOFOPOS" select="''''"/>
      <xsl:variable name="_XDOFOPOS2" select="number(1)"/>
      <xsl:variable name="_XDOFOTOTAL" select="number(1)"/>
    <xsl:variable name="_XDOFOOSTOTAL" select="number(0)"/>
   <xsl:attribute-set name="padding">
      <xsl:attribute name="padding-bottom">0.25pt</xsl:attribute>
      <xsl:attribute name="padding-top">0.25pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="text">
      <xsl:attribute name="text-align">start</xsl:attribute>
      <xsl:attribute name="orphans">2</xsl:attribute>
      <xsl:attribute name="start-indent">0.0pt</xsl:attribute>
      <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
      <xsl:attribute name="padding-top">0.0pt</xsl:attribute>
      <xsl:attribute name="end-indent">0.0pt</xsl:attribute>
      <xsl:attribute name="padding-bottom">0.0pt</xsl:attribute>
      <xsl:attribute name="height">0.0pt</xsl:attribute>
      <xsl:attribute name="widows">2</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="align-left">
      <xsl:attribute name="text-align">left</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="align-center">
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="align-right">
      <xsl:attribute name="text-align">right</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="footer">
      <xsl:attribute name="text-align">right</xsl:attribute>
      <xsl:attribute name="start-indent">5.4pt</xsl:attribute>
      <xsl:attribute name="end-indent">5.4pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="text_2">
      <xsl:attribute name="start-indent">5.4pt</xsl:attribute>
      <xsl:attribute name="end-indent">23.4pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="text_20">
      <xsl:attribute name="height">13.872pt</xsl:attribute>
      <xsl:attribute name="end-indent">5.4pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="text_0">
      <xsl:attribute name="end-indent">5.4pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="page-header">
      <xsl:attribute name="color">#PAGE_HEADER_FONT_COLOR#</xsl:attribute>
      <xsl:attribute name="font-family">#PAGE_HEADER_FONT_FAMILY#</xsl:attribute>
      <xsl:attribute name="white-space-collapse">false</xsl:attribute>
      <xsl:attribute name="font-size">#PAGE_HEADER_FONT_SIZE#pt</xsl:attribute>
      <xsl:attribute name="font-weight">#PAGE_HEADER_FONT_WEIGHT#</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="page-footer">
      <xsl:attribute name="color">#PAGE_FOOTER_FONT_COLOR#</xsl:attribute>
      <xsl:attribute name="font-family">#PAGE_FOOTER_FONT_FAMILY#</xsl:attribute>
      <xsl:attribute name="white-space-collapse">false</xsl:attribute>
      <xsl:attribute name="font-size">#PAGE_FOOTER_FONT_SIZE#pt</xsl:attribute>
      <xsl:attribute name="font-weight">#PAGE_FOOTER_FONT_WEIGHT#</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="body-font">
      <xsl:attribute name="height">12.0pt</xsl:attribute>
      <xsl:attribute name="font-family">#BODY_FONT_FAMILY#</xsl:attribute>
      <xsl:attribute name="white-space-collapse">false</xsl:attribute>
      <xsl:attribute name="font-size">#BODY_FONT_SIZE#pt</xsl:attribute>
      <xsl:attribute name="font-weight">#BODY_FONT_WEIGHT#</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="page-number">
      <xsl:attribute name="height">13.872pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="header-font">
      <xsl:attribute name="height">#HEADER_FONT_SIZE#pt</xsl:attribute>
      <xsl:attribute name="font-family">#HEADER_FONT_FAMILY#</xsl:attribute>
      <xsl:attribute name="white-space-collapse">false</xsl:attribute>
      <xsl:attribute name="font-size">#HEADER_FONT_SIZE#pt</xsl:attribute>
      <xsl:attribute name="font-weight">#HEADER_FONT_WEIGHT#</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="border">
      <xsl:attribute name="border-top">#BORDER_WIDTH#pt solid #BORDER_COLOR#</xsl:attribute>
      <xsl:attribute name="border-bottom">#BORDER_WIDTH#pt solid #BORDER_COLOR#</xsl:attribute>
      <xsl:attribute name="border-start-width">#BORDER_WIDTH#pt</xsl:attribute>
      <xsl:attribute name="border-start-color">#BORDER_COLOR#</xsl:attribute>
      <xsl:attribute name="border-start-style">solid</xsl:attribute>
      <xsl:attribute name="border-end-width">#BORDER_WIDTH#pt</xsl:attribute>
      <xsl:attribute name="border-end-color">#BORDER_COLOR#</xsl:attribute>
      <xsl:attribute name="border-end-style">solid</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="cell">
      <xsl:attribute name="background-color">#BODY_BG_COLOR#</xsl:attribute>
      <xsl:attribute name="color">#BODY_FONT_COLOR#</xsl:attribute>
      <xsl:attribute name="padding-start">5.15pt</xsl:attribute>
      <xsl:attribute name="vertical-align">top</xsl:attribute>
      <xsl:attribute name="padding-top">0.0pt</xsl:attribute>
      <xsl:attribute name="padding-end">5.15pt</xsl:attribute>
      <xsl:attribute name="number-columns-spanned">1</xsl:attribute>
      <xsl:attribute name="height">0.0pt</xsl:attribute>
      <xsl:attribute name="padding-bottom">0.0pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="header-color">
      <xsl:attribute name="background-color">#HEADER_BG_COLOR#</xsl:attribute>
      <xsl:attribute name="color">#HEADER_FONT_COLOR#</xsl:attribute>
   </xsl:attribute-set>
   <xsl:template match="/">
      <fo:root>
         <fo:layout-master-set>
            <fo:simple-page-master master-name="master0" margin-left="66.6pt" margin-right="66.6pt" page-height="#PAGE_HEIGHT#pt" page-width="#PAGE_WIDTH#pt" margin-top="36.0pt" margin-bottom="36.0pt">
               <fo:region-before region-name="region-header" extent="54.0pt"/>
               <fo:region-body region-name="region-body" margin-top="54.0pt" margin-bottom="54.0pt"/>
               <fo:region-after region-name="region-footer" extent="54.0pt" display-align="after"/>
            </fo:simple-page-master>
         </fo:layout-master-set>
         <fo:page-sequence master-reference="master0">
            <xsl:variable name="_PW" select="number(#PAGE_HEIGHT#)"/>
            <xsl:variable name="_PH" select="number(#PAGE_WIDTH#)"/>
            <xsl:variable name="_ML" select="number(72.0)"/>
            <xsl:variable name="_MR" select="number(72.0)"/>
            <xsl:variable name="_MT" select="number(90.0)"/>
            <xsl:variable name="_MB" select="number(90.0)"/>
            <xsl:variable name="_HY" select="number(36.0)"/>
            <xsl:variable name="_FY" select="number(36.0)"/>
            <xsl:variable name="_SECTION_NAME" select="string(''master0'')"/>
            <fo:static-content flow-name="region-header">
               <fo:block xsl:use-attribute-sets="text text_2 text_0 #PAGE_HEADER_ALIGNMENT#">
                  <fo:inline xsl:use-attribute-sets="page-header">#PAGE_HEADER#</fo:inline>
               </fo:block>
            </fo:static-content>
            <fo:static-content flow-name="region-footer">
               <fo:block xsl:use-attribute-sets="text footer">
                  <fo:inline xsl:use-attribute-sets="body-font page-number">
                     <fo:page-number/>
                  </fo:inline>
               </fo:block>
               <fo:block xsl:use-attribute-sets="text text_2 #PAGE_FOOTER_ALIGNMENT#">
                  <fo:inline xsl:use-attribute-sets="page-footer">#PAGE_FOOTER#</fo:inline>
               </fo:block>
            </fo:static-content>
            <fo:flow flow-name="region-body">
               <fo:block xsl:use-attribute-sets="padding">
                  <fo:table start-indent="0.0pt">
                     <xsl:variable name="_XDOFOPOS2" select="number(1)"/>
                     <xsl:variable name="_XDOFOTOTAL" select="number(1)"/>
                     #PRN_TABLE_CELLS#
                     <fo:table-header>
                        <fo:table-row>
                           #PRN_TEMPLATE_HEADER_ROW#
                        </fo:table-row>
                     </fo:table-header>
                     <fo:table-body>
                        <xsl:for-each select=".//ROW">
                           <fo:table-row>
                              #PRN_TEMPLATE_BODY_ROW#
                           </fo:table-row>
                        </xsl:for-each>
                     </fo:table-body>
                  </fo:table>
               </fo:block>
               <fo:block xsl:use-attribute-sets="text text_2 text_20">
                  <fo:inline id="{concat(''page-total-'', $_SECTION_NAME, $_XDOFOPOS)}"/>
                  <fo:inline id="{concat(''page-total'', $_XDOFOPOS)}"/>
               </fo:block>
            </fo:flow>
         </fo:page-sequence>
      </fo:root>
   </xsl:template>
</xsl:stylesheet>
';


  g_prn_template_table_cell     varchar2(32767) := g_prn_template_table_cell_fop;
  g_prn_template_header_col     varchar2(32767) := g_prn_template_header_col_fop;
  g_prn_template_body_col       varchar2(32767) := g_prn_template_body_col_fop;
  g_prn_template                varchar2(32767) := g_prn_template_fop;

  -- ----------------------------------------------------------------------------------------
  -- is valid query
  --
  function is_valid_query (
    p_region_id number default null,
    p_plug_source varchar2,
    p_plug_source_type varchar2,
    p_owner varchar2 default null,
    p_required_col_num number default null
  ) return varchar2;

  -- ----------------------------------------------------------------------------------------
  -- upgrade report

  procedure upgrade_report (
    p_region_id number,
    p_user      varchar2
  );

  -- ----------------------------------------------------------------------------------------
  -- get_query_headings

  function get_query_headings (
    p_region_id number,
    p_include_derived varchar2 default 'Y'
  ) return wwv_flow_global.vc_arr2;

  -- ----------------------------------------------------------------------------------------
  -- get_mru_info

  function get_mru_info (
      p_region_id  in varchar2,
      p_type       in varchar2
  ) return varchar2;

  -- ----------------------------------------------------------------------------------------
  -- get since

  function get_since(
      p_date date
  ) return varchar2;

  -- ----------------------------------------------------------------------------------------
  -- highlight value

  function highlight_value (
      p_value            in varchar2,
      p_highlight_string in varchar2,
      p_style            in varchar2 default 'font-weight: bold; color: red;',
      p_tag_open         in boolean default false
    ) return varchar2;

  -- ----------------------------------------------------------------------------------------
  -- set template
  -- sets template definition based on row template id or default setting for non-template
  -- based reports

  procedure set_template(
    p_row_template_id           in     number,
    p_report_attributes_subs    in     varchar2,
    p_column_heading_template   in out varchar2,
    p_row_template              in out row_template_type,
    p_row_templates             in out wwv_flow_global.vc_arr2,
    p_row_template_conditions   in out wwv_flow_global.vc_arr2,
    p_row_template_display_cond in out wwv_flow_global.vc_arr2,
    p_multiple_templates_exist  in out boolean,
    p_show_null_cols            in out boolean,
    p_before_column_heading     in out varchar2,
    p_after_column_heading      in out varchar2
  );

  -- ----------------------------------------------------------------------------------------
  -- build_pagination_row

  function build_pagination_row (
    p_row_template            in row_template_type,
    p_row_count               in number,
    p_row_count_max           in number,
    p_min_row                 in number,
    p_max_rows                in number,
    p_total_row_count         in number,
    p_region_id               in number,
    p_col_cnt                 in number,
    p_row_count_fmt           in varchar2,
    p_row_count_fmt2          in varchar2,
    p_pagination_align        in varchar2,
    p_show_top_pagination     in boolean default false,
    p_more_data_found         in boolean default false,
    p_ajax_enabled            in varchar2 default 'N'
  ) return varchar2;

  -- ----------------------------------------------------------------------------------------
  -- Set legacy col attribyts
  --
  procedure set_legacy_col_attributes (
    p_region_id number,
    p_is_api_call                 boolean default false,
    p_plug_query_headings         varchar2 default null,
    p_plug_query_headings_type    varchar2 default null,
    p_plug_query_col_allignments  varchar2 default null,
    p_plug_query_sum_cols         varchar2 default null,
    p_plug_query_number_formats   varchar2 default null,
    p_plug_query_hit_highlighting varchar2 default null
  );

  -- ----------------------------------------------------------------------------------------
  -- update_report_columns
  --
  procedure update_report_columns (
    p_region_id number
  );


  -- ----------------------------------------------------------------------------------------
  --
  procedure show_preview;


  -- ----------------------------------------------------------------------------------------
  -- show
  --
  --

  procedure show(
    p_query                       in varchar2,
    p_min_row                     in number                    default 1,
    p_max_rows                    in number                    default 200,
    p_row_count_max               in number                    default g_show_total_row_count_max,
    p_plug_query_num_rows_type    in varchar2                  default null,
    p_pagination_display_position in varchar2                  default null,
    p_plug_source_type            in varchar2                  default null,
    p_csv_output                  in varchar2                  default 'N',
    p_print_server                in varchar2                  default null,
    p_csv_output_link_text        in varchar2                  default null,
    p_prn_output                  in varchar2                  default 'N',
    p_prn_output_show_link        in varchar2                  default 'N',
    p_prn_output_link_text        in varchar2                  default null,
    p_prn_document_header         in varchar2                  default null,
    p_prn_format                  in varchar2                  default null,
    p_prn_format_item             in varchar2                  default null,
    p_print_url                   in varchar2                  default null,
    p_print_url_label             in varchar2                  default null,
    p_plug_query_exp_filename     in varchar2                  default null,
    p_plug_query_exp_separator    in varchar2                  default ',',
    p_plug_query_exp_enclosed_by  in varchar2                  default '''',
    p_plug_query_hit_highlighting in varchar2                  default null,
    p_plug_query_headings_type    in varchar2                  default 'QUERY_COLUMNS',
    p_plug_query_headings         in varchar2                  default '(null)',     -- rename
    p_show_nulls_as               in varchar2                  default '(null)',
    p_break_cols                  in wwv_flow_global.vc_arr2   default empty_vc_arr,
    p_sum_cols                    in wwv_flow_global.vc_arr2   default empty_vc_arr,
    p_show_nulls                  in varchar2                  default 'F',
    p_plug_query_options          in varchar2                  default null,
    p_plug_query_strip_html       in varchar2                  default 'Y',
    p_row_template_id             in number                    default null,
    p_repeat_headings             in number                    default null,
    p_more_rows_message           in varchar2                  default null,
    p_no_data_found_message       in varchar2                  default 'No data found...',
    p_region_id                   in number                    default null,
    p_region_name                 in varchar2                  default null,
    p_ajax_enabled                in varchar2                  default 'N',
    p_report_attributes_subs      in varchar2                  default null
    );
end;
/