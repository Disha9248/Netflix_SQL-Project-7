# Netflix Movies and TV Shows Data Analysis using SQL

![Netflix logo](https://github.com/user-attachments/assets/b86caa86-9a9a-4c4b-952f-72adf537b336)


## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable 
insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's
objectives, business problems, solutions, findings, and conclusions.


## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.


## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)


## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```


## Business Problems 

 01. &ensp;Count the number of Movies vs TV Shows
 02. &ensp;Find the most common rating for movies and TV shows
 03. &ensp;List all movies released in a specific year (e.g., 2020)
 04. &ensp;Find the top 5 countries with the most content on Netflix
 05. &ensp;Identify the longest movie
 06. &ensp;Find content added in the last 5 years
 07. &ensp;Find all the movies/TV shows by director 'Rajiv Chilaka'!
 08. &ensp;List all TV shows with more than 5 seasons
 09. &ensp;Count the number of content items in each genre
 10. &ensp;Find each year and the average numbers of content release in India on netflix return top 5 year with highest avg content release!
 11. &ensp;List all movies that are documentaries
 12. &ensp;Find all content without a director
 13. &ensp;Find how many movies actor 'Salman Khan' appeared in last 10 years!
 14. &ensp;Find the top 10 actors who have appeared in the highest number of movies produced in India.
 15. &ensp;Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing
     &ensp;these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.



## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.
