# Find all recipes, but select only name, rating, and cook_time for recipe. Sort records in order of descending rating,
# with names of equally rated recipes in alphabetical (ascending) order.
SELECT name, rating, cook_time
FROM recipe
ORDER BY rating DESC, name;

# For each ingredient type, find the number of ingredients. Name the columns type and number_of_ingredients.
SELECT type, count(*) AS number_of_ingredients
FROM ingredient
GROUP BY type;

# The preparation of recipes takes some time. Find the shortest and longest cooking times. In the result table, display
# the shortest cooking time (name column as min_time), and the longest cooking time (name column as max_time).

SELECT min(cook_time) AS min_time, max(cook_time) AS max_time
FROM recipe asw

# How many recipes are assigned to each preference rating?
# Only select ratings with the number of recipes higher than 1. Name the columns rating and number_of_recipes.
SELECT rating, count(*) AS number_of_recipes
FROM recipe
GROUP BY rating
HAVING count(*) > 1;

# Each recipe contains a different number of ingredients. Find the number of ingredients in each recipe. Select only
# those recipes which have fewer than 5 ingredients. Display the recipe name and number of ingredients
# (name the column number_of_ingredients).
SELECT x.name, y.number_of_ingredients
FROM recipe x
	     JOIN
     (
	     SELECT recipe_id, count(*) AS number_of_ingredients
	     FROM recipe_ingredients
	     GROUP BY recipe_id
	     HAVING count(*) < 5
     ) y
     ON x.id = y.recipe_id;

# A lot of people don't have much time to cook. Get the recipes which have cooking times below average for all recipes
# in the recipe table. Return the names and cooking times for those recipes.
SELECT name, cook_time
FROM recipe
WHERE cook_time < (
	SELECT avg(cook_time)
	FROM recipe
);

# Retrieve ids of ingredients which are not included in table recipe_ingredients.
SELECT id
FROM ingredient x
WHERE x.id NOT IN (
	SELECT ingredient_id
	FROM recipe_ingredients
);

# A lot of people like sweets very much. We're willing to bet you do, too! Which recipes include sweets? Get names of
# recipes which include at least one ingredient of type 'sweets', but whose ingredient name is not 'sugar'.
SELECT x.name
FROM recipe x
	     JOIN
     (SELECT recipe_id
      FROM recipe_ingredients
      WHERE ingredient_id IN (
	      SELECT id
	      FROM ingredient
	      WHERE type = 'sweets'
		    AND name != 'sugar')) y
     ON x.id = y.recipe_id;
