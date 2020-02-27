CREATE OR REPLACE package body wwv_flow_asfcookie
as

Procedure validate_session IS

    l_owacookie owa_cookie.cookie;
    l_x           NUMBER;
    l_y           NUMBER;
    l_length      NUMBER;
    l_key         VARCHAR2(80);
    l_value       VARCHAR2(240);
    l_upper_key   VARCHAR2(80);
    l_cookie_str  varchar2(4000);
    l_separator   varchar2(30) := '|';

    e_session_invalid	exception;
    e_sec_group_missing	exception;

    l_profile_defined	boolean;
    l_org_id		VARCHAR2(50);
    l_multi_org_flag	VARCHAR2(1);

begin
    -----------------------------------------------------------
    -- Read Cookie
    --
    l_owacookie := owa_cookie.get('asfcookie');

    -- Raise exception if no asfcookie is found
    IF (l_owacookie.num_vals <= 0) THEN
	RAISE E_SESSION_INVALID;
    END IF;

    -------------------------------------------------------------------------------
    -- Parse Cookie to find user_name and user_id which is also wwv_flow.g_instance
    --
    l_cookie_str := wwv_flow_utilities.url_decode2(l_owacookie.vals(l_owacookie.num_vals));

    if (l_cookie_str IS NULL) then
        raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_asfcookie.invalid_cookie_err'));
    end if;

    l_x   := 1;
    l_y   := instr(l_cookie_str, l_separator, l_x);
    l_length := length(l_cookie_str);

    while (l_y >= 0 AND l_x < l_length) LOOP
      l_key := substr(l_cookie_str, l_x, l_y-l_x);
      l_x := l_y + 1;
      IF (l_x >= l_length) THEN
        l_value := '';
      ELSE
        l_y := instr(l_cookie_str, l_separator, l_x);

        IF (l_y > 0) THEN
          l_value := substr(l_cookie_str, l_x, l_y-l_x);
          l_x := l_y + 1;
          l_y := instr(l_cookie_str, l_separator, l_x);
        ELSE
          l_value := substr(l_cookie_str, l_x);
        END IF;

        l_upper_key := UPPER(l_key);
        IF (l_upper_key = 'USER_NAME') THEN
          wwv_flow.g_user := upper(l_value);
	    G_UserName := l_value;
        ELSIF (l_upper_key = 'PERSONID') THEN
	    G_PersonId	:= l_value;
        ELSIF (l_upper_key = 'CURRRESPID') THEN
          G_currRespId := l_value;
        ELSIF (l_upper_key = 'FULLNAME') THEN
          wwv_flow.g_user_known_as := l_value;
	    G_FullName := l_value;
        ELSIF (l_upper_key = 'LANGCODE') THEN
	    G_LangCode := l_value;
        ELSIF (l_upper_key = 'USERID') THEN
          wwv_flow.g_instance := l_value;
	    G_UserId := l_value;
        ELSIF (l_upper_key = 'SALESFORCEID') THEN
          G_SalesForceId := l_value;
        ELSIF (l_upper_key = 'SALESGROUPID') THEN
          G_SalesGroupId := l_value;
        ELSIF (l_upper_key = 'CURRAPPID') THEN
          G_currAppId := l_value;
        ELSIF (l_upper_key = 'SECURITYGROUPID') THEN
          G_secGroupId := l_value;
        END IF;
      END IF;
    END LOOP;

    if (wwv_flow.g_instance IS NULL) then
        raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_asfcookie.unable_fnd_userid_err',l_upper_Key));
    end if;

    /*
    htp.br;
    htp.p('ASFCOOKIE INFO: user:'||wwv_flow.g_user);
    htp.p('session:'||wwv_flow.g_instance);
    htp.p('knownas:'||wwv_flow.g_user_known_as);
    */

EXCEPTION
  --  Re-direct to sign-on page
  WHEN E_SESSION_INVALID THEN
    htp.p(wwv_flow_lang.system_message('wwv_flow_asfcookie.exception')||' E_SESSION_INVALID: '||sqlerrm);
    --owa_util.redirect_url(fnd_profile.value('ASY_APPLICATION_URL'));

  WHEN E_SEC_GROUP_MISSING THEN
    htp.p(wwv_flow_lang.system_message('wwv_flow_asfcookie.exception')||' E_SEC_GROUP_MISSING: '||sqlerrm);
    --owa_util.redirect_url(fnd_profile.value('ASY_APPLICATION_URL'));

  WHEN OTHERS THEN
    htp.p(wwv_flow_lang.system_message('wwv_flow_asfcookie.error',sqlerrm));
    --owa_util.redirect_url(fnd_profile.value('ASY_APPLICATION_URL'));

end validate_session;

end wwv_flow_asfcookie;
/