-- inventory ile rental birleşimi

SELECT *
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id;

SELECT *
FROM rental;

SELECT *
FROM inventory; 

SELECT *
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id;

SELECT *
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id;


---- SQL DAY 2 is OVER. 