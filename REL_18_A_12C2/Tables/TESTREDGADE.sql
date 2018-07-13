CREATE TABLE rel_18_a_12c2.testredgade (
  "ID" NUMBER NOT NULL,
  vorname VARCHAR2(100 CHAR),
  nachname VARCHAR2(100 CHAR),
  wert NUMBER,
  toll VARCHAR2(23 CHAR),
  CONSTRAINT pk_testredgade PRIMARY KEY ("ID") USING INDEX rel_18_a_12c2.redgate_indx
);