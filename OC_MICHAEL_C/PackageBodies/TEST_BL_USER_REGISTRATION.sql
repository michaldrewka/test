CREATE OR REPLACE package body oc_michael_c.test_bl_user_registration as
    
    procedure validate_strong_passwords as
    begin
        ut.expect(bl_user_registration.validate_password_strength('ABCdef123#'), 'ABCdef123# is a strong password').to_(equal(true));
        ut.expect(bl_user_registration.validate_password_strength('%a1B2CD'), '%a1B2CD is a strong password').to_(equal(true));
        ut.expect(bl_user_registration.validate_password_strength('%a1B2CD'), '%a1B2CD is a stronger password').to_(equal(true));
    end validate_strong_passwords;


    procedure validate_missing_characters as
    begin
        ut.expect(bl_user_registration.validate_password_strength('Abcdef#'), 'Abcdef# misses a digit character').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('ABCD1234$'), 'ABCD1234$ misses a lowercase character').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('abcd1234@'), 'abcd1234@ misses an uppercase character').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('ABcd1234'), 'ABcd1234 misses a special character').to_(equal(false));
    end validate_missing_characters;


    procedure validate_boundaries as
    begin
        ut.expect(bl_user_registration.validate_password_strength('Abc1%'), 'Abc1% is too short').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength('Abcdefghijk123456789@'), 'Abcdefghijk123456789@ is too long').to_(equal(false));
        ut.expect(bl_user_registration.validate_password_strength(''), 'An empty string should return false').to_(equal(false));

    end validate_boundaries;


end test_bl_user_registration;
/