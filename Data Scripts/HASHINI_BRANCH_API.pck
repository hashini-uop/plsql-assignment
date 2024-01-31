CREATE OR REPLACE PACKAGE HASHINI_BRANCH_API AS
   PROCEDURE insert_branch(branch_name_ IN VARCHAR2, branch_address_ IN VARCHAR2, branch_manager_ IN VARCHAR2, total_warehouse_capacity_ IN NUMBER, company_reg_no_ IN NUMBER, container_id_ IN NUMBER);
   FUNCTION get_branch_name(branch_id_ IN NUMBER) RETURN VARCHAR2;
   FUNCTION get_remaining_capacity_in_containers(branch_id_ IN NUMBER) RETURN NUMBER;
END HASHINI_BRANCH_API;
/
CREATE OR REPLACE PACKAGE BODY HASHINI_BRANCH_API AS
PROCEDURE insert_branch(branch_name_ IN VARCHAR2, branch_address_ IN VARCHAR2, branch_manager_ IN VARCHAR2, total_warehouse_capacity_ IN NUMBER, company_reg_no_ IN NUMBER, container_id_ IN NUMBER) IS
branch_id_ NUMBER;
BEGIN
SELECT branch_id_seq.NEXTVAL INTO branch_id_ FROM dual; INSERT INTO HASHINI_BRANCH_TAB(branch_name, branch_address, branch_manager, total_warehouse_capacity, company_reg_no, container_id) VALUES(branch_name_, branch_address_, branch_manager_, total_warehouse_capacity_, company_reg_no_, container_id_);
END insert_branch;

PROCEDURE update_branch(branch_id_ IN NUMBER, branch_name_ IN VARCHAR2, branch_address_ IN VARCHAR2, branch_manager_ IN VARCHAR2, total_warehouse_capacity_ IN NUMBER) IS
    BEGIN
        UPDATE HASHINI_BRANCH_TAB
        SET branch_name = branch_name_, branch_address = branch_address_, branch_manager = branch_manager_, total_warehouse_capacity = total_warehouse_capacity_
        WHERE branch_id = branch_id_;
    END update_branch;

    PROCEDURE delete_branch(branch_id_ IN NUMBER) IS
    BEGIN
        DELETE FROM HASHINI_BRANCH_TAB WHERE branch_id = branch_id_;
    END delete_branch;

FUNCTION get_branch_name(branch_id_ IN NUMBER) RETURN VARCHAR2 IS
branch_name_ VARCHAR2(200);
BEGIN
SELECT branch_name INTO branch_name_ FROM HASHINI_BRANCH_TAB WHERE branch_id = branch_id_;

RETURN branch_name_;

END get_branch_name;

FUNCTION get_branch_address(branch_id_ IN NUMBER) RETURN VARCHAR2 IS
branch_address_ VARCHAR2(200);
BEGIN
SELECT branch_address INTO branch_address_ FROM HASHINI_BRANCH_TAB WHERE branch_id = branch_id_;

RETURN branch_address_;

END get_branch_address;

FUNCTION get_branch_manager(branch_id_ IN NUMBER) RETURN VARCHAR2 IS
branch_manager_ VARCHAR2(200);
BEGIN
SELECT branch_manager INTO branch_manager_ FROM HASHINI_BRANCH_TAB WHERE branch_id = branch_id_;

RETURN branch_manager_;

END get_branch_manager;

FUNCTION get_total_warehouse_capacity(branch_id_ IN NUMBER) RETURN NUMBER IS
total_warehouse_capacity_ VARCHAR2(200);
BEGIN
SELECT total_warehouse_capacity INTO total_warehouse_capacity_ FROM HASHINI_BRANCH_TAB WHERE branch_id = branch_id_;

RETURN total_warehouse_capacity_;

END get_total_warehouse_capacity;

FUNCTION get_remaining_capacity_in_containers(branch_id_ IN NUMBER) RETURN NUMBER IS
    total_container_capacity_ NUMBER;
    occupied_container_capacity_ NUMBER;
    remaining_container_capacity_ NUMBER;

    CURSOR container_capacity_cursor IS
      SELECT SUM(max_volume) AS total_capacity
      FROM HASHINI_CONTAINER_TAB
      WHERE branch_id = branch_id_;

    CURSOR occupied_capacity_cursor IS
      SELECT SUM(current_volume) AS occupied_capacity
      FROM HASHINI_CONTAINER_TAB
      WHERE branch_id = branch_id_;

  BEGIN
    -- Calculate total container capacity for the branch
    OPEN container_capacity_cursor;
    FETCH container_capacity_cursor INTO total_container_capacity_;
    CLOSE container_capacity_cursor;

    -- Calculate occupied container capacity within the branch
    OPEN occupied_capacity_cursor;
    FETCH occupied_capacity_cursor INTO occupied_container_capacity_;
    CLOSE occupied_capacity_cursor;

    -- Calculate remaining container capacity within the branch
    IF total_container_capacity_ IS NOT NULL AND occupied_container_capacity_ IS NOT NULL THEN
      remaining_container_capacity_ := total_container_capacity_ - occupied_container_capacity_;
    ELSE
      remaining_container_capacity_ := NULL; -- Handle no data or NULL cases
    END IF;

    RETURN remaining_container_capacity_;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL; -- Handle no data found exception
  END get_remaining_capacity_in_containers;

END HASHINI_BRANCH_API;
/
