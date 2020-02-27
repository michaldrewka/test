CREATE OR REPLACE package apexws
is

--  Copyright (c) Oracle Corporation 2007. All Rights Reserved.

    procedure home (
       s   in varchar2 default null
       );

     procedure search (
       s   in varchar2 default null
       );

    procedure folder (
       i   in varchar2 default null,
       s   in varchar2 default null,
       u   in varchar2 default null
       );

    procedure sheet (
       i   in varchar2 default null,
       s   in varchar2 default null
       );

    procedure row (
       i   in varchar2 default null,
       s   in varchar2 default null,
       r   in varchar2 default null);

    procedure page (
       i   in varchar2 default null,
       s   in varchar2 default null
       );

end apexws;
/