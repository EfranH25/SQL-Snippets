USE world_peace;

-- decrease qoh (quantity on hand) after inserting a new line item
-- into the table customer_order_line_item
DROP TRIGGER IF EXISTS decrease_inventory_tgr;
DELIMITER $$
CREATE TRIGGER decrease_inventory_tgr
	AFTER INSERT
	ON customer_order_line_item

	FOR EACH ROW
BEGIN
	UPDATE merchandise_item
	SET qoh = qoh - new.quantity
	WHERE merchandise_item_id = new.merchandise_item_id;
END $$
DELIMITER ;

-- check qoh (quantity on hand) before inserting a new line item
-- into the table customer_order_line_item
DROP TRIGGER IF EXISTS inventory_check_tgr;
DELIMITER $$
CREATE TRIGGER inventory_check_tgr

	BEFORE INSERT
	ON customer_order_line_item
	FOR EACH ROW

BEGIN
	-- using stored procedure
	DECLARE inventory INT;
	CALL get_qoh_stp(new.merchandise_item_id, inventory);
	IF (inventory < new.quantity) THEN
		SIGNAL SQLSTATE '45000'
		SET message_text = "Insufficient inventory";
	END IF;
END $$
DELIMITER ;

-- check to see if it works

UPDATE merchandise_item
SET qoh = 10
WHERE merchandise_item_id = "ITALYPASTA";

DELETE
FROM customer_order_line_item
WHERE customer_order_id = "D000000003"
  AND merchandise_item_id = "ITALYPASTA";

INSERT INTO customer_order_line_item
SET customer_order_id   = "D000000003",
    merchandise_item_id = "ITALYPASTA",
    quantity            = 20;

INSERT INTO customer_order_line_item
SET customer_order_id   = "D000000003",
    merchandise_item_id = "ITALYPASTA",
    quantity            = 2;