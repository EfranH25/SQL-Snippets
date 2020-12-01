USE world_peace;

DROP FUNCTION IF EXISTS check_credit;

-- creates stored function that compares a customer's credit limit to some requested amount
DELIMITER $$
CREATE FUNCTION check_credit(requesting_customer_id CHAR(10),
                             request_amount INT)
	RETURNS BOOLEAN
	DETERMINISTIC
BEGIN
	RETURN
			(
				-- TODO --
				-- write an SQL to select the credit_limit
				-- from table customer
				-- for customer_id matching requesting_customer_id
				SELECT credit_limit
				FROM customer
				WHERE customer_id = requesting_customer_id
			) >= request_amount;

END $$
DELIMITER ;

-- check to see if the function works
SET @approved = check_credit("C000000001", 9000000);
SELECT @approved;

-- -------------------------------------------------

DROP FUNCTION IF EXISTS get_qoh_ftn;

-- creates stored function that retrieves quantity on hand of item requested
DELIMITER $$
CREATE FUNCTION get_qoh_ftn(
	request_item_id CHAR(10)
)
	RETURNS INT
	DETERMINISTIC

BEGIN
	RETURN
		(
			SELECT qoh
			FROM merchandise_item
			WHERE merchandise_item_id = request_item_id
		);
END $$
DELIMITER ;


-- check to see if the function works
SET @qty = get_qoh_ftn("KYOTOCBOOK");
SELECT @qty;