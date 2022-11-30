USE sakila;

-- 1. In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT *
FROM actor
;
SELECT first_name "First Name", last_name "Last Name" 
FROM actor
;

SELECT * FROM actor 
WHERE last_name IN
(SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1)
; 

-- 2. Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1
;


-- 3. Using the rental table, find out how many rentals were processed by each employee.

SELECT rental_id
FROM rental
;
SELECT count(DISTINCT rental_id) from rental
WHERE staff_id= 1;
SELECT count(DISTINCT rental_id) from rental
WHERE staff_id= 2;


-- 4. Using the film table, find out how many films were released each year.

SELECT DISTINCT release_year FROM film
;
select film_id
from film
WHERE release_year = "2006";


-- 5. Using the film table, find out for each rating how many films were there.

-- select distinct rating
-- from film;

-- select count(rating)
-- from film
-- WHERE rating = "PG"
-- ;
-- select count(rating)
-- from film
-- WHERE rating = "G"
-- ;
-- select count(rating)
-- from film
-- WHERE rating = "NC-17"
-- ;
-- select count(rating)
-- from film
-- WHERE rating = "PG-13"
-- ;
-- select count(rating)
-- from film
-- WHERE rating = "R"
-- ;

SELECT rating, COUNT(rating) AS "Rating description" 
FROM film
GROUP BY rating 
;

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT length, rating, round(AVG(length),2) AS "avg_length"
FROM film
GROUP BY rating;

-- 7. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT avg(length) as avgl, rating 
FROM film
GROUP BY rating
HAVING avgl > 120
;

-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.


SELECT SUM(ISNULL(length)) FROM film;
SELECT length From film where length <> 0;

-- SELECT length, title
-- FROM film
-- WHERE length <> 0
-- GROUP BY length desc
-- ;

SELECT length,	title, 
RANK () OVER ( ORDER BY length DESC) AS "rank"
FROM film
WHERE length IS NOT NULL AND length != 0
;


    
    
