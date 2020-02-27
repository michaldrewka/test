CREATE OR REPLACE package wwv_htp is

procedure url_encode
(
    ctext      in varchar2 DEFAULT NULL
);

procedure url_encode2
(
    ctext      in varchar2 DEFAULT NULL
);

/**
 * Print an opening HMTL table cell "TD" tag.
 */
procedure tableDataOpen
(
    calign      in varchar2 DEFAULT NULL,
    cdp         in varchar2 DEFAULT NULL,
    cnowrap     in varchar2 DEFAULT NULL,
    crowspan    in varchar2 DEFAULT NULL,
    ccolspan    in varchar2 DEFAULT NULL,
    cattributes in varchar2 DEFAULT NULL
);


/**
 * Print a closing HMTL table cell "TD" tag.
 */
procedure tableDataClose;


/**
 * Print an opening HTML paragraph "P" tag.
 */
procedure paragraphOpen
(
    calign       in varchar2 DEFAULT NULL,
    cnowrap      in varchar2 DEFAULT NULL,
    cclear       in varchar2 DEFAULT NULL,
    cattributes  in varchar2 DEFAULT NULL
);


/**
 * Print a closing HTML paragraph "P" tag.
 */
procedure paragraphClose;


/**
 * Print an opening HTML division "DIV" tag.
 */
procedure divOpen
(
    calign      in varchar2 DEFAULT NULL,
    cattributes in varchar2 DEFAULT NULL
);


/**
 * Print a closing HTML division "DIV" tag.
 */
procedure divClose;


/**
 * Print a form button "INPUT" HTML tag.
 */
procedure formButton
(
    cname       in varchar2 DEFAULT NULL,
    cvalue      in varchar2 DEFAULT NULL,
    cattributes in varchar2 DEFAULT NULL
);


/**
 * Print an opening HMTL script "SCRIPT" tag.
 */
procedure scriptOpen
(
    clanguage in varchar2 DEFAULT 'JavaScript'
);


/**
 * Print a closing HMTL script "SCRIPT" tag.
 */
procedure scriptClose;


/**
 * Print an opening HMTL script "CENTER" tag.
 */
procedure centerOpen;


/**
 * Print a closing HMTL script "CENTER" tag.
 */
procedure centerClose;


/**
 * Print an opening HMTL script "LI" tag.
 */
procedure listItemOpen
(
    cclear      in varchar2 DEFAULT NULL,
    cdingbat    in varchar2 DEFAULT NULL,
    csrc        in varchar2 DEFAULT NULL,
    cattributes in varchar2 DEFAULT NULL
);

procedure formHidden(
    cname       in varchar2,
    cvalue      in varchar2 DEFAULT NULL,
    cattributes in varchar2 DEFAULT NULL
);

/*htp overides for xhtml and 508*/

procedure tabledata (
	CVALUE      in varchar2 default null,
	CALIGN      in varchar2 default null,
	CDP         in varchar2 default null,
	CNOWRAP     in varchar2 default null,
	CROWSPAN    in varchar2 default null,
	CCOLSPAN    in varchar2 default null,
	CATTRIBUTES in varchar2 default null
 );

procedure tablerowopen (
 CALIGN      in varchar2 default null,
 CVALIGN     in varchar2 default null,
 CDP         in varchar2 default null,
 CNOWRAP     in varchar2 default null,
 CATTRIBUTES in varchar2 default null
);


procedure tablerowclose;



procedure tableheader (
 CVALUE      in varchar2 default null,
 CALIGN      in varchar2 default null,
 CDP         in varchar2 default null,
 CNOWRAP     in varchar2 default null,
 CROWSPAN    in varchar2 default null,
 CCOLSPAN    in varchar2 default null,
 CATTRIBUTES in varchar2 default null
 );



procedure tableopen (
 CBORDER     in varchar2 default null,
 CALIGN      in varchar2 default null,
 CNOWRAP     in varchar2 default null,
 CCLEAR      in varchar2 default null,
 CATTRIBUTES in varchar2 default null

);

procedure tableclose;

procedure img (
 CURL        in varchar2 default null,
 CALIGN      in varchar2 default null,
 CALT        in varchar2 default null,
 CISMAP      in varchar2 default null,
 CATTRIBUTES in varchar2 default null
);


procedure bodyopen (
 CBACKGROUND in varchar2 default null,
 CATTRIBUTES in varchar2 default null
);

procedure bodyClose;

procedure htmlopen;

procedure htmlClose;


procedure formText (
cname in varchar2 DEFAULT NULL,
csize in varchar2 DEFAULT NULL,
cmaxlength in varchar2 DEFAULT NULL,
cvalue in varchar2 DEFAULT NULL,
cattributes in varchar2 DEFAULT NULL
);

procedure formPassword (
cname in varchar2 DEFAULT NULL,
csize in varchar2 DEFAULT NULL,
cmaxlength in varchar2 DEFAULT NULL,
cvalue in varchar2 DEFAULT NULL,
cattributes in varchar2 DEFAULT NULL
);

procedure anchor(
curl in varchar2 DEFAULT NULL,
ctext in varchar2 DEFAULT NULL,
cname in varchar2 DEFAULT NULL,
cattributes in varchar2 DEFAULT NULL
);

procedure anchor2(
curl in varchar2 DEFAULT NULL,
ctext in varchar2 DEFAULT NULL,
cname in varchar2 DEFAULT NULL,
ctarget in varchar2 DEFAULT NULL,
cattributes in varchar2 DEFAULT NULL
);

procedure formOpen(
curl in varchar2 DEFAULT NULL,
cmethod in varchar2 DEFAULT NULL,
ctarget in varchar2 DEFAULT NULL,
cenctype in varchar2 DEFAULT NULL,
cattributes in varchar2 DEFAULT NULL
);

procedure formSelectOpen(
	cname in varchar2 DEFAULT NULL,
	cprompt in varchar2 DEFAULT NULL,
	nsize in integer DEFAULT NULL,
	cattributes in varchar2 DEFAULT NULL
);


procedure formSelectOption(
	cvalue in varchar2 DEFAULT NULL,
	cselected in varchar2 DEFAULT NULL,
	cattributes in varchar2 DEFAULT NULL
);

procedure formSelectClose;

procedure formSubmit(
   cname          in       varchar2   DEFAULT NULL,
   cvalue         in       varchar2   DEFAULT 'Submit',
   cattributes    in       varchar2   DEFAULT NULL
);


end wwv_htp;
/