CREATE OR REPLACE TRIGGER rel_18_a_12c2."BGC_OWNERSHIP_CLLI_COMPOUND" 
  FOR INSERT OR UPDATE ON rel_18_a_12c2.B$GC_OWNERSHIP
 COMPOUND TRIGGER

  BEFORE EACH ROW IS
  BEGIN

    BGC_LOG.ENABLE;
    BGC_LOG.DISABLE;
    
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    if (ltt_admin.getmode in ('LONG', 'SHORT')) then
     BGC_LOG.ENABLE;
    BGC_LOG.DISABLE;
   end if;
  EXCEPTION
    when others then
      BGC_LOG.put_line('BGC_OWNERSHIP_CLLI_COMPOUND','Error ' || sqlerrm ||dbms_utility.format_error_backtrace);
      b$gc_ownership_pkg.v_numentries := 0;
      BGC_LOG.DISABLE;
      raise_application_error(-20000, sqlerrm);
  END AFTER STATEMENT;

END BGC_OWNERSHIP_CLLI_COMPOUND;
/