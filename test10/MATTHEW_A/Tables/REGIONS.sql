CREATE TABLE matthew_a.regions (
  region_id NUMBER NOT NULL CONSTRAINT region_id_nn CHECK ("REGION_ID" IS NOT NULL),
  region_name VARCHAR2(25 BYTE),
  CONSTRAINT reg_id_pk PRIMARY KEY (region_id)
);
COMMENT ON TABLE matthew_a.regions IS 'Regions table that contains region numbers and names. Contains 4 rows; references with the Countries table.';
COMMENT ON COLUMN matthew_a.regions.region_id IS 'Primary key of regions table.';
COMMENT ON COLUMN matthew_a.regions.region_name IS 'Names of regions. Locations are in the countries of these regions.';