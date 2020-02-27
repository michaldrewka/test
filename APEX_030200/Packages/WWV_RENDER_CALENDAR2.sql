CREATE OR REPLACE package wwv_render_calendar2
is
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Monthly calendar rendering
--
--    SECURITY
--      public execute
--
--    RUNTIME DEPLOYMENT: YES
--
--    NOTES
--      Produces calendar HTML output from a SQL query that selects:
--      Column1: Calendar date, must be an Oracle DATE datatype.
--      Column2: Text to be displayed.
--      Column3: Optional Link for Column2 text.
--      Column4: Optional day link (link for day of month) use _calendar_dateYYYYMMDD_ or
--               _calendar_date_ with p_calendar_day_date_fmt
--      Column5: Frame Target
--      Column6: Display color
--      The query should have ordered by column 1.
--
--      Parameters
--       p_query                 query string or cursor
--                               select [date],[text],[text link],[day link],[frame target],[color] from ...
--                               example: select hiredate, ename, null,
--       p_min_row               the month to start, used for paginate
--       p_max_rows              maximum number of months to display
--       p_min_month             the month to start, used for paginate -- obsolete
--       p_max_months            maximum number of months to display -- obsolete
--       p_monday_friday_only    YES/NO, if YES, just display Monday to Friday
--       p_month_font_face       month font face
--       p_month_font_size       month font size
--       p_month_font_color      month font color
--       p_day_font_face         day font face
--       p_day_font_size         day font size
--       p_day_font_color        day font color
--       p_cell_font_face        cell font face
--       p_cell_font_size        cell font size
--       p_cell_font_color       cell font color
--       p_page_width            HTML table width
--       p_heading_bg_color      HTML table heading bg color
--       p_table_bgcolor         HTML table bg color
--
--
g_status        varchar2(200);
g_total_rows    number;
g_total_months    number;        -- for paginate
g_magic_date    constant date := to_date('12111111','ddmmyyyy' ); -- magic date is Sunday
--
procedure show (
    p_query                 in varchar2 default null,
    p_min_month             in number   default 1,
    p_min_row               in number   default 1,
    p_max_months            in number   default 200,
    p_max_rows              in number   default 200,
    p_monday_friday_only    in varchar2 default 'NO',
    p_month_font_face       in varchar2 default null,
    p_month_font_size       in varchar2 default null,
    p_month_font_color      in varchar2 default null,
    p_day_font_face         in varchar2 default null,
    p_day_font_size         in varchar2 default null,
    p_day_font_color        in varchar2 default null,
    p_cell_font_face        in varchar2 default null,
    p_cell_font_size        in varchar2 default null,
    p_cell_font_color       in varchar2 default null,
    p_page_width            in varchar2 default '90%',
    p_heading_bgcolor       in varchar2 default '#C0C0A0',
    p_table_bgcolor         in varchar2 default '#E0E0D0',
    --
    p_table_cattributes     in varchar2 default ' cellspacing="0" cellpadding="0"',
    p_show_month_above_tab  in varchar2 default 'YES',
    p_non_curr_month_attr   in varchar2 default 'bgcolor="#CCCCCC"',
    p_curr_day_attr         in varchar2 default 'bgcolor="#FFFFCC"',
    p_min_blank_cell_height in varchar2 default '40',
    p_carot_character       in varchar2 default '&#187;',
    p_calendar_day_date_fmt in varchar2 default 'MM/DD/YYYY',
    p_cur_local_date        in date     default null
);

end wwv_render_calendar2;
/