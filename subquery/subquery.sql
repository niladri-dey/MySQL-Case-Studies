-- Independent Subqueries
-- Scaler subquery- return only single value

-- Find the movie with highest profit(vs order by)
SELECT * FROM campusx.movies
WHERE (gross-budget) = (
	SELECT MAX(gross-budget) FROM campusx.movies
);
-- Find how many movies have a rating > avg of all movie rating 
	-- find the count of above average movies 
SELECT COUNT(*)
FROM campusx.movies
WHERE score >
	(SELECT AVG(score) 
    FROM campusx.movies)
;
-- Find the highest rated movie of 2000
SELECT * 
FROM campusx.movies
WHERE year = 2000
AND score =(SELECT MAX(score)
			FROM campusx.movies
			WHERE year = 2000)
;
-- Find the highest rated movie among all movies 
	-- whose number of votes > dataset avg votes
SELECT * 
FROM campusx.movies
WHERE score =(SELECT MAX(score)
			FROM campusx.movies
			WHERE votes >(SELECT AVG(votes) 
						FROM campusx.movies)	
			)
;


-- independent subquery-return single column multiple rows
-- Find all user who never order
SELECT name
FROM zomato.users
WHERE user_id NOT IN (SELECT DISTINCT(user_id)
						FROM zomato.orders)
;

-- find all the movies by top 3 director(in terms of total gross income)
SELECT *
FROM campusx.movies
WHERE director IN (SELECT director
					FROM campusx.movies
					GROUP BY director
					ORDER BY SUM(gross) DESC LIMIT 3)
;

-- Find all movies of all those actors whose filmography's avg rating>8.5
	-- (take 25000 votes as cuttoff)
SELECT * 
FROM campusx.movies
WHERE star IN (SELECT star
			FROM campusx.movies
			WHERE votes> 25000
			GROUP BY star
			HAVING AVG(score) > 8.5)
AND votes > 25000
;

-- Independent subquery - Return table 
-- Find the most profitable movie of each year
SELECT name,
(gross-budget) AS revenue
FROM campusx.movies
WHERE (year,gross-budget) IN (SELECT year,
							MAX(gross-budget)
							FROM campusx.movies
							GROUP BY year)
;

-- Find the highest rated movie of each gener votes cuttof 25000
SELECT name
FROM campusx.movies
WHERE (genre,score) IN (SELECT genre,MAX(score)
							FROM campusx.movies
							WHERE votes > 25000
							GROUP BY genre)
;
-- Find the highest gross income movies of top 5 actor/director combo
-- creating a temporary table top_combo
WITH top_combo AS (
SELECT star,
director,
MAX(gross)
FROM campusx.movies
GROUP BY star,director
ORDER BY MAX(gross) DESC LIMIT 5
)
SELECT name,
star,
director
FROM campusx.movies
WHERE (star,director,gross) IN (SELECT * FROM top_combo);

-- CORELATED SUBQUERY
-- 1.Find all the movies that have a rating higher than the average
	-- rating of movies in the same genre
SELECT *
FROM campusx.movies m1
WHERE score > (SELECT AVG(score)
				FROM campusx.movies m2 
                WHERE m2.genre=m1.genre)
;
-- 2.Find the favorite food of each customer
-- Approach 
	-- STEP1:Find out first that a perticuler user,how many time he/she
		-- order a perticuler item.
	-- STEP2: create a temporary table fav_food
WITH fav_food AS (SELECT 
				table2.user_id,
                table1.name,
				table4.f_name,
				COUNT(*) AS no_orders
				FROM zomato.users table1
				JOIN zomato.orders table2 
					ON table1.user_id = table2.user_id
				JOIN zomato.order_details table3
					ON table2.order_id = table3.order_id
				JOIN zomato.food table4
					ON table3.f_id = table4.f_id
				GROUP BY table1.name,table2.user_id,table4.f_name
)
SELECT * FROM fav_food f1
WHERE no_orders = (SELECT max(no_orders)
					FROM fav_food f2
                    WHERE f1.user_id=f2.user_id)
;
-- Usage with SELECT
-- 1.Get movie name genre,score and 
	-- average score of the movie genre

SELECT name,
genre,
score,
	ROUND((SELECT AVG(score) 
	FROM campusx.movies m2
    WHERE m2.genre = m1.genre ),2) AS avg_genre_score
FROM campusx.movies m1;

-- Usage with FROM
-- Find the average rating of resturent
SELECT r_name,avg_rating
FROM(SELECT r_id,ROUND(AVG(restaurant_rating),2) AS avg_rating
FROM zomato.orders
GROUP BY r_id) table1
JOIN zomato.restaurants table2
	ON table1.r_id = table2.r_id












