/*Write a SQL query to count the number of characters except for the spaces for each actor. Return the first 10 actors' name lengths along with their names.
List all Oscar awardees(Actors who received the Oscar award) with their full names and the length of their names.
Find the actors who have acted in the film ‘Frost Head.’
Pull all the films acted by the actor ‘Will Wilson.’
Pull all the films which were rented and return them in the month of May.
Pull all the films with ‘Comedy’ category*/

Use mavenmovies;
/*QUERY1*/
SELECT * FROM mavenmovies.actor;
Select trim(first_name),trim(last_name) from actor;
Select concat(first_name,last_name) as complete_name from actor;
Select concat(trim(first_name),trim(last_name)),length(concat(trim(first_name),trim(last_name))) as namelength from actor limit 10;

/*QUERY2*/
SELECT * FROM mavenmovies.actor_award;
Select first_name,last_name,length(concat(first_name,last_name)) as name_length,awards from actor_award where awards like '%Oscar%';

/*QUERY3*/
Select first_name,last_name,title from film inner join film_actor on film.film_id = film_actor.film_id inner join actor on 
film_actor.actor_id = actor.actor_id where title='Frost Head';

/*QUERY4*/
Select title,first_name,last_name from actor inner join film_actor on 
actor.actor_id = film_actor.actor_id inner join film on film_actor.film_id = film.film_id where first_name = 'Will' and last_name = 'wilson';

/*QUERY5*/
Select title,rental_date,return_date from rental inner join inventory on
rental.inventory_id = inventory.inventory_id inner join film_text on
inventory.film_id = film_text.film_id where month(rental_date) = 5 and month(return_date) = 5;


/*QUERY6*/
Select title,name from film inner join film_category on
film.film_id = film_category.film_id inner join category on 
film_category.category_id = category.category_id where name = 'comedy';