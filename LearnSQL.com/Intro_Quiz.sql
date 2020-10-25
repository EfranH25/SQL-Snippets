# Find all recipes, but select only name, rating, and cook_time for recipe. Sort records in order of descending rating,
# with names of equally rated recipes in alphabetical (ascending) order.

select name, rating, cook_time
from recipe
order by rating desc, name;

# For each ingredient type, find the number of ingredients. Name the columns type and number_of_ingredients.
select type, count(*) as number_of_ingredients
from ingredient
group by type;

# The preparation of recipes takes some time. Find the shortest and longest cooking times. In the result table, display
# the shortest cooking time (name column as min_time), and the longest cooking time (name column as max_time).

select min(cook_time) as min_time , max(cook_time) as max_time
from recipe asw

# How many recipes are assigned to each preference rating?
# Only select ratings with the number of recipes higher than 1. Name the columns rating and number_of_recipes.
select rating, count(*) as number_of_recipes
from recipe
group by rating
having count(*)>1;

# Each recipe contains a different number of ingredients. Find the number of ingredients in each recipe. Select only
# those recipes which have fewer than 5 ingredients. Display the recipe name and number of ingredients
# (name the column number_of_ingredients).
select x.name, y.number_of_ingredients
from recipe x
join
(
select recipe_id, count(*) as number_of_ingredients
from recipe_ingredients
group by recipe_id
having count(*) < 5
  ) y
  on x.id = y.recipe_id;

# A lot of people don't have much time to cook. Get the recipes which have cooking times below average for all recipes
# in the recipe table. Return the names and cooking times for those recipes.
select name, cook_time
from recipe
where cook_time < (
select avg(cook_time)
  from recipe
);

# Retrieve ids of ingredients which are not included in table recipe_ingredients.
select id
from ingredient x
where x.id not in (
select ingredient_id
  from recipe_ingredients
);

# A lot of people like sweets very much. We're willing to bet you do, too! Which recipes include sweets? Get names of
# recipes which include at least one ingredient of type 'sweets', but whose ingredient name is not 'sugar'.
select x.name
from recipe x
join
(select recipe_id
from recipe_ingredients
where ingredient_id in (
select id from ingredient
where type = 'sweets' and name != 'sugar')) y
on x.id = y.recipe_id;