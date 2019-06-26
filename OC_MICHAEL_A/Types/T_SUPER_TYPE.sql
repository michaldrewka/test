CREATE OR REPLACE TYPE oc_michael_a.t_super_type AUTHID CURRENT_USER AS OBJECT
(

   v_load_time        DATE,
   v_requested_date   DATE,
   v_eff_time         VARCHAR2(10),
   v_company_group_id NUMBER,
   v_company_name     VARCHAR2(255),

   MEMBER PROCEDURE init(SELF IN OUT NOCOPY t_super_type, p_requested_date IN DATE)
)
NOT FINAL NOT INSTANTIABLE
/
CREATE OR REPLACE TYPE BODY oc_michael_a.t_super_type AS

   MEMBER PROCEDURE init(SELF             IN OUT NOCOPY t_super_type,
                         p_requested_date IN DATE) IS
   BEGIN

      self.v_eff_time       := '10:00am';
      self.v_load_time      := SYSDATE;
      self.v_requested_date := TRUNC(p_requested_date);
      self.v_company_name := 'TEST';
      self.v_company_group_id := 'TEST';

   END init;

END;
/