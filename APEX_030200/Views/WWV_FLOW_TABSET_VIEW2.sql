CREATE OR REPLACE FORCE VIEW wwv_flow_tabset_view2 ("D",r) AS
select d,r from(
    select tab_set ||
           replace(' ('||
           max(decode(seq,1,tab_text,null))||
           max(decode(seq,2,', '||tab_text,null))||
           max(decode(seq,3,', '||tab_text,null))||
           max(decode(seq,4,'...',null))||
           ')','&'||'nbsp;',' ') d,
           tab_set r, 1 ob
    from (
    select tab_set, tab_text, tab_sequence, row_number() over (partition by tab_set order by tab_sequence nulls last) seq
    from wwv_flow_tabs
    where flow_id = (select v('FB_FLOW_ID') from dual) ) x
    group by tab_set
    union
    (select CURRENT_ON_TABSET d,CURRENT_ON_TABSET r, 2 ob
       from wwv_flow_toplevel_tabs
      where flow_id = (select v('FB_FLOW_ID') from dual)
      minus
     select tab_set d,tab_set r,2 ob
       from wwv_flow_tabs
      where flow_id = (select v('FB_FLOW_ID') from dual) )
    )
order by ob;