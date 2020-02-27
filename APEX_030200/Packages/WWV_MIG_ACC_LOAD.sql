CREATE OR REPLACE package wwv_mig_acc_load  is

--  Copyright (c) Oracle Corporation 1999 - 2004. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package contains the basic procedures for all migration
--      related tables.  This package also holds the global variable
--      project_id as g_project_id, fileid as g_fileid and the dbid as g_dbid.
--
--    NOTES
--     To run this, you must log in as FLOW schema owner.
--
--    SECURITY
--      No grants, need to be run as FLOW schema owner.
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
--
--
-------------------------------------------------------------------------------
--GLOBAL VARIABLE DECLARATIONS
--
g_projectid         number := 0;
g_dbid              number := 0;
g_linkdbid          number := 0;
g_fileid            number := 0;
--
--
--
--
-------------------------------------------------------------------------------

-- create function to replace escape characters in strings of export file

   function escape_char (ctext in varchar2)
   return varchar2;


-- create function to replace escape characters in strings of export file

   function escape_char (ctext in clob)
   return clob;


-- create procedure for table  wwv_mig_access
   procedure  ins_wwv_mig_access  (
       p_dbid                  in number,
       p_dbname                in varchar2  default null,
       p_dbsize                in varchar2  default null,
       p_dbpathname            in varchar2  default null,
       p_dbuser                in varchar2  default null,
       p_dbpassword            in varchar2  default null,
       p_isappdb               in number    default null,
       p_isattacheddb          in number    default null,
       p_convertdb             in number    default null,
       p_jetversion            in float     default null,
       p_accessversion         in varchar2  default null,
       p_build                 in number    default null,
       p_collatingorder        in number    default null,
       p_querytimeout          in number    default null,
       p_startupform           in varchar2  default null,
       p_startupshowstatusbar  in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_columns
   procedure  ins_wwv_mig_acc_columns  (
       p_colid              in number,
       p_tblid              in number,
       p_dbid               in number    default null,
       p_colname            in varchar2  default null,
       p_coltype            in number    default null,
       p_coltypedesc        in varchar2  default null,
       p_colautoincr        in number    default null,
       p_nextcountervalue   in number    default null,
       p_maxlengthsource    in number    default null,
       p_avglengthsource    in number    default null,
       p_coltextsize        in number    default null,
       p_allowzerolength    in number    default null,
       p_defaultvalue       in varchar2  default null,
       p_colrequired        in number    default null,
       p_colcollatingorder  in number    default null,
       p_colordposition     in number    default null,
       p_validationrule     in varchar2  default null,
       p_validationtext     in varchar2  default null,
       p_columndescription  in varchar2  default null,
       p_columnhidden       in number    default null,
       p_columnorder        in number    default null,
       p_columnwidth        in number    default null,
       p_decimalplaces      in number    default null,
       p_foreignname        in varchar2  default null,
       p_validateonset      in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_forms
   procedure  ins_wwv_mig_acc_forms  (
       p_dbid                        in number,
       p_formid                      in number,
       p_formname                    in varchar2  default null,
       p_afterdelconfirm             in varchar2  default null,
       p_afterinsert                 in varchar2  default null,
       p_afterupdate                 in varchar2  default null,
       p_allowadditions              in number    default null,
       p_allowdeletions              in number    default null,
       p_allowedits                  in number    default null,
       p_allowediting                in number    default null,
       p_allowfilters                in number    default null,
       p_allowupdating               in number    default null,
       p_autocenter                  in number    default null,
       p_autoresize                  in number    default null,
       p_backcolor                   in number    default null,
       p_beforedelconfirm            in varchar2  default null,
       p_beforeinsert                in varchar2  default null,
       p_beforeupdate                in varchar2  default null,
       p_borderstyle                 in number    default null,
       p_formcaption                 in varchar2  default null,
       p_closebutton                 in number    default null,
       p_controlbox                  in number    default null,
       p_count                       in number    default null,
       p_currentview                 in number    default null,
       p_cycle                       in number    default null,
       p_dataentry                   in number    default null,
       p_datasheetbackcolor          in number    default null,
       p_datasheetcellseffect        in number    default null,
       p_datasheetfontheight         in number    default null,
       p_datasheetfontitalic         in number    default null,
       p_datasheetfontname           in varchar2  default null,
       p_datasheetfontunderline      in number    default null,
       p_datasheetfontweight         in number    default null,
       p_datasheetforecolor          in number    default null,
       p_datasheetgridlinesbehavior  in number    default null,
       p_datasheetgridlinescolor     in number    default null,
       p_defaultediting              in number    default null,
       p_defaultview                 in number    default null,
       p_dividinglines               in number    default null,
       p_fastlaserprinting           in number    default null,
       p_filter                      in varchar2  default null,
       p_filteron                    in number    default null,
       p_frozencolumns               in number    default null,
       p_gridx                       in number    default null,
       p_gridy                       in number    default null,
       p_hasmodule                   in number    default null,
       p_helpcontextid               in number    default null,
       p_helpfile                    in varchar2  default null,
       p_hwnd                        in number    default null,
       p_insideheight                in number    default null,
       p_insidewidth                 in number    default null,
       p_keypreview                  in number    default null,
       p_layoutforprint              in number    default null,
       p_logicalpagewidth            in number    default null,
       p_maxbutton                   in number    default null,
       p_menubar                     in varchar2  default null,
       p_minbutton                   in number    default null,
       p_minmaxbuttons               in number    default null,
       p_modal                       in number    default null,
       p_navigationbuttons           in number    default null,
       p_onactivate                  in varchar2  default null,
       p_onapplyfilter               in varchar2  default null,
       p_onclick                     in varchar2  default null,
       p_onclose                     in varchar2  default null,
       p_oncurrent                   in varchar2  default null,
       p_ondblclick                  in varchar2  default null,
       p_ondeactivate                in varchar2  default null,
       p_ondelete                    in varchar2  default null,
       p_onerror                     in varchar2  default null,
       p_onfilter                    in varchar2  default null,
       p_ongotfocus                  in varchar2  default null,
       p_onkeydown                   in varchar2  default null,
       p_onkeypress                  in varchar2  default null,
       p_onkeyup                     in varchar2  default null,
       p_onload                      in varchar2  default null,
       p_onlostfocus                 in varchar2  default null,
       p_onmousedown                 in varchar2  default null,
       p_onmousemove                 in varchar2  default null,
       p_onmouseup                   in varchar2  default null,
       p_onopen                      in varchar2  default null,
       p_onresize                    in varchar2  default null,
       p_ontimer                     in varchar2  default null,
       p_onunload                    in varchar2  default null,
       p_openargs                    in varchar2  default null,
       p_orderby                     in varchar2  default null,
       p_orderbyon                   in number    default null,
       p_painting                    in number    default null,
       p_palettesource               in varchar2  default null,
       p_picture                     in varchar2  default null,
       p_picturealignment            in number    default null,
       p_picturesizemode             in number    default null,
       p_picturetiling               in number    default null,
       p_picturetype                 in number    default null,
       p_popup                       in number    default null,
       p_recordlocks                 in number    default null,
       p_recordselectors             in number    default null,
       p_recordsettype               in number    default null,
       p_recordsource                in varchar2  default null,
       p_rowheight                   in number    default null,
       p_scrollbars                  in number    default null,
       p_shortcutmenu                in number    default null,
       p_shortcutmenubar             in varchar2  default null,
       p_showgrid                    in number    default null,
       p_tag                         in varchar2  default null,
       p_timerinterval               in number    default null,
       p_toolbar                     in varchar2  default null,
       p_viewsallowed                in number    default null,
       p_visible                     in number    default null,
       p_whatsthisbutton             in number    default null,
       p_width                       in number    default null,
       p_windowheight                in number    default null,
       p_windowwidth                 in number    default null
   );

-----
-- create procedure for table  wwv_mig_acc_forms_controls
   procedure  ins_wwv_mig_acc_forms_controls  (
       p_dbid               in number,
       p_formid             in number,
       p_controlid          in number,
       p_controlname        in varchar2  default null,
       p_controltype        in number    default null,
       p_eventprocprefix    in varchar2  default null,
       p_inselection        in number    default null,
       p_left               in number  default null,
       p_parent             in varchar2  default null,
       p_section            in number    default null,
       p_tag                in varchar2  default null,
       p_top                in number    default null,
       p_visible            in number    default null,
       p_backcolor          in number    default null,
       p_backstyle          in number    default null,
       p_boundcolumn        in number    default null,
       p_ctrlcaption        in varchar2  default null,
       p_columncount        in number    default null,
       p_columnheads        in varchar2  default null,
       p_columnwidths       in varchar2    default null,
       p_controlsource      in varchar2  default null,
       p_controltiptext     in varchar2  default null,
       p_defaultvalue       in varchar2  default null,
       p_displaywhen        in number    default null,
       p_enabled            in number    default null,
       p_fontbold           in number    default null,
       p_fontitalic         in number    default null,
       p_fontname           in varchar2  default null,
       p_fontsize           in number    default null,
       p_fontunderline      in number    default null,
       p_fontwheight        in number    default null,
       p_forecolor          in number    default null,
       p_format             in varchar2  default null,
       p_height             in number    default null,
       p_helpcontextid      in number    default null,
       p_limittolist        in number    default null,
       p_linkchildfields    in varchar2  default null,
       p_linkmasterfields   in varchar2  default null,
       p_listrows           in number    default null,
       p_multirow           in number    default null,
       p_onchange           in varchar2  default null,
       p_onclick            in varchar2  default null,
       p_ondblclick         in varchar2  default null,
       p_onkeydown          in varchar2  default null,
       p_onkeypress         in varchar2  default null,
       p_onkeyup            in varchar2  default null,
       p_onmousedown        in varchar2  default null,
       p_onmousemove        in varchar2  default null,
       p_onmouseup          in varchar2  default null,
       p_optionvalue        in number    default null,
       p_pageindex          in number    default null,
       p_picture            in varchar2  default null,
       p_picturealignment   in number    default null,
       p_pictureresizemode  in number    default null,
       p_picturetiling      in number    default null,
       p_picturetype        in number    default null,
       p_rowsource          in varchar2  default null,
       p_rowsourcetype      in varchar2  default null,
       p_shortcutmenubar    in varchar2  default null,
       p_sourceobject       in varchar2  default null,
       p_statusbartext      in varchar2  default null,
       p_style              in number    default null,
       p_tabfixedheight     in number    default null,
       p_tabfixedwidth      in number    default null,
       p_tabindex           in number    default null,
       p_tabstop            in number    default null,
       p_textalign          in number    default null,
       p_textfontcharset    in number    default null,
       p_width              in number    default null
   );

-----
-- create procedure for table  wwv_mig_acc_forms_modules
   procedure  ins_wwv_mig_acc_forms_modules  (
       p_dbid                     in number,
       p_moduleid                 in number,
       p_formid                   in number,
       p_modulename               in varchar2  default null,
       p_countofdeclarationlines  in number    default null,
       p_countoflines             in number    default null,
       p_lines                    in clob      default null,
       p_moduletype               in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_forms_perm
   procedure  ins_wwv_mig_acc_forms_perm  (
       p_dbid               in number,
       p_formid             in number,
       p_userid             in number    default null,
       p_permissionid       in number,
       p_permission         in number  default null,
       p_permission_desc    in varchar2
   );



-----
-- create procedure for table  wwv_mig_acc_groups
   procedure  ins_wwv_mig_acc_groups  (
       p_groupid            in number,
       p_grpname            in varchar2  default null,
       p_dbid               in number
   );


-- create procedure for table  wwv_mig_acc_indexes
   procedure  ins_wwv_mig_acc_indexes  (
       p_indid              in number,
       p_tblid              in number,
       p_dbid               in number    default null,
       p_indname            in varchar2  default null,
       p_cnvindex           in number    default null,
       p_isprimary          in number    default null,
       p_isunique           in number    default null,
       p_isforeign          in number    default null,
       p_ignorenulls        in number    default null,
       p_isrequired         in number    default null,
       p_distinctcount      in number    default null,
       p_isclustered        in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_indexes_cols
   procedure  ins_wwv_mig_acc_idx_cols  (
       p_indcolid           in number,
       p_indid              in number,
       p_colid              in number    default null,
       p_dbid               in number    default null,
       p_colorder           in number    default null,
       p_tblid              in number    default null,
       p_colname            in varchar2  default null
   );


-----
-- create procedure for table  wwv_mig_acc_modules
   procedure  ins_wwv_mig_acc_modules  (
       p_dbid                     in number,
       p_moduleid                 in number,
       p_modulename               in varchar2  default null,
       p_countofdeclarationlines  in number    default null,
       p_countoflines             in number    default null,
       p_lines                    in clob      default null,
       p_moduletype               in number
   );


-----
-- create procedure for table wwv_mig_acc_modules_perm
   procedure  ins_wwv_mig_acc_mdl_perm  (
       p_dbid               in number,
       p_moduleid           in number,
       p_userid             in number    default null,
       p_permissionid       in number,
       p_permission         in number  default null,
       p_permission_desc    in varchar2
   );


-- create procedure for table  wwv_mig_acc_pages
   procedure  ins_wwv_mig_acc_pages  (
       p_dbid               in number,
       p_pageid             in number,
       p_pagename           in varchar2  default null,
       p_datecreated        in varchar2  default null,
       p_datemodified       in varchar2  default null,
       p_pagetype           in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_queries
   procedure  ins_wwv_mig_acc_queries  (
       p_dbid               in number,
       p_qryid              in number,
       p_qrytype            in varchar2  default null,
       p_qryname            in varchar2  default null,
       p_qrysql             in clob      default null,
       p_datecreated        in varchar2  default null,
       p_query_lastupdated  in varchar2  default null,
       p_maxrecords         in number    default null,
       p_odbctimeout        in number    default null,
       p_returnsrecords     in varchar2  default null,
       p_updatable          in varchar2  default null,
       p_date_created       in varchar2  default null,
       p_date_modified      in varchar2  default null
   );


-----
-- create procedure for table wwv_mig_acc_relations
   procedure  ins_wwv_mig_acc_relations  (
       p_dbid               in number,
       p_relid              in number,
       p_relname            in varchar2  default null,
       p_parenttblid        in number    default null,
       p_childtblid         in number    default null,
       p_isunique           in number    default null,
       p_isenforced         in number    default null,
       p_isinherited        in number    default null,
       p_isupdatecascade    in number    default null,
       p_isdeletecascade    in number    default null,
       p_cnvrelation        in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_relation_cols
   procedure  ins_wwv_mig_acc_rel_col  (
       p_dbid               in number    default null,
       p_relcolid           in number,
       p_relid              in number,
       p_parentcolid        in number    default null,
       p_childcolid         in number    default null,
       p_relcolname         in varchar2    default null
   );


-----
-- create procedure for table  wwv_mig_acc_reports
   procedure  ins_wwv_mig_acc_reports  (
       p_dbid               in number,
       p_reportid           in number,
       p_repname            in varchar2  default null,
       p_backcolor          in number    default null,
       p_repcaption         in varchar2  default null,
       p_count              in number    default null,
       p_dategrouping       in number    default null,
       p_fastlaserprinting  in number    default null,
       p_filter             in varchar2  default null,
       p_filteron           in number    default null,
       p_gridx              in number    default null,
       p_gridy              in number    default null,
       p_grpkeeptogether    in number    default null,
       p_hasmodule          in number    default null,
       p_helpcontextid      in number    default null,
       p_helpfile           in varchar2  default null,
       p_hwnd               in number    default null,
       p_layoutforprint     in number    default null,
       p_logicalpagewidth   in number    default null,
       p_maxbutton          in number    default null,
       p_menubar            in varchar2  default null,
       p_minbutton          in number    default null,
       p_onactivate         in varchar2  default null,
       p_onclose            in varchar2  default null,
       p_ondeactivate       in varchar2  default null,
       p_onerror            in varchar2  default null,
       p_onnodata           in varchar2  default null,
       p_onopen             in varchar2  default null,
       p_onpage             in varchar2  default null,
       p_orderby            in varchar2  default null,
       p_orderbyon          in varchar2    default null,
       p_pagefooter         in number    default null,
       p_pageheader         in number    default null,
       p_painting           in number    default null,
       p_palettesource      in varchar2  default null,
       p_picture            in varchar2  default null,
       p_picturealignment   in number    default null,
       p_picturesizemode    in number    default null,
       p_picturetiling      in number    default null,
       p_picturetype        in number    default null,
       p_recordlocks        in number    default null,
       p_recordsource       in varchar2  default null,
       p_shortcutmenubar    in varchar2  default null,
       p_tag                in varchar2  default null,
       p_toolbar            in varchar2  default null,
       p_visible            in number    default null,
       p_width              in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_rpts_controls
   procedure  ins_wwv_mig_acc_rpt_ctl  (
       p_dbid                  in number,
       p_reportid              in number,
       p_controlid             in number,
       p_controlname           in varchar2  default null,
       p_controltype           in number    default null,
       p_eventprocprefix       in varchar2  default null,
       p_inselection           in number    default null,
       p_left                  in number    default null,
       p_parent                in varchar2  default null,
       p_section               in number    default null,
       p_tag                   in varchar2  default null,
       p_top                   in number    default null,
       p_visible               in number    default null,
       p_backcolor             in number    default null,
       p_backstyle             in number    default null,
       p_boundcolumn           in number    default null,
       p_ctrlcaption           in varchar2  default null,
       p_columncount           in number    default null,
       p_columnheads           in varchar2  default null,
       p_columnwidths          in varchar2    default null,
       p_controlsource         in varchar2  default null,
       p_controltiptext        in varchar2  default null,
       p_defaultvalue          in varchar2  default null,
       p_displaywhen           in number    default null,
       p_enabled               in number    default null,
       p_fontbold              in number    default null,
       p_fontitalic            in number    default null,
       p_fontname              in varchar2  default null,
       p_fontsize              in number    default null,
       p_fontunderline         in number    default null,
       p_fontwheight           in number    default null,
       p_forecolor             in number    default null,
       p_format                in varchar2  default null,
       p_height                in number    default null,
       p_helpcontextid         in number    default null,
       p_limittolist           in number    default null,
       p_linkchildfields       in varchar2  default null,
       p_linkmasterfields      in varchar2  default null,
       p_listrows              in number    default null,
       p_multirow              in number    default null,
       p_onchange              in varchar2  default null,
       p_onclick               in varchar2  default null,
       p_ondblclick            in varchar2  default null,
       p_onkeydown             in varchar2  default null,
       p_onkeypress            in varchar2  default null,
       p_onkeyup               in varchar2  default null,
       p_onmousedown           in varchar2  default null,
       p_onmousemove           in varchar2  default null,
       p_onmouseup             in varchar2  default null,
       p_optionvalue           in number    default null,
       p_pageindex             in number    default null,
       p_picture               in varchar2  default null,
       p_picturealignment      in number    default null,
       p_pictureresizemode     in number    default null,
       p_picturetiling         in number    default null,
       p_picturetype           in number    default null,
       p_rowsource             in varchar2  default null,
       p_rowsourcetype         in varchar2  default null,
       p_shortcutmenubar       in varchar2  default null,
       p_sourceobject          in varchar2  default null,
       p_statusbartext         in varchar2  default null,
       p_style                 in number    default null,
       p_tabfixedheight        in number    default null,
       p_tabfixedwidth         in number    default null,
       p_tabindex              in number    default null,
       p_tabstop               in number    default null,
       p_textalign             in number    default null,
       p_textfontcharset       in number    default null,
       p_width                 in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_rpts_modules

   procedure  ins_wwv_mig_acc_rpts_modules  (
       p_dbid                     in number,
       p_moduleid                 in number,
       p_reportid                 in number,
       p_modulename               in varchar2  default null,
       p_countofdeclarationlines  in number    default null,
       p_countoflines             in number    default null,
       p_lines                    in clob      default null,
       p_moduletype               in number    default null
   );



-----
-- create procedure for table  wwv_mig_acc_rpt_perms

   procedure  ins_wwv_mig_acc_rpt_perms  (
       p_dbid               in number,
       p_reportid           in number,
       p_userid             in number    default null,
       p_permissionid       in number,
       p_permission         in number,
       p_permission_desc    in varchar2
   );


-----
-- create procedure for table  wwv_mig_acc_tables

   procedure  ins_wwv_mig_acc_tables  (
       p_tblid                    in number,
       p_dbid                     in number,
       p_tblname                  in varchar2  default null,
       p_primarykey               in number    default null,
       p_cnvtablestruct           in number    default null,
       p_cnvmovedata              in number    default null,
       p_cnvri                    in number    default null,
       p_cnvvalidation            in number    default null,
       p_cnvdefault               in number    default null,
       p_cnvaddtimestamp          in number    default null,
       p_attachtablebacktoaccess  in number    default null,
       p_savepassword             in number    default null,
       p_cnvmakeupdateable        in number    default null,
       p_retainlocalcopy          in number    default null,
       p_syncwithserver           in number    default null,
       p_ownerid                  in number    default null,
       p_validationtext           in varchar2  default null,
       p_validationrule           in varchar2  default null,
       p_numberofrows             in number    default null,
       p_cachingtable             in number    default null,
       p_description              in varchar2  default null,
       p_attributes               in number    default null,
       p_conflicttable            in number    default null,
       p_datecreated              in varchar2  default null,
       p_lastupdated              in varchar2  default null,
       p_recordcount              in number    default null,
       p_orderbyon                in number    default null,
       p_replicafilter            in number    default null,
       p_sourcetablename          in varchar2  default null,
       p_updatable                in number    default null
   );


-----
-- create procedure for table  wwv_mig_acc_tab_perm

   procedure  ins_wwv_mig_acc_tab_perm  (
       p_dbid               in number    default null,
       p_tblid              in number,
       p_userid             in number    default null,
       p_permissionid       in number,
       p_permission         in number,
       p_permission_desc    in varchar2  default null
   );


-----
-- create procedure for table  wwv_mig_acc_users

   procedure  ins_wwv_mig_acc_users  (
       p_dbid               in number,
       p_userid             in number,
       p_username           in varchar2  default null
   );


----
-- create procedure for table wwv_mig_projects
   procedure  ins_wwv_mig_acc_grpsmembers   (
       p_dbid                   in number,
       p_grpmbrid               in number,
       p_userid                 in number,
       p_groupid                in number
   );



-- create procedure for table wwv_mig_rev_tables
   procedure ins_wwv_mig_rev_tables (
      p_project_id              in number,
      p_dbid                    in number,
      p_tblid                   in number,
      p_orig_tblname            in varchar2  default null,
      p_mig_tblname             in varchar2  default null,
      p_owner                   in varchar2  default null,
      p_status                  in varchar2  default null
   );


-- create procedure for table wwv_mig_rev_queries
   procedure ins_wwv_mig_rev_queries (
      p_project_id              in number,
      p_dbid                    in number,
      p_qryid                   in number,
      p_orig_qryname            in varchar2  default null,
      p_mig_tblname             in varchar2  default null,
      p_orig_sql		in clob default null,
      p_mig_sql			in clob default null,
      p_owner                   in varchar2  default null,
      p_status                  in varchar2  default null
   );


-- create procedure for displaying loaded file confirmation
   procedure display_load_confirm (
       p_file_id          in number,
       p_date_time_format in varchar2
   );


-- create procedure for displaying loaded file information
   procedure display_load_info (
       p_file_id          in number,
       p_date_time_format in varchar2
   );

-- create function to check for the version in the export file

   function is_access_export (p_file_id in number)
   return boolean;

-- create procedure for setting the Migration Project name
   procedure set_migration_project_name (
       p_project_id       in number,
       p_workspace_id     in number,
       p_name             in varchar2
   );

--
-- Collision Management functions, taken from the Oracle SQL Developer
-- MIGRATION_TRANSFORMER_HEADER.plsql package
--
-- create function check_identifier_length for collision management checking
   function check_identifier_length(
       p_ident VARCHAR2)
   return VARCHAR2;

-- create function add_suffix for collision management checking
   function add_suffix(
       p_work VARCHAR2,
       p_suffix VARCHAR2,
       p_maxlen NUMBER)
   return VARCHAR2;

-- create function check_reserved_word for collision management checking
   function check_reserved_word(
       p_work VARCHAR2)
   return VARCHAR2;

-- create function sys_check for collision management checking
   function sys_check(
       p_work VARCHAR2)
   return VARCHAR2;

-- create function check_allowed_chars for collision management checking
   function check_allowed_chars(
       p_work NVARCHAR2)
   return NVARCHAR2;

-- create function transform_identifier for collision management checking
   function transform_identifier(
       p_identifier NVARCHAR2)
   return NVARCHAR2;

-- create function truncateStringByteSize for collision management checking
   function truncateStringByteSize(
       p_work VARCHAR2,
       p_bsize NUMBER)
   RETURN VARCHAR2;

-- create function lTrimNonAlphaNumeric for collision management checking
   function lTrimNonAlphaNumeric(
       p_work NVARCHAR2)
   RETURN NVARCHAR2;

-- create function removeQuotes for collision management checking
   function removeQuotes(
       p_work NVARCHAR2)
   RETURN NVARCHAR2;

end  wwv_mig_acc_load ;
/