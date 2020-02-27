CREATE OR REPLACE package wwv_flow_worksheet_attachment
as

procedure add_doc (
    p_row_id    in varchar2,
    p_file_name in varchar2,
    p_desc      in varchar2
    );

procedure delete_doc (
    p_doc_id    in varchar2
    );

procedure download_doc (
    p_doc_id    in varchar2
    );

end wwv_flow_worksheet_attachment;
/