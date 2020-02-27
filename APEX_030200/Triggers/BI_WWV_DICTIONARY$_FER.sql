CREATE OR REPLACE trigger bi_wwv_dictionary$_fer
before insert on wwv_flow_dictionary$
for each row
begin

  if :new.owner is null then
    :new.owner := 'PUBLIC';
  end if;

  if :new.language is null then
    :new.language := 'en-us';
  end if;

  :new.words_capitalized := upper( substr( :new.words, 1, 1 ) ) ||
                            lower( substr( :new.words, 2 ) );

  :new.words_soundex := soundex( :new.words );

    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;

end;
/