CREATE OR REPLACE package body oc_michael_c.test_betwnstr as

  procedure basic_usage is
  begin
    ut.expect( betwnstr( '1234567', 2, 5 ) ).to_equal('2345');
  end;

  procedure zero_start_position is
  begin
    ut.expect( betwnstr( '1234567', 0, 5 ) ).to_equal('12345');
  end;
  
   PROCEDURE ut_betwn IS
   BEGIN
    ut.expect(betwnstr ('this is a string', 3, 7), 'Typical Valid Usage').to_equal('is is');
    ut.expect(betwnstr ('this is a string', -3, 7), 'Test Negative Start').to_equal('ing');
    ut.expect(betwnstr ('this is a string', 3, 1), 'Start Bigger than End').to_be_null();
   END;
end;
/