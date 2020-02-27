CREATE OR REPLACE FORCE VIEW wwv_flow_collections (collection_name,seq_id,c001,c002,c003,c004,c005,c006,c007,c008,c009,c010,c011,c012,c013,c014,c015,c016,c017,c018,c019,c020,c021,c022,c023,c024,c025,c026,c027,c028,c029,c030,c031,c032,c033,c034,c035,c036,c037,c038,c039,c040,c041,c042,c043,c044,c045,c046,c047,c048,c049,c050,clob001,md5_original) AS
select c.collection_name, m.seq_id, m.c001, m.c002, m.c003, m.c004, m.c005, m.c006, m.c007,
           m.c008, m.c009, m.c010, m.c011, m.c012, m.c013, m.c014, m.c015, m.c016, m.c017,
           m.c018, m.c019, m.c020, m.c021, m.c022, m.c023, m.c024, m.c025, m.c026, m.c027,
           m.c028, m.c029, m.c030, m.c031, m.c032, m.c033, m.c034, m.c035, m.c036, m.c037,
           m.c038, m.c039, m.c040, m.c041, m.c042, m.c043, m.c044, m.c045, m.c046, m.c047,
           m.c048, m.c049, m.c050, m.clob001, m.md5_original
      from wwv_flow_collections$ c, wwv_flow_collection_members$ m
     where c.session_id = (select v('SESSION') from dual)
       and c.security_group_id = (select wwv_flow.get_sgid from dual)
       and c.id = m.collection_id
       and c.flow_id = (select nv('FLOW_ID') from dual);