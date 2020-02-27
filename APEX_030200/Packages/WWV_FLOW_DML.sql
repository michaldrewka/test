CREATE OR REPLACE package wwv_flow_dml is

--  Copyright (c) Oracle Corporation 1999 - 2009. All Rights Reserved.
--
--    DESCRIPTION
--      APEX table access (DML)
--      Page DML processes call this package.
--      Fetch processes are typically called on page show.
--      DML Process is typically called on page accept.
--      Based on the request accept processing is directed to an insert, update, or delete procedure
--      BLOB fetches are also performed
--
     g_checksum_text       varchar2(32767) := null;
     g_md5_checksum        varchar2(255) := null;
     g_download_text       varchar2(255) := null;

     empty_vc_arr          wwv_flow_global.vc_arr2;
     g_sqlerrm             varchar2(5000) := null;

     g_support_file_item_type boolean := true;
     g_support_blob_col_type  boolean := true;

     --------
     -- FETCH
     --
     -- Procedures called from DML Page Process Types
     --

     procedure fetch_row (
         p_table_owner        in varchar2 default null,
         p_table_name         in varchar2 default null,
         p_rowid              in varchar2 default null,
         p_alt_rowid          in varchar2 default 'ROWID',
         p_rowid2             in varchar2 default null,
         p_alt_rowid2         in varchar2 default null,
         p_compute_checksum   in varchar2 default 'YES',
         p_dml_fetch_mode     in varchar2 default null,
         p_lock               in varchar2 default 'NO',
         p_runtime_where_clause in varchar2 default null
         )
         ;

     function fetch_row_md5_checksum (
         p_table_owner        in varchar2 default null,
         p_table_name         in varchar2 default null,
         p_rowid              in varchar2 default null,
         p_alt_rowid          in varchar2 default 'ROWID',
         p_rowid2             in varchar2 default null,
         p_alt_rowid2         in varchar2 default null,
         p_lock               in varchar2 default 'NO')
         return varchar2
         ;

     function get_column (
         p_column_name in varchar2 default null)
         return varchar2
         ;


     -------------------------
     -- UPDATE, INSERT, DELETE
     --
     -- Procedures called from DML Page Process Types
     --

     procedure update_row (
         p_table_owner        in varchar2 default null,    -- table owner, #OWNER# defaults to owner of application
         p_table_name         in varchar2 default null,    -- table name
         p_rowid              in varchar2 default null,    --
         p_alt_rowid          in varchar2 default 'ROWID',
         p_rowid2             in varchar2 default null,
         p_alt_rowid2         in varchar2 default null,
         p_runtime_where_clause in varchar2 default null)
         ;

     procedure insert_row (
         p_table_owner        in varchar2 default null,
         p_table_name         in varchar2 default null,
         p_alt_rowid          in varchar2 default null,
         p_alt_rowid2         in varchar2 default null,
         p_return_item1_name  in varchar2 default null,
         p_return_item2_name  in varchar2 default null)
         ;

     procedure delete_row (
         p_table_owner        in varchar2 default null,
         p_table_name         in varchar2 default null,
         p_rowid              in varchar2 default null,
         p_alt_rowid          in varchar2 default 'ROWID',
         p_rowid2             in varchar2 default null,
         p_alt_rowid2         in varchar2 default null,
         p_runtime_where_clause in varchar2 default null)
         ;

     procedure process (
         p_action             in varchar2 default null,
         p_table_owner        in varchar2 default null,
         p_table_name         in varchar2 default null,
         p_rowid              in varchar2 default null,
         p_alt_rowid          in varchar2 default 'ROWID',
         p_rowid2             in varchar2 default null,
         p_alt_rowid2         in varchar2 default null,
         p_allowed_actions    in varchar2 default 'IUD',
         p_return_item1_name  in varchar2 default null,
         p_return_item2_name  in varchar2 default null,
         p_runtime_where_clause in varchar2 default null)
         ;


     ------------------
     -- BLOB Management
     --
     procedure get_blob_file (
         -- Fetches BLOB content, called from APEX form pages with items of type FILE
         -- Used to download BLOB from database to Browser
         -- NOT designed to be called by application logic
         --
         p_sid                 in number,                -- Session ID
         p_aid                 in number,                -- Application ID
         p_pid                 in number,                -- Page ID
         p_dml_proc_id         in number,                -- DML Page Process ID from APEX meta data
         p_bcol                in number,                -- Item ID from APEX meta data of BLOB column
         p_pk1                 in varchar2,              -- value of primary key column
         p_ck                  in varchar2,              -- checksum to prevent url tampering
         p_pk2                 in varchar2 default null, -- optional value of second primary key column
         p_mimetype            in varchar2 default null, --
         p_content_disposition in varchar2 default null, --
         p_show_last_mod       in varchar2 default 'Y')  --
         ;

     function get_blob_file_src (
         -- Reference apex_util.get_blob_file_src for additional documentation
         --
         -- Relies on an item with source that uses the following syntax
         -- DB_COLUMN:MIMETYPE_COLUMN:FILENAME_COLUMN:BLOB_LAST_UPDATED_COLUMN:CHARSET_COLUMN:DOWNLOAD_LINK_TEXT
         --
         p_item_name in varchar2 default null,  -- name of apex page item of type FILE
         p_v1        in varchar2 default null,  -- value of primary key column
         p_v2        in varchar2 default null,  -- optional value of optional secondary primary key column
         p_content_disposition in varchar2 default null) -- optional value of "inline" or "attachment"
         return varchar2
         ;

     function get_blob_file_src_and_pk (
         --
         p_item_name           in varchar2 default null,
         p_item_source         in varchar2 default null,
         p_content_disposition in varchar2 default null)
         return varchar2
         ;

     function get_blob_download (
         -- format_mask = DOWNLOAD:<form column>:<pk 1 column>:<pk 2 column>:<content disposition>:<download text>
         -- wwv_flow_dml.get_blob_download (
         --    p_format_mask=>fm,
         --    p_pk_column_1_value=>col_val(wwv_flow_dml.get_pk1_from_blob_fmt_mask(fm,'FORM')),
         --    p_pk_column_2_value=>col_val(wwv_flow_dml.get_pk2_from_blob_fmt_mask(fm,'FORM')),
         --    p_blob_length=>blob length );
         --
         p_format_mask         in varchar2 default null,
         p_pk_column_1_value   in varchar2 default null,
         p_pk_column_2_value   in varchar2 default null,
         p_blob_length         in number   default 0)
         return varchar2
         ;

     function get_pk1_from_blob_fmt_mask (
         -- Parse format mask and return name of primary key 1 column
         -- Form format masks are null or 'FORM'
         -- Report format masks 'IR','CR','REPORT' are all the same
         -- This routine will parse out the "pk 1 column" argument and return the value
         --
         -- Form format mask
         --    DOWNLOAD:<page item name>:<pk 1 column>:<pk 2 column>:<content disposition>:<download text>
         --    position 1: Identifies the name of an APEX page item that contains the value of the primary key
         --                Required
         --    position 2: Identifies the name of the primary key column
         --                Required
         --    position 3: Identifies the name of the secondary key column
         --                Optional
         --    position 4: Content disposition, valid values are "inline" and "attachment"
         --                Optional
         --    position 5: Text of download link
         --                Default is "Download" and is automatically translated
         --                You can specify your own download link which is not translatable
         --                Supports item substitutions
         --                Optional
         --
         -- Report format masks
         --    DOWNLOAD:<blob_tab>:<blob_col>:<pk1_col>:<pk2_col>:<mimetype_col>:<filename_col>:<charset_col>:<content disposition>:<download text>
         --
         p_format_mask in varchar2 default null,    -- Format mask described above, format masks are different for Forms and Reports
         p_mask_type   in varchar2 default 'FORM')  -- valid values include FORM, IR, CR, and REPORT
         return varchar2
         ;

     function get_pk2_from_blob_fmt_mask (
         -- Same as get_pk1_from_blob_fmt_mask, but gets optional secondary primary key item name
         -- Reference get_pk1_from_blob_fmt_mask
         --
         p_format_mask in varchar2 default null,
         p_mask_type   in varchar2 default 'FORM')
         return varchar2
         ;

     function get_blob_rpt_img (
         -- This function returns an img tag with a src link to get_blob
         -- Called by reporting engine with format mask of IMAGE:
         --
         p_pk_column_1_value    in varchar2 default null,
         p_pk_column_2_value    in varchar2 default null,
         p_blob_length          in number   default 0,
         p_column_meta_data_id  in number   default null,
         p_report_type          in varchar2 default 'IR',
         p_cattributes          in varchar2 default  null)
         return varchar2
         ;

     function get_blob_rpt_link (
         -- This function returns a hyper text link to get_blob
         -- Used to generate links to apex_util.get_blob
         -- NOT designed to be called by applications
         -- Length of BLOB column obtained using syntax such as sys.dbms_lob.getlength(my_blob_column)
         -- Both interactive reports and classic reports have the same format masks
         --
         -- Example:
         --
         -- wwv_flow_dml.get_blob_rpt_link (
         --    p_blob_length=> bl,
         --    p_pk_column_1_value=>col_val(wwv_flow_dml.get_pk1_from_blob_fmt_mask(fm,'REPORT')),
         --    p_pk_column_2_value=>col_val(wwv_flow_dml.get_pk2_from_blob_fmt_mask(fm,'REPORT')),
         --    p_column_meta_data_id=> id );
         --
         -- bl = length of blob column
         -- fm = acutal format mask for report column
         -- id = apex meta data row that contains the format mask for the report column
         -- col_val = a function which returns the value of the report column name / alias
         --
         p_pk_column_1_value    in varchar2 default null, -- required value of primary key
         p_pk_column_2_value    in varchar2 default null, -- optional value of secondary key
         p_blob_length          in number   default 0,    -- required length of blob column (use dbms_lob.getlength)
         p_column_meta_data_id  in number   default null, -- APEX meta data ID column of report column
         p_report_type          in varchar2 default 'IR', -- IR or CR, Interactive Report or Classic Report
         p_format_mask          in varchar2 default null) -- Format mask described in apex_util.get_blob procedure
         return varchar2
         ;

     procedure get_blob (
         -- This procedure will download a blob column given proper inputs
         -- This get_blob function is designed to be called from APEX reports automatically
         -- Classic and Interactive Reports given a format mask will generate a link to this procedure
         -- Report that uses  "select ... dbms_lob.getlength(myblob_column) ..." syntax
         --
         -- The report column format mask has the following format
         -- DOWNLOAD|IMAGE:<blob_tab>:<blob_col>:<pk1_col>:<pk2_col>:<mimetype_col>:<filename_col>:<charset_col>:<content disposition>:<download text>
         -- All arguments are delimited by colons
         --
         -- This procedure is NOT designed to be called directly, it is intended to be called by APEX reporting engines
         --
         -- position 1: "DOWNLOAD" or "IMAGE"
         --             Download will result in the generation a "a href=" tag
         --             Image will result in the generation of an inline "img src=" tag
         --             Use image when your files are images
         --             Using image for non image based files will result in broken image links
         --             Required
         -- position 2: Name of the table containing the blob column in question
         --             Required and case sensitive
         -- position 3: Name of the BLOB column name
         --             Required and case sensitive
         -- position 4: Name of the primary key column in the table identified in position 2
         --             Required and case sensitive
         -- position 5: Name of a secondary key column to uniquely identify the row that contains the BLOB column
         --             Optional and case sensitive
         -- position 6: Name of a column that is used to store the mime type that corresponds to the BLOB column
         --             Managing the mimetype allows the mimetype to be encoded in the file download
         --             If a mimetype is not specified download will use "application/octet-stream"
         --             A proper mimetype allows the browser to pick an approparte application to display the file
         --             Optional and case sensitive
         -- position 7: Name of a column that is used to store the filename of the BLOB column identified in position 3
         --             Managing the filename allows downloads to default the file name to a usefull value
         --             Optional and case sensitive
         -- position 8: Name of the character set that is used to store the character set of the file in the BLOB column
         --             Most useful for applications that have files in multiple character sets
         --             Optional and case sensitive
         -- position 9: For DOWNLOAD format masks, identifies the content disposition
         --             Defaults to inline
         --             Valid values are "inline" and "attachment"
         --             A value of inline will cause the browser to render the file inline if it can
         --             A value of attachment will prompt the user to download the file
         --             Optional, use lower case
         -- position 10: For DOWNLOAD format masks, identifies the text used to indicate a download link text
         --             Default to "Download"
         --             Translated into 10 languages
         --             Specify if you wish to over-ride the default text
         --             Standard APEX substitutions are performed
         --             Only used for DOWNLOAD format masks
         --             Optional
         --
         -- Example Report format masks:
         --
         -- DOWNLOAD:EMP:RESUME:EMPNO::MIMETYPE:FILENAME
         -- DOWNLOAD:EMP:RESUME:EMPNO::MIMETYPE:FILENAME:::Photo
         -- IMAGE:EMP:RESUME:EMPNO::MIMETYPE:FILENAME
         --
         --
         s                 in number,                -- APEX session ID
         a                 in number,                -- APEX application ID
         c                 in number,                -- APEX id of the report column
         p                 in number,                -- APEX page ID
         k1                in varchar2,              -- Primary key 1 value
         ck                in varchar2,              -- Checksum used to prevent URL tampering
         rt                in varchar2 default 'IR', -- Report type IR or CR
         k2                in varchar2 default null, -- Primary key 2 value
         lm                in varchar2 default 'Y'   -- Show last modified
         );


end wwv_flow_dml;
/