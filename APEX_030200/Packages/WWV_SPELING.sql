CREATE OR REPLACE package wwv_speling as

  --
  --  Spell Check Types
  --

  SELECT_LIST constant number := 0;
  POPUP constant number := 1;
  HIGHLIGHT constant number := 2;


  --
  -- Package Types
  --

  --type vc_arr is table of varchar2(4000);
  empty_vc_arr wwv_flow_global.vc_arr2;

  procedure init_page(
    p_header_proc varchar2 default null,
    p_footer_proc varchar2 default null,
    p_window_height number default 500,
    p_window_width number default 600 );

  procedure init_field_with_image(
    p_field_name varchar2,
    p_image_name varchar2,
    p_alt_text varchar2,
    p_image_attributes varchar2,
    p_search_type number default SELECT_LIST,
    p_sgid    in varchar2,
    p_user    in varchar2,
    p_flow_id in varchar2,
    p_lang    in varchar2 );

  --
  --
  --

  procedure correction_window(
    p_sgid    in varchar2,
    p_user    in varchar2,
    p_lang    in varchar2,
    p_flow_id in varchar2 );

  procedure pre_correction_frame(
    p_sgid    in varchar2,
    p_user    in varchar2,
    p_lang    in varchar2,
    p_flow_id in varchar2 );

  procedure hidden_frame(
    p_word varchar2 default null,
    p_sgid    in varchar2,
    p_user    in varchar2,
    p_lang    in varchar2,
    p_flow_id in varchar2 );

  procedure correction_frame(
    p_text varchar2,
    p_field_name varchar2,
    p_header_proc varchar2 default null,
    p_footer_proc varchar2 default null,
    p_search_type number default SELECT_LIST,
    p_sgid    in varchar2,
    p_user    in varchar2,
    p_lang    in varchar2,
    p_flow_id in varchar2 );

  procedure small_correction_window(
    p_text varchar2,
    p_field_name varchar2,
    p_sgid    in varchar2,
    p_user    in varchar2,
    p_lang    in varchar2,
    p_flow_id in varchar2);

  procedure accept_corrections(
    p_text varchar2,
    p_field_name varchar2,
    p_words wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_lens wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_idxs wwv_flow_global.vc_arr2 default empty_vc_arr );


end wwv_speling;
/