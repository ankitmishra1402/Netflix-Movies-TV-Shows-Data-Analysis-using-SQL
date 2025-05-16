use pga50;
show tables;
# topic
# Netflix
# Student Depression 


select * from netflix1;
select * from student_depression1;

select distinct(title) from netflix1;
select distinct(type), count(type) as number from netflix1
group by type;

select type, title, release_year from netflix1
where release_year=2020 and country = "United States"
group by type,title, release_year;

-- 1.	Retrieve movies released in 2021:
-- to find all entries of type "Movie" with a release year of 2021.
select  *
from netflix1
where type = "movie" and release_year = "2021";


-- 2.	Find the total number of TV Shows:
-- Count the number of entries where the type is "TV Show".

select count(show_id) from netflix1
where type = "TV Show";

-- 3.	List all unique content ratings:
-- Retrieve all distinct values in the "rating" column.

select distinct(rating) from netflix1;

-- 4.	Find the top 5 countries with the most content:
-- Query to rank countries based on the number of entries.

select * from netflix1;

select country, count(show_id) as entries from netflix1
group by country
order by entries desc
limit 5;


-- 5.	Calculate the average duration of movies:
-- Extract the numerical duration from the "duration" column (e.g., "90 min") and compute the average.
select * from netflix1;
select  type,round(avg (duration),2) as duration_movie from netflix1
where type = "movie"
group by type;

-- 6.	Find shows or movies added in the last month:
-- Identify entries where the "date_added" is within the last 30 days.
select * from netflix1;
Select *
From netflix1;







 


select distinct(director) from netflix1;

-- 7.	List all directors with more than 5 entries:
-- Query to find directors who have contributed to more than five shows/movies.
select * from netflix1;

select director,count(show_id) as entries from netflix1 
group by director
having count(*) > 5;

-- 8.	Identify the most popular genre:
-- Based on the "listed_in" column, determine the genre that appears most frequently.

select * from netflix1;
select distinct(listed_in) from netflix1;

select  listed_in, count(listed_in) as most_popular 
from netflix1
group by listed_in
order by most_popular desc
limit 5;


-- 9.	Find all content available from a specific country (e.g., "United States"):
-- Query for all shows or movies originating from the given country.


select * from netflix1;
select * from netflix1 where country = "united states";


-- 10.	Retrieve the oldest content added:
-- Find the show or movie with the earliest "release_year".

select * from netflix1;
select * from netflix1
order by release_year asc
limit 1;

select * from netflix1
order by release_year desc
limit 1;

-- Complex SQL Problem Statements:
-- 1   Group the data by release_year and calculate the total number of movies and TV shows released each year. Identify the year with the highest total content release.
select * from netflix1;

select type,release_year , count(show_id) as content_release
from netflix1
group by type ,release_year
order by content_release desc;

-- 2.	Genre Analysis by Country:
-- For each country, list the most popular genre (based on the frequency of occurrence in the listed_in column).
select * from netflix1;

select country ,listed_in,count(listed_in) as frequency
from netflix1
group by country,listed_in
order by frequency desc;

-- 3.	Director with Diverse Genres:
-- Identify directors who have worked across more than 3 different genres.
select * from netflix1;

select director,listed_in, count(listed_in) as genres from netflix1
group by director,listed_in
having count(listed_in) >=3
order by genres desc;

-- 4.	Longest and Shortest Movies:
-- Find the longest and shortest movie durations, including their titles and countries of origin. (Extract the numerical part from the duration column for movies.)

select * from netflix1;
-- longest movie
 select title,country,max(duration) as longest_movie 
 from netflix1 
 where type = "movie"
 group by title,country
 order by longest_movie desc;
  
 -- shortest_movie
 select title,country,min(duration) as shortest_movie
 from netflix1
 where type = "movie"
 group by title,country
 order by shortest_movie ;
 
 SELECT  TITLE, COUNTRY , DURATION FROM NETFLIX1 WHERE TYPE ='MOVIE' ORDER BY DURATION DESC LIMIT 1;
 
 
-- 5.	Content Added Over Time:
-- Create a cumulative count of the content added over time, grouped by month and year, using the date_added column


select * from netflix1;
select
 extract(year from date_added) as year,
 extract(month from date_added) as month,
 count(*) as content_added,
 SUM(COUNT(*)) OVER (ORDER BY EXTRACT(YEAR FROM date_added), EXTRACT(MONTH FROM date_added)) AS cumulative_count
 from netflix1
 group by extract(year from date_added),
          extract(month from date_added)
order by year,month;

 
-- 6.	Multi-Country Content:
-- Find all entries with multiple countries listed in the country column (e.g., "United States, Canada").


select * from netflix1 where country = "canada";
select * from netflix1 where country = "united states";

select * from netflix1 where country in ("canada","united states");
 





-- 7.	Content by Region and Rating:
-- Analyze the distribution of content ratings (rating) by region. For example, show how many "TV-MA" or "PG-13" entries are available per country.

select * from netflix1;
select country,rating, count(show_id) as distribution
from netflix1
where rating in ("TV-MA","PG-13")
group by country,rating
order by distribution desc;

-- 8.	Average Release Gap Between Movies by Director:
-- Calculate the average gap (in years) between movies released by the same director.
select * from netflix1;

select director,avg(release_year) as avg_gap
from netflix1
where type = "movie"
group by director;


-- 9.	TV Shows with Multiple Seasons:
-- Find all TV shows that have more than one season (using the duration column) and list them with their directors and countries.
select * from netflix1;

select   type,director,country, count(show_id) as tv_show from netflix1
where type = "TV Show"
and duration > ("1 season")
group by  type,director,country
order by tv_show desc;







select * from netflix1;
-- 10.	Top 10 Most Frequent Directors:
-- Rank directors by the number of shows/movies they have directed and return the top 10.
select director, count(*) as frequent_director
from netflix1
group by director
order by frequent_director desc
limit 10;


-- 11.	Genre Co-occurrence Analysis:
-- Identify the most common pairs of genres that occur together in the listed_in column.



-- 12.	Content Rating Impact on Duration:
-- Analyze whether content rating (e.g., "TV-MA", "PG-13") has an impact on the average duration of movies.
select * from netflix1;

 select type, round(avg(duration),2) as duration_of_movie
 from netflix1
 where type = "movie"
 and rating in ("TV-MA","PG-13")
 group by  type
 order by duration_of_movie ;
 
 
 SELECT rating, ROUND(AVG(duration), 2) AS duration_of_movie
FROM netflix1
WHERE type = "movie"
  AND rating IN ("TV-MA", "PG-13")
GROUP BY rating
ORDER BY duration_of_movie;




 
 
 
 

-- 13.	Content with Missing Information:
-- Find all entries where any of the critical columns (director, country, date_added) have missing or placeholder values.

SELECT *
FROM netflix1
WHERE director = 'Not Given'
OR country = 'Not Given'
OR date_added IS NULL;





-- 14.	Country with the Oldest and Newest Releases:
-- Determine which country has the oldest and newest average release year for its content.
select * from netflix1;
-- oldest average release year
select country, avg(release_year) as oldest_year
from netflix1
group by country
order by oldest_year 
limit 1;

select country, avg(release_year) as latest_year
from netflix1
group by country
order by latest_year desc 
limit 1;

SELECT 
  (SELECT country FROM netflix1 GROUP BY country ORDER BY AVG(release_year) ASC LIMIT 1) AS oldest_country,
  (SELECT AVG(release_year) FROM netflix1 GROUP BY country ORDER BY AVG(release_year) ASC LIMIT 1) AS oldest_year,
  (SELECT country FROM netflix1 GROUP BY country ORDER BY AVG(release_year) DESC LIMIT 1) AS latest_country,
  (SELECT AVG(release_year) FROM netflix1 GROUP BY country ORDER BY AVG(release_year) DESC LIMIT 1) AS latest_year;


-- 15.	Content Added Near Release Year:
-- Identify shows or movies that were added to Netflix within 1 year of their release.
use pga50;

 show tables;
select * from student_depression1;



# 1 . Query to Identify Students with High Academic Pressure and Low Study Satisfaction
select distinct(study_satisfaction) from student_depression1;
select distinct(academic_pressure) from student_depression1;


select id,gender,age,city,profession,cgpa,academic_pressure,study_satisfaction
From student_depression1
where academic_pressure >= "4"
and study_satisfaction <= "2"
order by academic_pressure desc;
 
 
# query 2  Query to Calculate Average Sleep Duration by City
select * from student_depression1;
select distinct(city) from student_depression1;
select city,avg(sleep_duration) as sleep from student_depression1

group by city 
order by sleep desc;

# query 3  Query to Find Students with High CGPA but Low Sleep Duration
select distinct(cgpa) from student_depression1;
select distinct(sleep_duration) from student_depression1;


select id,gender,city,profession,
max(cgpa) as high_cgpa ,min(sleep_duration) as low_sleep from student_depression1
group by id,gender,city,profession
order by high_cgpa desc;

select id,gender,city,profession,sleep_duration from student_depression1
where cgpa <= "8"
and sleep_duration > "5"
order by cgpa desc;

# 4 Query to Count Students by Gender and Work Pressure Level
select * from student_depression1;

select gender,work_pressure, count(*)  as student_count from student_depression1
group by gender,work_pressure 
order by gender,work_pressure;


# query 5  Query to Check Correlation Indicators Between Sleep Duration and Study Satisfaction
select * from student_depression1;

select sleep_duration, avg(study_satisfaction) as satisfy from student_depression1
group by sleep_duration order by satisfy desc; 

# query 6 Query to List Students with Poor Dietary Habits and High Stress Levels
select * from student_depression1;
select distinct(dietary_habits) from student_depression1;
select distinct(financial_stress) from student_depression1;

select id,gender,city,dietary_habits,financial_stress from student_depression1
where dietary_habits in ("unhealthy","others")
and financial_stress >="4";

# query 7  Query to Get Overall Satisfaction Levels by Profession
select * from student_depression1;
select distinct(profession) from student_depression1;
select profession, 
avg(study_satisfaction) as study,
avg(job_satisfaction) as job 
from student_depression1
group by profession
order by study desc;
  

#  Query 8 to Find the Age Group Most Affected by Academic and Work Pressure

select * from  student_depression1;
select distinct(work_pressure) from student_depression1; #5
select distinct(academic_pressure) from student_depression1;
select age , 
avg(work_pressure) as avg_work,
avg(academic_pressure) as avg_academic
from student_depression1
group by age
order by avg_work desc;



#  Here are some intermediate-level SQL query questions based on the provided dataset:
# query 1 Retrieve all students from a  city  (varanasi,pune) who report low study satisfaction below 3 and high academic pressure above 4
select * from student_depression1;
select distinct(city)from student_depression1;
select distinct(academic_pressure) from student_depression1;

select id,gender,age,city,profession,academic_pressure,work_pressure 
from student_depression1
where city in ("varanasi","pune")
and academic_pressure >= "4"
and work_pressure < "3"
group by id,gender,age,city,profession,academic_pressure,work_pressure;



# query 2 Find the average CGPA of students grouped by their gender.

select * from student_depression1;
select gender,avg(cgpa) as avg_cgpa from student_depression1
group by gender
order by avg_cgpa desc;

# query 3 List the unique cities where students report the highest average work pressure.

SELECT City, AVG(Work_Pressure) AS Avg_Work_Pressure
FROM student_depression1
GROUP BY City
ORDER BY Avg_Work_Pressure DESC
limit 1;

# query 4 Identify students whose sleep duration is below the average sleep duration for their city.

select * from student_depression1;

select id,gender, city,profession,sleep_duration 
from student_depression1 as s1
 where profession = "student"
 and sleep_duration <  (select avg(sleep_duration) from student_depression1 as s2
 where s2.city = s1.city );
 
 
 use pga50;


# query 5 Determine the total number of students in each profession who have a job satisfaction rating above a certain threshold.
select * from student_depression1;
select distinct(job_satisfaction) from student_depression1;

select profession,count(*)  as number_student
from student_depression1
 where profession = "student"
 and job_satisfaction > "3"
 group by profession ;

# query 6 List the IDs and dietary habits of students who report both poor academic above 3 and job satisfaction below 3

select * from student_depression1;
select id,dietary_habits, academic_pressure,job_satisfaction, count(*) as  student from student_depression1
where academic_pressure <= 3
and job_satisfaction >= 3
group by id,dietary_habits,academic_pressure,job_satisfaction;
# query 7 Rank students based on their CGPA in descending order and include their age, gender, and city in the results.

select id ,age,gender,city, cgpa ,
rank () over(order by cgpa desc) as student_rank
from student_depression1;

# query 8 Find the top 5 students with the highest CGPA who also report sleeping less than 5 hours per day.
select * from student_depression1;
select  id,gender,city,profession,cgpa
from student_depression1
where sleep_duration = "less than 5 hours"
and profession = "student"
group by id,gender,city,profession,cgpa
order by cgpa desc
limit 5;

# query 9 Count the number of students in each age group who report good dietary habits (healthy) and study satisfaction above 4.
select * from student_depression1;
select id, age ,dietary_habits,count(id) as number_students from student_depression1
where dietary_habits ="healthy"
and job_satisfaction > 3
group by id,age,dietary_habits
order by number_students desc;

# query 10 Identify the correlation between work pressure and academic pressure by calculating their average values grouped by age.

select age,
avg(work_pressure) as avg_work,
avg(academic_pressure) as avg_academic 
from student_depression1
group by age;

# query 11 List all students who have a CGPA above 8.0 and work in a profession(teacher) with the highest average job satisfaction.
select distinct(cgpa) from student_depression1;
select distinct(profession) from student_depression1;
select distinct(job_satisfaction) from student_depression1;

select id,cgpa,job_satisfaction,profession, avg(job_satisfaction) as highest_job from student_depression1
where cgpa >= "8"
group by id,cgpa,job_satisfaction,profession
order by highest_job desc;


# query 12 Retrieve the total number of students grouped by gender who report "unhealthy" dietary habits and "less than 5 hours" of sleep.
select * from student_depression1;
select distinct(dietary_habits) from student_depression1;
select distinct(sleep_duration) from student_depression1;

select gender,dietary_habits,sleep_duration,count(id) as students from student_depression1
where dietary_habits = "unhealthy"
and sleep_duration = "less than 5 hours"
group by gender,dietary_habits,sleep_duration
order by students desc;

# query 13 Find the city where students have the lowest average study satisfaction and compare it with their average CGPA.

select city, 
avg (study_satisfaction) as avg_satisfaction, 
avg (cgpa) as avg_cgpa
from student_depression1
where profession = "student"
group by city
order by avg_satisfaction asc
limit 1;


# query 14List the top three cities where students degree (bba) the highest work pressure and sleep the least.
select distinct(work_study_hours) from student_depression1;
select distinct(sleep_duration) from student_depression1;
select distinct(degree) from student_depression1;
select distinct(work_pressure) from student_depression1;

select city from student_depression1
where profession = "student"
and degree = "class 12"
and sleep_duration = "5-6 hours"
group by city
limit 3;



# query15 Determine the percentage of students in each profession who report excellent (10/10) job satisfaction.

SELECT profession,
    COUNT(CASE WHEN job_satisfaction = 10 THEN 1 END) * 100.0 / COUNT(*) AS percentage_excellent_job_satisfaction
FROM 
    student_depression1
GROUP BY 
    profession;

SELECT 
  profession, 
  (SUM(IF(job_satisfaction = 10, 1, 0)) * 100.0 / COUNT(*)) AS excellent_job_satisfaction_percentage
FROM 
  student_depression1
GROUP BY 
  profession;

