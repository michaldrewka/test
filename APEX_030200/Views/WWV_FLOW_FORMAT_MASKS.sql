CREATE OR REPLACE FORCE VIEW wwv_flow_format_masks ("D",r,"T") AS
select to_char((5234 + 10/100),'FML999G999G999G999G990D00') d, 'FML999G999G999G999G990D00' r, 'N' t from dual
    union all
select trim(to_char((5234 + 10/100),'999G999G999G999G990D00')) d, '999G999G999G999G990D00' r, 'N' t from dual
    union all
select trim(to_char((5234 + 10/100),'999G999G999G999G990D0000')) d, '999G999G999G999G990D0000' r, 'N' t from dual
    union all
select trim(to_char(5234,'999G999G999G999G999G999G990')) d, '999G999G999G999G999G999G990' r, 'N' t from dual
    union all
select trim(to_char((-5234 - 10/100),'999G999G999G999G990D00MI')) d, '999G999G999G999G990D00MI' r, 'N' t from dual
    union all
select trim(to_char((-5234 - 10/100),'S999G999G999G999G990D00')) d, 'S999G999G999G999G990D00' r, 'N' t from dual
    union all
select trim(to_char((-5234 - 10/100),'999G999G999G999G990D00PR')) d, '999G999G999G999G990D00PR' r, 'N' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'DD-MON-RR') d, 'DD-MON-RR' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'DD-MON-YYYY') d, 'DD-MON-YYYY' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'DD-MON') d, 'DD-MON' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'RR-MON-DD') d, 'RR-MON-DD' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'YYYY-MM-DD') d, 'YYYY-MM-DD' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'fmDay, fmDD fmMonth, YYYY') d, 'fmDay, fmDD fmMonth, YYYY' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'DD-MON-YYYY HH24:MI') d, 'DD-MON-YYYY HH24:MI' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'DD-MON-YYYY HH24:MI:SS') d, 'DD-MON-YYYY HH24:MI:SS' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'DD-MON-YYYY HH:MIPM') d, 'DD-MON-YYYY HH:MIPM' r, 'D' t from dual
    union all
select to_char(to_date('20040112143000','YYYYMMDDHH24MISS'),'Month') d, 'Month' r, 'D' t from dual
    union all
select wwv_flow_lang.system_message('SINCE_DATE_MASK') d, 'SINCE' r, 'D' t from dual;