CREATE OR REPLACE type wwv_flow_tree_entry as object
( seq      number,
  lev      number,
  id       varchar2(4000),
  pid      varchar2(4000),
  kids     number,
  expand   varchar2(1),
  indent   varchar2(4000),
  name     varchar2(4000),
  link     varchar2(4000),
  a1       varchar2(4000),
  a2       varchar2(4000) )
/