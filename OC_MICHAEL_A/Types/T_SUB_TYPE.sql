CREATE OR REPLACE TYPE oc_michael_a.t_sub_type UNDER t_super_type
(
   OVERRIDING MEMBER PROCEDURE init(SELF             IN OUT NOCOPY t_sub_type,
                                    p_requested_date IN DATE),
   CONSTRUCTOR FUNCTION t_sub_type(SELF             IN OUT NOCOPY t_sub_type,
                                    p_requested_date IN DATE)
      RETURN SELF AS RESULT
)
/
CREATE OR REPLACE TYPE BODY oc_michael_a.t_sub_type IS

   OVERRIDING MEMBER PROCEDURE init(SELF             IN OUT NOCOPY t_sub_type,
                                    p_requested_date IN DATE) IS
   BEGIN
      self.v_company_group_id := '4';
      (SELF AS t_super_type).init(p_requested_date => p_requested_date);
   END init;

   CONSTRUCTOR FUNCTION t_sub_type(SELF             IN OUT NOCOPY t_sub_type,
                                    p_requested_date IN DATE) RETURN SELF AS RESULT IS
    
   BEGIN
      self.init(p_requested_date => p_requested_date);
      RETURN;
   END t_sub_type;
END;
/