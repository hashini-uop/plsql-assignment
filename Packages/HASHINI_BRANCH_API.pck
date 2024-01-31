CREATE OR REPLACE PACKAGE HASHINI_BRANCH_API AS
   PROCEDURE insert_branch(branch_name_ IN VARCHAR2, branch_address_ IN VARCHAR2, branch_manager_ IN VARCHAR2, total_warehouse_capacity_ IN NUMBER, company_reg_no_ IN NUMBER, container_id_ IN NUMBER);
   FUNCTION get_branch_name(branch_id_ IN NUMBER) RETURN VARCHAR2;
END HASHINI_BRANCH_API;
/
CREATE OR REPLACE PACKAGE BODY HASHINI_BRANCH_API AS
  PROCEDURE insert_branch(branch_name_              IN VARCHAR2,
                          branch_address_           IN VARCHAR2,
                          branch_manager_           IN VARCHAR2,
                          total_warehouse_capacity_ IN NUMBER,
                          company_reg_no_           IN NUMBER,
                          container_id_             IN NUMBER
                          ) IS
    branch_id_ NUMBER;
  BEGIN
    SELECT branch_id_seq.NEXTVAL INTO branch_id_ FROM dual;
    INSERT INTO HASHINI_BRANCH_TAB
      (
     branch_name,
       branch_address,
       branch_manager,
       total_warehouse_capacity,
       company_reg_no,
       container_id )
    VALUES
      (
       branch_name_,
       branch_address_,
       branch_manager_,
       total_warehouse_capacity_,
       company_reg_no_,
       container_id_ );
  END insert_branch;

  FUNCTION get_branch_name(branch_id_ IN NUMBER) RETURN VARCHAR2 IS
    branch_name_ VARCHAR2(200);
  BEGIN
    SELECT branch_name
      INTO branch_name_
      FROM HASHINI_BRANCH_TAB
     WHERE branch_id = branch_id_;

    RETURN branch_name_;

  END get_branch_name;
  
    FUNCTION get_branch_name(branch_id_ IN NUMBER) RETURN VARCHAR2 IS
    branch_name_ VARCHAR2(200);
  BEGIN
    SELECT branch_name
      INTO branch_name_
      FROM HASHINI_BRANCH_TAB
     WHERE branch_id = branch_id_;

    RETURN branch_name_;

  END get_branch_name;
  
  
    FUNCTION get_branch_address(branch_id_ IN NUMBER) RETURN VARCHAR2 IS
    branch_address_ VARCHAR2(200);
  BEGIN
    SELECT branch_address
      INTO branch_address_
      FROM HASHINI_BRANCH_TAB
     WHERE branch_id = branch_id_;

    RETURN branch_address_;

  END get_branch_address;

END HASHINI_BRANCH_API;
/