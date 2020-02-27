CREATE OR REPLACE PACKAGE wwv_mig_frmmenu_load_xml
AS
    g_security_grp_id           number := 10;
    g_xmlns                     varchar2(255)   := 'xmlns="http://xmlns.oracle.com/Forms"';
    g_project_id                number := 0;
    g_file_id                   number := 0;
    g_sqlerr                    varchar2(4000)  := null;

    TYPE col_name_arr IS TABLE OF VARCHAR2(30) INDEX BY VARCHAR2(30);

-- Get all the attributes of xml file which are associated with input table's column names
-- as mapped in wwv_mig_frm_xmltagtablemap table
FUNCTION get_menus_column_name (
    p_table_name                VARCHAR2
) RETURN col_name_arr;

-- create function to check for the <MenuModule> tag in the export file
FUNCTION is_valid_menu_xml (
       p_file_id             in number,
       p_project_id          in number,
       p_security_group_id   in number)
   return boolean;

-- Load all the forms' table, based on the input Node Element & parent Tag name
PROCEDURE load_all_nodes (
    p_file_id           IN      NUMBER
);

-- Display Loaded File confirmation on Wizard Confirmation Page
procedure display_load_confirm (
    p_project_id                in      number,
    p_date_time_format          in      varchar2
);

-- Display Loaded File information on Wizard Confirmation Page
procedure display_load_info (
    p_project_id                in      number,
    p_date_time_format          in      varchar2
);

END wwv_mig_frmmenu_load_xml;
/