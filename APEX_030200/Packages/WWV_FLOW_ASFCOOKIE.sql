CREATE OR REPLACE package wwv_flow_asfcookie
as
-- Copyright (c) Oracle Corporation 2000. All Rights Reserved.
--
--    DESCRIPTION
--      Read information from ASFCOOKIE, used only by Oracle Applications.
--
--    SECURITY
--
--    NOTES
--
--    INTERNATIONALIZATION
--      unknown
--
--    MULTI-CUSTOMER
--      unknown
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--    RUNTIME DEPLOYMENT: YES
--
--    MODIFIED (MM/DD/YYYY)
--      mhichwa  01/20/2000 - Created
--      mhichwa  12/15/2000 - Baseline 1
--      jstraub  07/25/2003 - Replaced error messages and htp.p English text with system_message (Bug 3059228)
--
--

  G_UserName        VARCHAR2(100);
  G_PersonId        NUMBER;
  G_CurrRespId      NUMBER;
  G_FullName        VARCHAR2(240);
  G_LangCode        VARCHAR2(4);
  G_UserId          NUMBER;
  G_SalesForceId    NUMBER;
  G_SalesGroupId    NUMBER;
  G_CurrAppId       NUMBER;
  G_SecGroupId      NUMBER;

  procedure validate_session;

end wwv_flow_asfcookie;
/