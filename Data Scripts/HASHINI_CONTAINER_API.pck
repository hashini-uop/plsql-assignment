CREATE OR REPLACE PACKAGE HASHINI_CONTAINER_API AS
   PROCEDURE insert_container(container_id_ IN NUMBER DEFAULT NULL, current_weight_ IN NUMBER, max_volume_ IN NUMBER, max_weight_ IN NUMBER, current_volume_ IN NUMBER, branch_id_ IN NUMBER , company_reg_no_ IN NUMBER);
    PROCEDURE update_container(container_id_   IN NUMBER,
                             current_weight_ IN NUMBER,
                             max_volume_     IN NUMBER,
                             max_weight_     IN NUMBER,
                             current_volume_ IN NUMBER,
                             branch_id_      IN NUMBER,
                             company_reg_no_ IN NUMBER);
   PROCEDURE delete_container(container_id_   IN NUMBER,
                             branch_id_      IN NUMBER,
                             company_reg_no_ IN NUMBER);
END HASHINI_CONTAINER_API;
/
CREATE OR REPLACE PACKAGE BODY HASHINI_CONTAINER_API AS
  PROCEDURE insert_container(container_id_   IN NUMBER DEFAULT NULL,
                             current_weight_ IN NUMBER,
                             max_volume_     IN NUMBER,
                             max_weight_     IN NUMBER,
                             current_volume_ IN NUMBER,
                             branch_id_      IN NUMBER,
                             company_reg_no_ IN NUMBER) IS
    generated_container_id_ NUMBER;
  BEGIN
    IF container_id_ IS NULL THEN
      SELECT container_id_sequence.NEXTVAL
        INTO generated_container_id_
        FROM dual;
    ELSE
      generated_container_id_ := container_id_;

    END IF;

    INSERT INTO HASHINI_CONTAINER_TAB
      (container_id,
       current_weight,
       max_volume,
       max_weight,
       current_volume,
       branch_id,
       company_reg_no)
    VALUES
      (generated_container_id_,
       current_weight_,
       max_volume_,
       max_weight_,
       current_volume_,
       branch_id_,
       company_reg_no_);
  END insert_container;

  PROCEDURE update_container(container_id_   IN NUMBER,
                             current_weight_ IN NUMBER,
                             max_volume_     IN NUMBER,
                             max_weight_     IN NUMBER,
                             current_volume_ IN NUMBER,
                             branch_id_      IN NUMBER,
                             company_reg_no_ IN NUMBER ) IS
  BEGIN
    UPDATE HASHINI_CONTAINER_TAB
       SET current_weight = current_weight_,
           max_volume     = max_volume_,
           max_weight     = max_weight_,
           current_volume = current_volume_
     WHERE container_id = container_id_ AND branch_id = branch_id_ AND
           company_reg_no = company_reg_no_;
  END update_container;

  PROCEDURE delete_container(container_id_   IN NUMBER,
                             branch_id_      IN NUMBER,
                             company_reg_no_ IN NUMBER) IS
  BEGIN
    DELETE FROM HASHINI_CONTAINER_TAB
     WHERE container_id = container_id_ AND branch_id = branch_id_ AND
           company_reg_no = company_reg_no_;
  END delete_container;

END HASHINI_CONTAINER_API;
/
