CREATE OR REPLACE package wwv_flow_image_prefix

--  Copyright (c) Oracle Corporation 1999 - 2007. All Rights Reserved.
--
--    DESCRIPTION
--      Image prefix function.  Will return the image prefix provided at installation time.
--      This function should never need to be updated.  It's sole purpose is to provide
--      the ability to easily update the image prefix used by the APEX globals in wwv_flow_global
--
is
    g_image_prefix       constant varchar2(255) := '/i/';

end;
/