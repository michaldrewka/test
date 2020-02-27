CREATE OR REPLACE package wwv_flow_tree
as

--  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    DESCRIPTION
--      Tree control
--
--    SECURITY
--      Private to flows
--
--    NOTES
--
--    RUNTIME DEPLOYMENT: YES
--

  procedure build(
    p_tree_id                  in number,
    p_query                    in varchar2,
    p_top_id                   in varchar2,
    p_max_level                in integer default 5,
    p_order_by                 in varchar2 default null,
    p_unexpanded_parent        in varchar2 default '|+-',
    p_unexpanded_parent_last   in varchar2 default '`+-',
    p_expanded_parent          in varchar2 default '|=-',
    p_expanded_parent_last     in varchar2 default '`=-',
    p_leaf_node                in varchar2 default '|--',
    p_leaf_node_last           in varchar2 default '`--',
    p_indent_vertical_line     in varchar2 default '|  ',
    p_indent_space             in varchar2 default '   ');

  procedure expand(
    p_tree_id     in number,
    p_id          in varchar2);

  procedure contract(
    p_tree_id       in number,
    p_id            in varchar2);

  procedure reset(
    p_tree_id  in number);
end wwv_flow_tree;
/