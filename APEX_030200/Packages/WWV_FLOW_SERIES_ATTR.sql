CREATE OR REPLACE package wwv_flow_series_attr
is

g_attribute_value wwv_flow_global.vc_arr2;


function fetch_attribute (
   p_region_id     in number,
   p_series_id     in number,
   p_attribute_id  in number)
   return varchar2
   ;

function fetch_attribute_in_array (
   p_region_id     in number,
   p_attribute_id  in number)
   return wwv_flow_global.vc_arr2
   ;

procedure fetch_attributes (
   p_region_id     in number,
   p_series_id     in number,
   p_value_count   in number default 50)
   ;

procedure set_attribute (
    p_region_id     in number,
    p_series_id     in number,
    p_attribute_id  in number,
    p_value         in varchar2 default null)
    ;

procedure set_attributes (
    p_region_id     in number,
    p_series_id     in number default null,
    p_a001          in varchar2 default null,
    p_a002          in varchar2 default null,
    p_a003          in varchar2 default null,
    p_a004          in varchar2 default null,
    p_a005          in varchar2 default null,
    p_a006          in varchar2 default null,
    p_a007          in varchar2 default null,
    p_a008          in varchar2 default null,
    p_a009          in varchar2 default null,
    p_a010          in varchar2 default null,
    p_a011          in varchar2 default null,
    p_a012          in varchar2 default null,
    p_a013          in varchar2 default null,
    p_a014          in varchar2 default null,
    p_a015          in varchar2 default null,
    p_a016          in varchar2 default null,
    p_a017          in varchar2 default null,
    p_a018          in varchar2 default null,
    p_a019          in varchar2 default null,
    p_a020          in varchar2 default null,
    p_a021          in varchar2 default null,
    p_a022          in varchar2 default null,
    p_a023          in varchar2 default null,
    p_a024          in varchar2 default null,
    p_a025          in varchar2 default null,
    p_a026          in varchar2 default null,
    p_a027          in varchar2 default null,
    p_a028          in varchar2 default null,
    p_a029          in varchar2 default null,
    p_a030          in varchar2 default null,
    p_a031          in varchar2 default null,
    p_a032          in varchar2 default null,
    p_a033          in varchar2 default null,
    p_a034          in varchar2 default null,
    p_a035          in varchar2 default null,
    p_a036          in varchar2 default null,
    p_a037          in varchar2 default null,
    p_a038          in varchar2 default null,
    p_a039          in varchar2 default null,
    p_a040          in varchar2 default null,
    p_a041          in varchar2 default null,
    p_a042          in varchar2 default null,
    p_a043          in varchar2 default null,
    p_a044          in varchar2 default null,
    p_a045          in varchar2 default null,
    p_a046          in varchar2 default null,
    p_a047          in varchar2 default null,
    p_a048          in varchar2 default null,
    p_a049          in varchar2 default null,
    p_a050          in varchar2 default null,
    p_value_count   in number   default 50)
    ;

procedure delete_attributes (
    p_region_id     in number,
    p_series_id     in number default null)
    ;
end wwv_flow_series_attr;
/