use sakila;

#Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


#Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

#What is the average running time of films by category?

SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id;

#Which film categories are longest?

SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id
ORDER BY avg_running_time DESC;

#Display the most frequently rented movies in descending order.

SELECT f.title AS movie_title, COUNT(r.rental_id) AS num_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY num_rentals DESC;

#List the top five genres in gross revenue in descending order.

SELECT c.name AS genre, SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY total_revenue DESC
LIMIT 5;

#Is "Academy Dinosaur" available for rent from Store 1?

SELECT f.title AS movie_title, s.store_id, COUNT(r.rental_id) AS num_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1 AND r.return_date IS NULL
GROUP BY f.film_id, s.store_id;
#Yes it is.





