CREATE OR REPLACE package oc_michael_c.test_bl_user_registration as
   
 -- %suite(Password tests)
   
  -- %test(validates strong passwords)
  procedure validate_strong_passwords;
  -- %test(validates missing characters)
  procedure validate_missing_characters;
  -- %test(validates boundary cases)
  procedure validate_boundaries;


 -- source: https://apexplained.wordpress.com/2013/07/14/introducing-unit-tests-in-plsql-with-utplsql/
end test_bl_user_registration;
/