#Your turn now! Show the number of projects which reached the minimal_amount.
WITH proj_rev AS (
	SELECT project_id,
	       SUM(amount) AS sum_amount
	FROM project
		     JOIN donation
		          ON donation.project_id = project.id
	GROUP BY project_id, minimal_amount
	HAVING SUM(amount) > minimal_amount
)
SELECT COUNT(project_id)
FROM proj_rev;

