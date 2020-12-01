USE world_peace;

-- Simple CTE
WITH customer_CTE(id, name) AS
    (
        SELECT customer_id, customer_name
        FROM customer
        ORDER BY customer_name
    )
SELECT *
FROM customer_cte;

-- Complex CTE
WITH order_line_item_cte (new_name, new_order_id, new_description, order_qty, new_unit_price, line_subtotal) AS
	     (
		     SELECT customer.customer_name,
		            customer_order_line_item.customer_order_id,
		            merchandise_item.description,
		            customer_order_line_item.quantity,
		            merchandise_item.unit_price / 100                                     AS "unit_price_decimal",
		            customer_order_line_item.quantity * merchandise_item.unit_price / 100 AS "line_total"
		     FROM customer_order_line_item,
		          customer_order,
		          customer,
		          merchandise_item
		     WHERE customer_order_line_item.merchandise_item_id = merchandise_item.merchandise_item_id
			   AND customer_order.customer_id = customer.customer_id
			   AND customer_order_line_item.customer_order_id = customer_order.customer_order_id
		     ORDER BY customer_name,
		              customer_order_line_item.customer_order_id,
		              merchandise_item.description
	     )
SELECT *
FROM order_line_item_cte;


