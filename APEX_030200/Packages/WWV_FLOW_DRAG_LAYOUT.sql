CREATE OR REPLACE PACKAGE wwv_flow_drag_layout AS

procedure show_layout_region (
  p_page	 in number,
  p_flow	 in number,
  p_session	 in number,
  p_region	 in number,
  p_items_id     in varchar,
  p_items_delete in varchar,
  p_request      in varchar
);

END wwv_flow_drag_layout;
/