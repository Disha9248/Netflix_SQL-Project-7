
-------------- NETFLIX DATA ANALYSIS -------------------


------------------ 15 BUSINESS PROBLEM ----------------



--  1. Count the number of Movies vs TV Shows
--  2. Find the most common rating for movies and TV shows
--  3. List all movies released in a specific year (e.g., 2020)
--  4. Find the top 5 countries with the most content on Netflix
--  5. Identify the longest movie
--  6. Find content added in the last 5 years
--  7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
--  8. List all TV shows with more than 5 seasons
--  9. Count the number of content items in each genre
-- 10. Find each year and the average numbers of content release in India on netflix. 
--     return top 5 year with highest avg content release!
-- 11. List all movies that are documentaries
-- 12. Find all content without a director
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--     the description field. Label content containing these keywords as 'Bad' and all other 
--     content as 'Good'. Count how many items fall into each category.



------------------ SOLUTION ----------------


SELECT *
FROM netflix;





--  1. Count the number of Movies vs TV Shows

SELECT type,
       COUNT(type) AS no_of_movies_shows
FROM netflix
GROUP BY type;





--  2. Find the most common rating for movies and TV shows

WITH common_rating AS (

	SELECT rating,
	       SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movie_count,
		   SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS show_count
	FROM netflix
	GROUP BY rating
	ORDER BY movie_count DESC
	LIMIT 1

)

SELECT rating
FROM common_rating;





--  3. List all movies released in a specific year (e.g., 2020)

WITH movie_release AS (

	SELECT type,
	       title,
	       release_year
	FROM netflix
	WHERE type = 'Movie' AND release_year = 2020

)

SELECT title
FROM movie_release;





--  4. Find the top 5 countries with the most content on Netflix

WITH most_content AS (

	SELECT 
		   COUNT(show_id) AS content,
		   UNNEST(STRING_TO_ARRAY(country,',')) AS countries
	FROM netflix
	GROUP BY countries
	ORDER BY content DESC
	LIMIT 5

)

SELECT countries
FROM most_content;





--  5. Identify the longest movie

WITH longest_movie AS (

	SELECT type,
		   title,
		   CAST(split_part(duration, ' ', 1) AS INTEGER) AS min
	FROM netflix
	WHERE type = 'Movie' AND duration IS NOT NULL
	ORDER BY min DESC
	LIMIT 1

)

SELECT title
FROM longest_movie;





--  6. Find content added in the last 5 years

SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';





--  7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

	SELECT title
	FROM netflix
    WHERE director LIKE '%Rajiv Chilaka%' 
	                         
 

			 

--  8. List all TV shows with more than 5 seasons

WITH list_of_tv_shows AS (

	SELECT type,
	       title,
		   CAST(SUBSTRING(duration,1,1) AS INTEGER) AS no_of_seasons
	FROM netflix
	WHERE type = 'TV Show' AND  CAST(SUBSTRING(duration,1,1) AS INTEGER) > 5

)

SELECT title
FROM list_of_tv_shows;





--  9. Count the number of content items in each genre

SELECT 
       TRIM(UNNEST(STRING_TO_ARRAY(listed_in,','))) AS genre,
       COUNT(show_id) AS no_of_content
FROM netflix
GROUP BY genre
ORDER BY no_of_content DESC;




-- 10. Find each year and the average numbers of content release in India on netflix. 
--     return top 5 year with highest avg content release!

WITH yearly_content AS (
    SELECT 
        EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
        COUNT(show_id) AS total_content
    FROM netflix
    WHERE country = 'India'
    GROUP BY year
)
SELECT 
    year,
    total_content,
    ROUND(total_content::numeric / (SELECT COUNT(DISTINCT year) FROM yearly_content), 2) AS avg_no_of_contents
FROM yearly_content
ORDER BY total_content DESC
LIMIT 5;




-- 11. List all movies that are documentaries

WITH list_of_movies AS (

	SELECT type,
	       title,
		   listed_in
	FROM netflix
	WHERE type = 'Movie' AND listed_in LIKE '%Documentaries%'

)

SELECT title
FROM list_of_movies;




-- 12. Find all content without a director

SELECT *
FROM netflix
WHERE director IS NULL;




-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

WITH movie_last10year AS (

	SELECT type,
	       title,
		   casts,
		   EXTRACT(YEAR FROM TO_DATE(date_added,'month-DD-YYYY')) AS years
	FROM netflix
	WHERE type = 'Movie' 
	      AND 
	      casts LIKE '%Salman Khan%' 
		  AND 
		  release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

)

SELECT title
FROM movie_last10year




-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

WITH top_actor AS (
	
	SELECT COUNT(show_id) AS movies_count,
	       UNNEST(STRING_TO_ARRAY(casts,',')) AS actors
	FROM netflix
	WHERE type = 'Movie' AND country = 'India'
	GROUP BY actors
	ORDER BY movies_count DESC
	LIMIT 10

)

SELECT actors
FROM top_actor;




-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--     the description field. Label content containing these keywords as 'Bad' and all other 
--     content as 'Good'. Count how many items fall into each category.

WITH field_categorize AS (

	SELECT type,
	       title,
		   description,
		   CASE
		       WHEN description LIKE '%kill%' OR  description LIKE '%violence%' 
			   THEN 'Bad' 
			   ELSE 'Good'
		   END AS content_label
	FROM netflix

)

SELECT content_label,
       COUNT(content_label) AS label_count
FROM field_categorize
GROUP BY content_label;



