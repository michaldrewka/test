CREATE OR REPLACE package wwv_flow_tree_global_vars
as
  g_subs          wwv_flow_tree_subs;
  g_max_level     number;
  g_error         varchar2(32767);
  g_expand_all    boolean := false;
  g_contract_all  boolean := false;
end wwv_flow_tree_global_vars;
/