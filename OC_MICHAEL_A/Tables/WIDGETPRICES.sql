CREATE TABLE oc_michael_a.widgetprices (
  recordid NUMBER(*,0) NOT NULL,
  widgetid NUMBER(*,0),
  price NUMBER(19,4),
  validfrom DATE,
  validto DATE,
  "ACTIVE" CHAR,
  CONSTRAINT pk_widgetprices PRIMARY KEY (recordid)
);