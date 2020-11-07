# Show the number of projects which reached the minimal_amount.
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

# Show the first and last name of authors with the number of not yet founded projects they created.
# Show projects_count as the third column. Show the authors in descending order of projects_count.
WITH tempor AS (
	SELECT p.author_id,
	       d.project_id,
	       p.minimal_amount,
	       sum(d.amount) AS donations
	FROM donation d
		     JOIN project p
		          ON d.project_id = p.id
	GROUP BY p.author_id, d.project_id, p.minimal_amount
)

SELECT first_name,
       last_name,
       COUNT(project_id) AS projects_count
FROM tempor
	     JOIN supporter
	          ON tempor.author_id = supporter.id
WHERE tempor.donations < minimal_amount
GROUP BY first_name, last_name
ORDER BY projects_count DESC;

# Count the number of projects for which the total sum of donations exceeds 50% of the minimal_amount.
WITH tempor (proj_id, donation_sum, min_amount) AS (
	SELECT p.id,
	       sum(d.amount),
	       p.minimal_amount
	FROM donation d
		     JOIN project p
		          ON p.id = d.project_id
	GROUP BY p.id, minimal_amount
)

SELECT count(proj_id)
FROM tempor
WHERE donation_sum > (min_amount * .5);
# Alternative Answer
WITH temporary (my_sum) AS (
	SELECT SUM(amount)
	FROM donation
		     JOIN project
		          ON donation.project_id = project.id
	GROUP BY project.id, minimal_amount
	HAVING SUM(amount) > 0.5 * minimal_amount
)
SELECT COUNT(my_sum)
FROM temporary;

# In January 2016, supporters who donated at least 10% of the minimal_amount in one donation received a gift.
# In February 2016, they had to donate 20% of the minimal_amount to get the same gift. Show columns amount and donated
# for all such donations from January and February for which a gift was awarded.
WITH jan_don (amount, donated) AS (
	SELECT d.amount,
	       d.donated
	FROM donation d
		     JOIN project p
		          ON p.id = d.project_id
	WHERE d.donated >= '2016-01-01'
	  AND d.donated <= '2016-01-31'
	  AND d.amount >= (p.minimal_amount * .1)
),
     feb_don (amount, donated) AS (
	     SELECT d.amount,
	            d.donated
	     FROM donation d
		          JOIN project p
		               ON p.id = d.project_id
	     WHERE d.donated >= '2016-02-01'
		   AND d.donated <= '2016-02-29'
		   AND d.amount >= (p.minimal_amount * .2)
     )

SELECT amount, donated
FROM jan_don
UNION
(
	SELECT amount, donated
	FROM feb_don);

# Show together two groups of users:
# those who donated more than $200 altogether,
# those who donated at least twice.
# For each of them, show id, first_name and last_name.
WITH done_200 (id, first_name, last_name) AS (
	SELECT s.id,
	       s.first_name,
	       s.last_name
	FROM supporter s
		     JOIN donation d
		          ON d.supporter_id = s.id
	GROUP BY s.id, s.first_name, s.last_name
	HAVING sum(d.amount) > 200
),
     done_twice (id, first_name, last_name) AS (
	     SELECT s.id,
	            s.first_name,
	            s.last_name
	     FROM supporter s
		          JOIN donation d
		               ON d.supporter_id = s.id
	     GROUP BY s.id, s.first_name, s.last_name
	     HAVING count(d.id) > 1
     )

SELECT id,
       first_name,
       last_name
FROM done_200
UNION ALL
(
	SELECT id,
	       first_name,
	       last_name
	FROM done_twice
);

# For each person who made donations in 'music' or 'traveling' categories, show three columns:
# supporter_id,
# min_music – that person's minimum donation amount in the music category,
# max_traveling – that person's maximum donation amount in the traveling category.
WITH total_number AS (
	SELECT DISTINCT supporter_id
	FROM donation d
		     JOIN project p
		          ON d.project_id = p.id
	WHERE category IN ('music', 'traveling')
),

     music AS (
	     SELECT supporter_id,
	            MIN(amount)
	     FROM donation d
		          JOIN project p
		               ON d.project_id = p.id
	     WHERE category IN ('music')
	     GROUP BY 1
     ),

     traveling AS (
	     SELECT supporter_id,
	            MAX(amount)
	     FROM donation d
		          JOIN project p
		               ON d.project_id = p.id
	     WHERE category IN ('traveling')
	     GROUP BY 1
     )

SELECT t.supporter_id,
       m.min  AS min_music,
       tr.max AS max_traveling
FROM total_number t
	     LEFT JOIN music m
	               ON m.supporter_id = t.supporter_id
	     LEFT JOIN traveling tr
	               ON tr.supporter_id = t.supporter_id;

# Show the average total amount raised in successful projects that had more than 10 donations.
WITH temp AS (
	SELECT project.id,
	       SUM(amount)                 AS sum_amount,
	       minimal_amount,
	       COUNT(DISTINCT donation.id) AS count_donations
	FROM project
		     JOIN donation
		          ON donation.project_id = project.id
	GROUP BY project.id, minimal_amount
	HAVING SUM(amount) > minimal_amount
)

SELECT AVG(sum_amount)
FROM temp
WHERE count_donations > 10;

# Among successful projects, those that raised 100% to 150% of the minimum amount are good projects, whereas those that
# raised more than 150% are great projects. Show the number of projects along with a string representing how good the
# project is (good projects or great projects) name the column tag.
WITH temp AS (
	SELECT project.id,
	       SUM(amount)                 AS sum_amount,
	       minimal_amount,
	       COUNT(DISTINCT donation.id) AS count_donations
	FROM project
		     JOIN donation
		          ON donation.project_id = project.id
	GROUP BY project.id, minimal_amount
	HAVING SUM(amount) > minimal_amount
	   AND SUM(amount) <= 1.5 * minimal_amount
),
     temp2 AS (
	     SELECT project.id,
	            SUM(amount)                 AS sum_amount,
	            minimal_amount,
	            COUNT(DISTINCT donation.id) AS count_donations
	     FROM project
		          JOIN donation
		               ON donation.project_id = project.id
	     GROUP BY project.id, minimal_amount
	     HAVING SUM(amount) > 1.5 * minimal_amount
     )
SELECT COUNT(*),
       'good projects' AS tag
FROM temp
UNION ALL
SELECT COUNT(*),
       'great projects' AS tag
FROM temp2;