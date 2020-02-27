CREATE OR REPLACE function escape_sc( ctext in varchar2 ) return varchar2
is
/*
    AMP  CONSTANT varchar2(10) := '&' || 'amp;';
    QUOT CONSTANT varchar2(10) := '&' || 'quot;';
    LT   CONSTANT varchar2(10) := '&' || 'lt;';
    GT   CONSTANT varchar2(10) := '&' || 'gt;';
*/
begin
   return sys.htf.escape_sc( ctext => ctext );
/*
   return(
   replace(
   replace(
   replace(
   replace(
   replace(
   replace(ctext,'&#','HasH_h0ld3r'),
   '&', AMP),
   '"', QUOT),
   '<', LT),
   '>', GT),
   'HasH_h0ld3r','&#'));
*/
end;
/