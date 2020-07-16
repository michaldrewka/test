CREATE OR REPLACE TYPE oc_michael_a.data_typ1 AS OBJECT
(
    data1 NUMBER,
    MEMBER FUNCTION proc(increment NUMBER) RETURN NUMBER
);
/