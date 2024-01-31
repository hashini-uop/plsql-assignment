CREATE OR REPLACE PACKAGE HASHINI_FOOD_ITEM_API AS
   PROCEDURE insert_food_item(item_id_ IN NUMBER DEFAULT NULL, item_name_ IN VARCHAR2, available_qty_ IN NUMBER, scrapped_qty_ IN NUMBER, reserved_qty_ IN NUMBER);
END HASHINI_FOOD_ITEM_API;
/
CREATE OR REPLACE PACKAGE BODY HASHINI_FOOD_ITEM_API AS
  PROCEDURE insert_food_item(
    item_id_ IN NUMBER DEFAULT NULL,
    item_name_ IN VARCHAR2,
    available_qty_ IN NUMBER,
    scrapped_qty_ IN NUMBER,
    reserved_qty_ IN NUMBER
  ) IS
    generated_item_id NUMBER;
  BEGIN
    IF item_id_ IS NULL THEN
      SELECT item_id_seq.NEXTVAL INTO generated_item_id FROM dual;
    ELSE
      generated_item_id := item_id_;
    END IF;

    INSERT INTO HASHINI_FOOD_ITEM_TAB (
      item_id,
      item_name,
      available_qty,
      scrapped_qty,
      reserved_qty
    ) VALUES (
      generated_item_id,
      item_name_,
      available_qty_,
      scrapped_qty_,
      reserved_qty_
    );
  END insert_food_item;
END HASHINI_FOOD_ITEM_API;
/
