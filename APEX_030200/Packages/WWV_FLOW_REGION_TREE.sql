CREATE OR REPLACE package wwv_flow_region_tree as

--  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    DESCRIPTION
--      Display a tree structure
--
--    SECURITY
--
--    NOTES
--      show_tree.p_id   = the globally unique ID of the tree identifies a tree to paint in the wwv_flow_trees table
--

procedure show_tree (
    p_id          in number,
    p_expand_id   in varchar2 default null,
    p_contract_id in varchar2 default null)
    ;

end wwv_flow_region_tree;
/