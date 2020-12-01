USE world_peace;

DROP PROCEDURE IF EXISTS customer_roster_stp;

-- creats stored procedure that gets the entire customer roster ordered by name
DELIMITER $$
CREATE PROCEDURE customer_roster_stp()
BEGIN
	SELECT *
	FROM customer
	ORDER BY customer_name;
END $$
DELIMITER ;

-- check to see if it works
CALL customer_roster_stp();

-- --------------

DROP PROCEDURE IF EXISTS get_qoh_stp;

-- created stored procedure that gets quantity at hand of requested item
DELIMITER $$
CREATE PROCEDURE get_qoh_stp(IN request_item_id CHAR(10),
                             OUT qoh_to_return INT)
BEGIN
	SELECT qoh INTO qoh_to_return
	FROM merchandise_item
	WHERE merchandise_item_id = request_item_id;
END$$
DELIMITER ;

SET @qty = 0;
CALL get_qoh_stp("ITALYPASTA", @qty);
SELECT @qty;