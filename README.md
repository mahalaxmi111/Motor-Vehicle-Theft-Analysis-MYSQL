# Motor-Vehicle-Theft-Analysis-MYSQL
## Project Overview
This project analyzes motor vehicle theft data from the New Zealand police department's vehicle of interest database. The primary goal is to identify patterns and trends in vehicle thefts to assist law enforcement and inform policy decisions.

# Tools & Library Used
![MySQL](https://github.com/user-attachments/assets/7e48fb90-2620-4a61-9583-a8950c9f2242)


https://www.mysql.com/
## SQL Scripts
The project includes SQL scripts for creating the database and inserting sample data:
- ** Database Creation: The script initializes the database and creates necessary tables. See -<a href="https://github.com/mahalaxmi111/Motor-Vehicle-Theft-Analysis-MYSQL/blob/main/create_stolen_vehicles_db.sql">create_stolen_vehicles_db.sql</a> for details.
- **  Data Insertion and Analysis: The analysis queries are included in -<a href="https://github.com/mahalaxmi111/Motor-Vehicle-Theft-Analysis-MYSQL/blob/main/create_stolen_vehicles_db.sql">analysisstolenVehicle.sql</a>.

## Database Structure
The project utilizes a MySQL database with the following schema:
1.stolen_vehicles
-- Columns:
vehicle_id (INT, Primary Key)
vehicle_type (VARCHAR)
make_id (INT)
model_year (INT)
vehicle_desc (VARCHAR)
color (VARCHAR)
date_stolen (DATE)
location_id (VARCHAR)

2.locations
--Columns:
location_id (INT, Primary Key)
region (VARCHAR)
country (VARCHAR)
population (INT)
density (DECIMAL)

3.make_details
--Columns:
make_id (INT, Primary Key)
make_name (VARCHAR)
make_type (VARCHAR)

# Query Task
#Daily Patterns
#1.On which day of the week are vehicles most and least often stolen?
SELECT 
    DAYNAME(date_stolen) AS day_of_week,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    DAYNAME(date_stolen)
ORDER BY 
    theft_count DESC;

#2.How does the distribution of thefts vary between weekdays and weekends?
SELECT 
    CASE 
        WHEN DAYOFWEEK(date_stolen) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    day_type
ORDER BY 
    theft_count DESC;
    
#3.What is the most common time of the month for vehicle thefts?
SELECT 
    MONTHNAME(date_stolen) AS month,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    MONTH(date_stolen), MONTHNAME(date_stolen)
ORDER BY 
    theft_count DESC;
    
    
#Vehicle Type and Characteristics
#4.What are the most and least stolen vehicle types overall?
SELECT 
    vehicle_type,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type
ORDER BY 
    theft_count DESC;

#5.Are there specific vehicle makes or models that are more commonly stolen?
SELECT 
    md.make_name,
    sv.vehicle_desc AS model,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles sv
JOIN 
    make_details md ON sv.make_id = md.make_id
GROUP BY 
    md.make_name, sv.vehicle_desc
ORDER BY 
    theft_count DESC;


#6.What is the distribution of stolen vehicles by their production year?
SELECT 
    model_year AS production_year,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    model_year
ORDER BY 
    production_year DESC;
    
#7.How does the average vehicle age vary across vehicle types (e.g., sedans, SUVs, trucks)?
SELECT 
    vehicle_type,
    AVG(YEAR(CURDATE()) - model_year) AS average_age
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type
ORDER BY 
    average_age DESC;


    
    
#8.Which colors of vehicles are most and least commonly stolen?
SELECT 
    color,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    color
ORDER BY 
    theft_count DESC;
    
#9.Are older vehicles more likely to be stolen than newer ones?
SELECT 
    CASE 
        WHEN YEAR(CURDATE()) - model_year > 10 THEN 'Older than 10 years'
        ELSE '10 years or newer'
    END AS vehicle_age_group,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_age_group
ORDER BY 
    theft_count DESC;
    
#Regional Insights
#10.Which regions report the highest and lowest vehicle thefts?
SELECT 
    l.region,
    COUNT(s.vehicle_id) AS total_thefts
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    total_thefts DESC;

    
#11.What is the distribution of stolen vehicle types across regions?
SELECT 
    l.region,
    sv.vehicle_type,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles sv
JOIN 
    locations l ON sv.location_id = l.location_id
GROUP BY 
    l.region, sv.vehicle_type
ORDER BY 
    l.region, theft_count DESC;

    
#12.Are there regional patterns in the age or color of stolen vehicles?
SELECT 
    l.region,
    AVG(YEAR(CURDATE()) - sv.model_year) AS average_age
FROM 
    stolen_vehicles sv
JOIN 
    locations l ON sv.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    average_age DESC;

    
#13.Is there a correlation between vehicle thefts and regional socioeconomic factors?
SELECT 
    l.region,
    COUNT(s.vehicle_id) AS total_thefts,
    MAX(l.population) AS population,  
    MAX(l.density) AS density          
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    total_thefts DESC;

#14.Do certain regions report higher thefts on specific days of the week?
SELECT 
    l.region,
    DAYNAME(s.date_stolen) AS day_of_week,
    COUNT(s.vehicle_id) AS total_thefts
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region, day_of_week
ORDER BY 
    total_thefts DESC;

    
#Trend Analysis
#15.How do vehicle thefts trend over time (monthly or weekly)?
SELECT 
    DATE_FORMAT(s.date_stolen, '%Y-%m') AS month,
    COUNT(s.vehicle_id) AS total_thefts
FROM 
    stolen_vehicles s
GROUP BY 
    month
ORDER BY 
    month;

    
#16.Are there seasonal variations in vehicle thefts?
SELECT 
    CASE 
        WHEN MONTH(date_stolen) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date_stolen) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date_stolen) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(date_stolen) IN (9, 10, 11) THEN 'Autumn'
    END AS season,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    season
ORDER BY 
    theft_count DESC;
    
#17.Are there any spikes in vehicle thefts during holidays or long weekends?
SELECT 
    date_stolen, 
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
WHERE 
    DAYOFWEEK(date_stolen) IN (1, 7)
GROUP BY 
    date_stolen
ORDER BY 
    theft_count DESC;



#Composite Patterns
#18.What is the most common combination of vehicle type, make, year, and color for stolen vehicles?
SELECT 
    vehicle_type, make_id, model_year, color, 
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type, make_id, model_year, color
ORDER BY 
    theft_count DESC
LIMIT 1;


#19.Which combination of day, vehicle type, and region has the highest theft frequency?
SELECT 
    DAYNAME(date_stolen) AS day_of_week, 
    vehicle_type, 
    location_id, 
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    day_of_week, vehicle_type, location_id
ORDER BY 
    theft_count DESC
LIMIT 1;

##Additional Insights
#20.What percentage of stolen vehicles belong to each vehicle type?
SELECT 
    vehicle_type,
    COUNT(*) AS theft_count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles)) AS percentage
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type
ORDER BY 
    theft_count DESC;



#21.Are there outliers, such as vehicles of extremely high or low value, that are frequently stolen?
SELECT 
    sv.vehicle_type,
    md.make_name,
    sv.model_year,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles sv
JOIN 
    make_details md ON sv.make_id = md.make_id
GROUP BY 
    sv.vehicle_type, md.make_name, sv.model_year
ORDER BY 
    theft_count DESC;



#22.Is there any pattern in thefts linked to specific regions that may suggest organized theft rings?
SELECT 
    l.region,
    COUNT(s.vehicle_id) AS total_thefts
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    total_thefts DESC;




#23.Which vehicle colors are disproportionately stolen?
SELECT 
    color,
    COUNT(*) AS theft_count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles)) AS percentage
FROM 
    stolen_vehicles
GROUP BY 
    color
ORDER BY 
    theft_count DESC;



#Advanced Analysis
#24.Are thefts concentrated in urban versus rural regions (if regional data granularity is available)?
SELECT 
    CASE 
        WHEN l.density >= 1000 THEN 'Urban' 
        ELSE 'Rural' 
    END AS area_type,
    COUNT(s.vehicle_id) AS theft_count
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    area_type;


#25.Is there any correlation between vehicle theft rates and the average age of vehicles registered in a region?
SELECT 
    l.region,
    COUNT(s.vehicle_id) AS theft_count,
    AVG(2025 - s.model_year) AS average_vehicle_age
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region;



#26.Which regions have the most diverse mix of vehicle types stolen?
SELECT 
    l.region,
    COUNT(DISTINCT s.vehicle_type) AS distinct_vehicle_count
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    distinct_vehicle_count DESC;


#27.Are newer vehicle models more likely to be stolen in certain regions?
SELECT 
    l.region,
    COUNT(s.vehicle_id) AS newer_vehicle_theft_count
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
WHERE 
    s.model_year >= 2020
GROUP BY 
    l.region
ORDER BY 
    newer_vehicle_theft_count DESC;


#28.What proportion of thefts involve vehicles that are over 10 years old?
SELECT 
    CASE 
        WHEN YEAR(CURDATE()) - model_year > 10 THEN 'Over 10 Years Old'
        ELSE '10 Years or Newer'
    END AS vehicle_age_group, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles) AS percentage
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_age_group;
    
    SELECT 
    COUNT(*) AS total_thefts,
    COUNT(CASE WHEN model_year <= 2014 THEN 1 END) AS thefts_over_10_years,
    (COUNT(CASE WHEN model_year <= 2014 THEN 1 END) * 100.0 / COUNT(*)) AS proportion_over_10_years
FROM 
    stolen_vehicles;

#Focused Questions
#29.Are any vehicle types predominantly stolen during weekends?
SELECT 
    vehicle_type,
    COUNT(*) AS total_thefts,
    COUNT(CASE WHEN DAYOFWEEK(date_stolen) IN (1, 7) THEN 1 END) AS weekend_thefts,
    (COUNT(CASE WHEN DAYOFWEEK(date_stolen) IN (1, 7) THEN 1 END) * 100.0 / COUNT(*)) AS weekend_proportion
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type
ORDER BY 
    weekend_thefts DESC;


#30.Which vehicle colors are most likely stolen during weekdays versus weekends?
SELECT 
    color,
    COUNT(*) AS total_thefts,
    COUNT(CASE WHEN DAYOFWEEK(date_stolen) IN (1, 7) THEN 1 END) AS weekend_thefts,
    COUNT(CASE WHEN DAYOFWEEK(date_stolen) BETWEEN 2 AND 6 THEN 1 END) AS weekday_thefts,
    (COUNT(CASE WHEN DAYOFWEEK(date_stolen) IN (1, 7) THEN 1 END) * 100.0 / COUNT(*)) AS weekend_proportion,
    (COUNT(CASE WHEN DAYOFWEEK(date_stolen) BETWEEN 2 AND 6 THEN 1 END) * 100.0 / COUNT(*)) AS weekday_proportion
FROM 
    stolen_vehicles
GROUP BY 
    color
ORDER BY 
    weekend_thefts DESC, weekday_thefts DESC;

#31.What proportion of thefts occur within each region, and how does this compare to the national average?
SELECT 
    l.region,
    COUNT(s.vehicle_id) AS total_thefts,
    (COUNT(s.vehicle_id) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles)) AS proportion_of_thefts
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    total_thefts DESC;



#32.Are certain colors of vehicles more likely to be stolen in regions with high theft rates?
WITH HighTheftRegions AS (
    SELECT 
        l.region,
        COUNT(s.vehicle_id) AS total_thefts
    FROM 
        stolen_vehicles s
    JOIN 
        locations l ON s.location_id = l.location_id
    GROUP BY 
        l.region
    HAVING 
        total_thefts > (SELECT AVG(total_thefts) FROM (
            SELECT COUNT(vehicle_id) AS total_thefts
            FROM stolen_vehicles s
            JOIN locations l ON s.location_id = l.location_id
            GROUP BY l.region
        ) AS regional_totals)
)

SELECT 
    s.color,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
WHERE 
    l.region IN (SELECT region FROM HighTheftRegions)
GROUP BY 
    s.color
ORDER BY 
    theft_count DESC;



#33.Which vehicle colors are most likely to be stolen during weekends, and does this trend vary by region?
SELECT 
    s.color,
    l.region,
    COUNT(*) AS weekend_theft_count
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
WHERE 
    DAYOFWEEK(s.date_stolen) IN (1, 7)  -- Assuming 1 = Sunday, 7 = Saturday
GROUP BY 
    s.color, l.region
ORDER BY 
    weekend_theft_count DESC;



#Anomalies and Patterns
#34.Are there any unexpected spikes or drops in vehicle thefts in certain regions?
SELECT 
    l.region,
    DATE_FORMAT(s.date_stolen, '%Y-%m') AS month,
    COUNT(*) AS total_thefts
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region, month
ORDER BY 
    l.region, month;



#35.Do certain vehicle makes or models experience theft spikes in specific months or seasons?
SELECT 
    md.make_name,
    sv.vehicle_desc AS model,
    DATE_FORMAT(sv.date_stolen, '%Y-%m') AS month,
    COUNT(*) AS total_thefts
FROM 
    stolen_vehicles sv
JOIN 
    make_details md ON sv.make_id = md.make_id
GROUP BY 
    md.make_name, sv.vehicle_desc, month
ORDER BY 
    total_thefts DESC;



#36.What is the distribution of theft incidents for vehicles older than 20 years?
SELECT 
    l.region,
    COUNT(*) AS total_thefts,
    DATE_FORMAT(s.date_stolen, '%Y-%m') AS month
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
WHERE 
    s.model_year <= 2004
GROUP BY 
    l.region, month
ORDER BY 
    l.region, month;


#37.Which regions have thefts that deviate significantly from national averages in vehicle type or age?
SELECT 
    vehicle_type,
    COUNT(*) AS total_thefts,
    AVG(model_year) AS average_age
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type;
#38. SQL Query to Calculate Regional Theft Counts
#Next, we need to calculate the total theft counts by region for comparison:
SELECT 
    l.region,
    s.vehicle_type,
    COUNT(*) AS total_thefts,
    AVG(s.model_year) AS average_age
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    l.region, s.vehicle_type;

## Conclusion
This project provides a comprehensive analysis of motor vehicle theft patterns in New Zealand, facilitating informed decision-making for law enforcement and policy development. By leveraging SQL queries and data analysis techniques, users can uncover valuable insights into vehicle theft trends and characteristics.  
