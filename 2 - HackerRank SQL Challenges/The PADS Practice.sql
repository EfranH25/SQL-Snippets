select first_name, concat(first_name, ' (', left(first_name, 1), ')') as new
from customers
order by first_name;

select first_name, count(*) as count
from customers
group by first_name
order by count;

select concat('There are a total of ', count(first_name), ' ', first_name,'s')
from customers
group by first_name
order by count(first_name);