CREATE OR REPLACE FORCE VIEW wwv_flow_version (seq,date_applied,major_version,minor_version,patch_version,"VERSION",banner,comments) AS
select seq,date_applied,major_version,minor_version,patch_version,
           major_version||'.'||minor_version||'.'||patch_version version,
           banner,comments
      from wwv_flow_version$
     where seq = (select max(seq)
                    from wwv_flow_version$);