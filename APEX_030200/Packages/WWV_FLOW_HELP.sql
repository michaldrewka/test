CREATE OR REPLACE package wwv_flow_help as

--
-- Create the Oracle Text indexes for the online help.  Will delete all rows and drop the Oracle Text
-- index if it exists
--
procedure create_help_index(
    p_lang  in varchar2 default null );


procedure show_help(
    p_session   in varchar2 default null,
    p_lang      in varchar2 default null,
    p_flow_id   in varchar2 default null,
    p_step_id   in varchar2 default null );

procedure show_help_content(
    p_session   in varchar2 default null,
    p_lang      in varchar2 default null,
    p_flow_id   in varchar2 default null,
    p_step_id   in varchar2 default null );

--
-- Navigation bar in the top part of the frame
--
procedure show_navigation(
    p_session in varchar2 default null,
    p_lang    in varchar2 default null,
    p_flow_id in varchar2 default null,
    p_step_id in varchar2 default null,
	p_book_id in varchar2 default null
	);

procedure show_get_started;
procedure show_get_start_nav;

--
-- Taken from AskTom.  Remove all characters from the query string which would cause Oracle Text CONTAINS to choke.
-- Group each token with '{}', unless specified as a phrase surrounded by double-quotes
--
function parse_search_string(
    p_search_str in varchar2 ) return varchar2;

--
-- Given a query on the help text, return a window of the text begining at the
-- first hit, with all hit words highlighted with bold tags in the window
--
function hit_result( p_lang in varchar2,
                     p_textkey    in varchar2,
                     p_text_query in varchar2,
                     p_plaintext  in clob) return varchar2;


--
-- Procedure to cleanup all indexes and rows, in the case this needs to be reset by an administrator
--
procedure drop_help_indexes;


--
-- Return the runtime document path, used in the display of search results
--
function get_runtime_doc_path( p_filename in varchar2 default null )
    return varchar2;


end wwv_flow_help;
/