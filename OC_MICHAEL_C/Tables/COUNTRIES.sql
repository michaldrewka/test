CREATE TABLE oc_michael_c.countries (
  country_id CHAR(2 BYTE) NOT NULL,
  country_name VARCHAR2(40 BYTE),
  region_id NUMBER,
  CONSTRAINT country_c_id_pk PRIMARY KEY (country_id) USING INDEX oc_michael_c.country_c_id_pkx,
  CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES oc_michael_c.regions (region_id)
);
COMMENT ON COLUMN oc_michael_c.countries.country_id IS 'Primary key of countries table.';
COMMENT ON COLUMN oc_michael_c.countries.country_name IS 'Country name';
COMMENT ON COLUMN oc_michael_c.countries.region_id IS 'Region ID for the country. Foreign key to region_id column in the departments table.';