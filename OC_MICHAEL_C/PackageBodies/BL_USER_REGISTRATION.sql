CREATE OR REPLACE package body oc_michael_c.bl_user_registration as
 
  function validate_password_strength(in_password in varchar2)
  return boolean is
  begin
    if not regexp_like(in_password, '[[:digit:]]') then
      return false;
    end if;

    if not regexp_like(in_password, '[[:lower:]]') then
      return false;
    end if;

    if not regexp_like(in_password, '[[:upper:]]') then
      return false;
    end if;

    if not regexp_like(in_password, '[@#$%]') then
      return false;
    end if;

    if length(in_password) not between 6 and 20 then
      return false;
    end if;

    return true;
  end validate_password_strength;

end bl_user_registration;
/