CREATE OR REPLACE package wwv_flow_dataload_xml as

--  Copyright (c) Oracle Corporation 1999 - 2006. All Rights Reserved.
--
--    DESCRIPTION
--      XML Utility routines for the data loader.
--
--    NOTE
--      This package will ONLY compile in 9i due to reference to dbms_xmlgen pkg.
--
--    NOTES
--      This package has various procedures and functions for
--      accepting xml datagrams for loading into tables, and for
--      exporting xml datagrams from sql queries.
--

  empty_vc_arr wwv_flow_global.vc_arr2;

/*
 * Designed to take XML, transform it w/ XSLT using p_xsl, and load
 *  the resulting datagram into a table.
 */
procedure load_table(
    p_xml             in clob,
    p_xsl             in varchar2 default NULL)
    ;



----------------------------------------------------------------------------
-- E X P O R T   R O U T I N E S
--
/*
 * Query the database using p_sql, and format an xml document using
 *  the remaining parameters.
 *
 * p_stylesheet is deprecated and not used
 *
 */
function getQueryXml(
    p_sql             in varchar2,
    p_rowsettag       in varchar2 default 'ROWSET',
    p_rowtag          in varchar2 default 'ROW',
    p_skiprows        in number   default 0,
    p_maxrows         in number   default NULL,
    p_stylesheet      in varchar2 default NULL)
    return clob
    ;

procedure getQueryXmlPage(
    p_schema          in varchar2,
    p_table           in varchar2,
    p_columns         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_skiprows        in number   default 0,
    p_maxrows         in number   default NULL,
    p_where           in varchar2 default null)
    ;


end wwv_flow_dataload_xml;
/