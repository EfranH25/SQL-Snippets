USE world_peace;

-- aggregation functions --
-- get number of customers
SELECT Count(*)
FROM customer;

-- get highest number of items on hand
SELECT max(qoh)
FROM merchandise_item;

-- get min unit price of merchandise item
SELECT min(unit_price) / 100
FROM merchandise_item;

-- find the sum of the column quantity in the table customer_order_line_item
SELECT sum(quantity)
FROM customer_order_line_item;

-- Non-aggregate functions --
-- compare formatting of indian currency to spanish currency (India and Spain format their currency in different ways)
SELECT format(unit_price / 100, 2, 'es_IN') AS unit_price_decimal
FROM merchandise_item;

SELECT format(unit_price / 100, 2, 'es_ES') AS unit_price_decimal
FROM merchandise_item;

-- get character length of each description
SELECT concat(char_length(description), ' chars')
FROM merchandise_item;

-- Get the average unit_price in the table merchandise_item (divided by 100) with Indian English formatting and rupee currency
SELECT concat('₹', format(avg(unit_price)/ 100, 2, 'en_IN'))
FROM merchandise_item;


