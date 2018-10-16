CREATE TABLE oc_michael_a.products (
  product_id NUMBER(10) NOT NULL,
  supplier_id NUMBER(10) NOT NULL,
  CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES oc_michael_a.supplier (supplier_id) DISABLE NOVALIDATE
);