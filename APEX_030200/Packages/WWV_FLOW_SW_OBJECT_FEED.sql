CREATE OR REPLACE package wwv_flow_sw_object_feed as

--    Copyright (c) Oracle Corporation 2001 - 2005. All Rights Reserved.
--
--    DESCRIPTION
--      This package facilitates specifc functionality for the database object xml feeds.
--
--    SECURITY
--
--    NOTES
--
--    RUNTIME DEPLOYMENT: YES
--

  procedure getmoreObjects(
    --
    -- Prints a list of database objects. This list can be DIV, XML based or user entered tag type
    --  This should be called using the Application Process on Demand
    --
    -- Arguments:
    --    p_type    = The database object type that will be returned in the list
    --                e.g. TABLE VIEW TRIGGER ....
    --
    --    p_owner   = The Scheme to query agianst for the list of database objects
    --
    --    p_start   = An optional start integer so that a large list of objects can
    --                be subdivided for pagination or cascading load
    --
    --    p_stop    = An optional stop integer so that a large list of objects can
    --                be subdivided for pagination or cascading load
    --
    --    p_display  = picks output type either 'DIV' for html based applications or 'XML' for an XML feed,
    --
    --    p_session  = HTML Session ID,
    --
    --    p_include  = A place holder to add misc xml attributes to every object subelement as an xml attributes
    --
    --    p_onclick  = A class attribute applied to every object subelement as an xml attributes
    --
    --    p_class    = A class attribute applied to every object subelement as an xml attributes

    --
    -- example(s):
    --  wwv_flow_sw_object_feed.getmoreObjects(
    --    p_type    =>  'TABLE',
    --    p_owner   =>  'FLOWS_020000'
    --    );
    --
               p_type     in  varchar2 default  'TABLE',
               p_owner    in  varchar2 default  null,
               p_start    in  varchar2 default  1,
               p_stop     in  varchar2 default  200,
               p_display  in  varchar2 default  'DIV',
               p_session  in  number   default  null,
               p_include  in  varchar2 default  null,
               p_onclick  in  varchar2 default  null,
               p_class    in  varchar2 default  'dbaseObject'
               );

end wwv_flow_sw_object_feed;
/