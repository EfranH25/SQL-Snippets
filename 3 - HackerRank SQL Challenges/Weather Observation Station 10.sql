select distinct city
from station
where city not regexp 'a$|e$|i$|o$|u$'