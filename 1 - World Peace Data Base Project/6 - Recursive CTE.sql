USE world_peace;

-- gathers bundle information of merchandise
WITH merchandise_cte (merchanise_item_id, description, unit_price_decimal, alpha_sort, bundle_id)
	     AS (
		SELECT merchandise_item_id,
		       description,
		       unit_price / 100 AS unit_price_decimal,
		       description      AS alpha_sort,
		       bundle_id -- CAST(NULL AS CHAR(10))
		FROM merchandise_item
		UNION ALL

		SELECT d.merchandise_item_id                     AS merchandise_item_id,
		       CONCAT(" |__ ", d.description)            AS description,
		       NULL                                      AS unit_price_decimal,
		       CONCAT(c.description, " ", d.description) AS alpha_sort,
		       d.bundle_id
		FROM merchandise_item AS c,
		     merchandise_item AS d
		WHERE c.merchandise_item_id = d.bundle_id
	)

-- check recursive CTE
SELECT *
FROM merchandise_cte
ORDER BY alpha_sort