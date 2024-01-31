CREATE OR REPLACE PACKAGE HASHINI_STORAGE_API AS
    PROCEDURE insert_storage_record(
        status_ VARCHAR2,
        container_id_ NUMBER,
        branch_id_ NUMBER,
        item_id_ NUMBER,
        company_reg_no_ NUMBER
    );
    PROCEDURE update_storage(container_id_ IN NUMBER,
                           branch_id_ IN NUMBER,
                           company_reg_no_ IN NUMBER,
                           item_id_ IN NUMBER,
                           status_ IN VARCHAR2);
    PROCEDURE delete_storage(container_id_ IN NUMBER,
                           branch_id_ IN NUMBER,
                           company_reg_no_ IN NUMBER,
                           item_id_ IN NUMBER);
END HASHINI_STORAGE_API;
/
CREATE OR REPLACE PACKAGE BODY HASHINI_STORAGE_API AS
    PROCEDURE insert_storage_record(
        status_ VARCHAR2,
        container_id_ NUMBER,
        branch_id_ NUMBER,
        item_id_ NUMBER,
        company_reg_no_ NUMBER
    ) IS
    BEGIN
        INSERT INTO HASHINI_STORAGE_TAB (status, container_id, branch_id, item_id, company_reg_no)
        VALUES (status_, container_id_, branch_id_, item_id_, company_reg_no_);
    END insert_storage_record;


    PROCEDURE update_storage(container_id_ IN NUMBER,
                           branch_id_ IN NUMBER,
                           company_reg_no_ IN NUMBER,
                           item_id_ IN NUMBER,
                           status_ IN VARCHAR2) IS
  BEGIN
    UPDATE HASHINI_STORAGE_TAB
    SET status = status_
    WHERE container_id = container_id_
      AND branch_id = branch_id_
      AND company_reg_no = company_reg_no_
      AND item_id = item_id_;
  END update_storage;

  PROCEDURE delete_storage(container_id_ IN NUMBER,
                           branch_id_ IN NUMBER,
                           company_reg_no_ IN NUMBER,
                           item_id_ IN NUMBER) IS
  BEGIN
    DELETE FROM HASHINI_STORAGE_TAB
    WHERE container_id = container_id_
      AND branch_id = branch_id_
      AND company_reg_no = company_reg_no_
      AND item_id = item_id_;
  END delete_storage;
END HASHINI_STORAGE_API;
/
