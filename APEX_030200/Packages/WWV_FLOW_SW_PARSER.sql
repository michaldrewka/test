CREATE OR REPLACE package wwv_flow_sw_parser as

--  Copyright (c) Oracle Corporation 2005. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package is used to parse script files from SQL Workshop Script Repository.
--      It conforms to SQL*Plus 10.2, with some restrictions.
--
--    NOTES
--
--
--    SECURITY
--      No grants, must be run as schema owner.
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

  -- File id of the script being parsed
  g_file wwv_flow_file_objects$%rowtype;

  /*
   * Maximum supported line length
   */
  G_LIMIT_LINESIZE        CONSTANT PLS_INTEGER := 32767;

  /*
   * Offset for statement terminators.
   * Callers are assumed not caring about terminator postition, just the fact that one was seen.
   */
  G_OFFSET_UNKNOWN        CONSTANT PLS_INTEGER := -1;

  /*
   * Statment Class Constants
   */
  G_C_UNKNOWN             CONSTANT PLS_INTEGER :=  1; /* unknown - an error in the user's script */
  G_C_SQL                 CONSTANT PLS_INTEGER :=  2; /* A SQL command */
  G_C_PLSQL               CONSTANT PLS_INTEGER :=  3; /* A PL/SQL command */
  G_C_SQLPLUS             CONSTANT PLS_INTEGER :=  4; /* A SQL*Plus command */
  G_C_COMMENT             CONSTANT PLS_INTEGER :=  5; /* A REM, -- or slash-asterisk comment */

  -- These classes are for temporary internal processing only
  G_C_EMPTYLINE           CONSTANT PLS_INTEGER :=  6; /* empty or only whitespace on this line */
  G_C_MULTILINECOMMENT    CONSTANT PLS_INTEGER :=  7; /* A slash-asterisk comment */
  G_C_OLDCOMMENT          CONSTANT PLS_INTEGER :=  8; /* The old DOCUMENT comment syntax */
  G_C_UNKNOWN_SET         CONSTANT PLS_INTEGER :=  9; /* SET seen but could be SQL or PL/SQL */
  G_C_UNKNOWN_CREATE      CONSTANT PLS_INTEGER := 10; /* CREATE seen but could be SQL or PL/SQL */

  /*
   * Statement Identifier Constants
   *
   * New values can be added to the end.
   */
  G_S_UNKNOWN         CONSTANT PLS_INTEGER :=  1; /* only returned for G_C_UNKNOWN */
  G_S_ACCEPT          CONSTANT PLS_INTEGER :=  2;
  G_S_ALTER           CONSTANT PLS_INTEGER :=  3;
  G_S_ANALYZE         CONSTANT PLS_INTEGER :=  4;
  G_S_APPEND          CONSTANT PLS_INTEGER :=  5;
  G_S_ARCHIVE         CONSTANT PLS_INTEGER :=  6;
  G_S_ASSOCIATE       CONSTANT PLS_INTEGER :=  7;
  G_S_AT              CONSTANT PLS_INTEGER :=  8; /* i.e. "@" */
  G_S_ATNESTED        CONSTANT PLS_INTEGER :=  9; /* i.e. "@@" */
  G_S_ATTRIBUTE       CONSTANT PLS_INTEGER := 10;
  G_S_AUDIT           CONSTANT PLS_INTEGER := 11;
  G_S_BEGIN           CONSTANT PLS_INTEGER := 12;
  G_S_BLOCKTERMINATOR CONSTANT PLS_INTEGER := 13; /* Period ending SQL and PL/SQL */
  G_S_BREAK           CONSTANT PLS_INTEGER := 14;
  G_S_BTITLE          CONSTANT PLS_INTEGER := 15;
  G_S_CALL            CONSTANT PLS_INTEGER := 16;
  G_S_CHANGE          CONSTANT PLS_INTEGER := 17;
  G_S_CLEAR           CONSTANT PLS_INTEGER := 18;
  G_S_COLUMN          CONSTANT PLS_INTEGER := 19;
  G_S_COMMENT_SQL     CONSTANT PLS_INTEGER := 20; /* SQL table COMMENT command */
  G_S_COMMIT          CONSTANT PLS_INTEGER := 21;
  G_S_COMMENT_PLUS    CONSTANT PLS_INTEGER := 22; /* REM, --, DOC, or slash-asterisk */
  G_S_COMPUTE         CONSTANT PLS_INTEGER := 23;
  G_S_CONNECT         CONSTANT PLS_INTEGER := 24;
  G_S_COPY            CONSTANT PLS_INTEGER := 25;
  G_S_CREATE_SQL      CONSTANT PLS_INTEGER := 26; /* e.g. CREATE TABLE */
  G_S_CREATE_PLSQL    CONSTANT PLS_INTEGER := 27; /* e.g. CREATE OR REPLACE PACKAGE */
  G_S_DECLARE         CONSTANT PLS_INTEGER := 28;
  G_S_DEFINE          CONSTANT PLS_INTEGER := 29;
  G_S_DEL_PLUS        CONSTANT PLS_INTEGER := 30; /* SQL*Plus line-editor DEL line deletion */
  G_S_DELETE          CONSTANT PLS_INTEGER := 31; /* SQL data deletion */
  G_S_DESCRIBE        CONSTANT PLS_INTEGER := 32;
  G_S_DISASSOCIATE    CONSTANT PLS_INTEGER := 33;
  G_S_DISCONNECT      CONSTANT PLS_INTEGER := 34;
  G_S_DROP            CONSTANT PLS_INTEGER := 35;
  G_S_EDIT            CONSTANT PLS_INTEGER := 36;
  G_S_EXECUTE         CONSTANT PLS_INTEGER := 37;
  G_S_EXPAND          CONSTANT PLS_INTEGER := 38;
  G_S_EXIT            CONSTANT PLS_INTEGER := 39;
  G_S_EXPLAIN         CONSTANT PLS_INTEGER := 40;
  G_S_FLASHBACK       CONSTANT PLS_INTEGER := 41;
  G_S_GET             CONSTANT PLS_INTEGER := 42;
  G_S_GRANT           CONSTANT PLS_INTEGER := 43;
  G_S_HOST            CONSTANT PLS_INTEGER := 44;
  G_S_HOSTALIAS       CONSTANT PLS_INTEGER := 45; /* '!' or '$ */
  G_S_HELP            CONSTANT PLS_INTEGER := 46; /* HELP or "?" */
  G_S_INPUT           CONSTANT PLS_INTEGER := 47;
  G_S_INSERT          CONSTANT PLS_INTEGER := 48;
  G_S_LIST            CONSTANT PLS_INTEGER := 49;
  G_S_LOCK            CONSTANT PLS_INTEGER := 50;
  G_S_MERGE           CONSTANT PLS_INTEGER := 51;
  G_S_NEWPAGE         CONSTANT PLS_INTEGER := 52;
  G_S_NOAUDIT         CONSTANT PLS_INTEGER := 53;
  G_S_ORADEBUG        CONSTANT PLS_INTEGER := 54;
  G_S_PASSWORD        CONSTANT PLS_INTEGER := 55;
  G_S_PAUSE           CONSTANT PLS_INTEGER := 56;
  G_S_PLSQLLABEL      CONSTANT PLS_INTEGER := 57; /* <<mylabel>> begin ... end; */
  G_S_PRINT           CONSTANT PLS_INTEGER := 58;
  G_S_PROMPT          CONSTANT PLS_INTEGER := 59;
  G_S_PURGE           CONSTANT PLS_INTEGER := 60;
  G_S_QUIT            CONSTANT PLS_INTEGER := 61;
  G_S_RECOVER         CONSTANT PLS_INTEGER := 62;
  G_S_RENAME          CONSTANT PLS_INTEGER := 63;
  G_S_REPFOOTER       CONSTANT PLS_INTEGER := 64;
  G_S_REPHEADER       CONSTANT PLS_INTEGER := 65;
  G_S_REVOKE          CONSTANT PLS_INTEGER := 66;
  G_S_ROLLBACK_PLUS   CONSTANT PLS_INTEGER := 67; /* ROLLBAC with no 'K' */
  G_S_ROLLBACK_SQL    CONSTANT PLS_INTEGER := 68;
  G_S_RUN             CONSTANT PLS_INTEGER := 69;
  G_S_SAVE            CONSTANT PLS_INTEGER := 70;
  G_S_SAVEPOINT       CONSTANT PLS_INTEGER := 71;
  G_S_SELECT          CONSTANT PLS_INTEGER := 72; /* SELECT or "(SELECT...)" */
  G_S_SET_PLUS        CONSTANT PLS_INTEGER := 73; /* Client-side SET command */
  G_S_SET_SQL         CONSTANT PLS_INTEGER := 74; /* Server-side SET e.g. SET TRANSACTION */
  G_S_SHOW            CONSTANT PLS_INTEGER := 75;
  G_S_SHUTDOWN        CONSTANT PLS_INTEGER := 76;
  G_S_SLASH           CONSTANT PLS_INTEGER := 77; /* "/" to re-execute previous SQL or PL/SQL */
  G_S_SPOOL           CONSTANT PLS_INTEGER := 78;
  G_S_SQLPLUSPREFIX   CONSTANT PLS_INTEGER := 79; /* "#" */
  G_S_SQLTERMINATOR   CONSTANT PLS_INTEGER := 80; /* ";" or "/" to end SQL*Plus, SQL and PL/SQL */
  G_S_START           CONSTANT PLS_INTEGER := 81;
  G_S_STARTUP         CONSTANT PLS_INTEGER := 82;
  G_S_STORE           CONSTANT PLS_INTEGER := 83;
  G_S_TIMING          CONSTANT PLS_INTEGER := 84;
  G_S_TRUNCATE        CONSTANT PLS_INTEGER := 85;
  G_S_TTITLE          CONSTANT PLS_INTEGER := 86;
  G_S_UNDEFINE        CONSTANT PLS_INTEGER := 87;
  G_S_UPDATE          CONSTANT PLS_INTEGER := 88;
  G_S_VALIDATE        CONSTANT PLS_INTEGER := 89;
  G_S_VARIABLE        CONSTANT PLS_INTEGER := 90;
  G_S_WHENEVER        CONSTANT PLS_INTEGER := 91;
  G_S_WITH            CONSTANT PLS_INTEGER := 92;
  G_S_XQUERY          CONSTANT PLS_INTEGER := 93;


/*
 * Routines for parsing a SQL*Plus script
 */
function  parsed(p_file_id in number) return number;
procedure parse_file (p_file_id in number);
procedure parse_clob(p_script in clob);

end wwv_flow_sw_parser;
/