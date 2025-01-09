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
    
#3.What is the most common time of the year (month or season) for vehicle thefts?
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
    make_id,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    make_id
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
    AVG(YEAR(CURDATE()) - model_year) AS avg_vehicle_age
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type
ORDER BY 
    avg_vehicle_age DESC;
    
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
    location_id,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    location_id
ORDER BY 
    theft_count DESC;
    
#11.What is the distribution of stolen vehicle types across regions?
SELECT 
    location_id,
    vehicle_type,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    location_id, vehicle_type
ORDER BY 
    location_id, theft_count DESC;
    
#12.Are there regional patterns in the age or color of stolen vehicles?
SELECT 
    location_id,
    AVG(YEAR(CURDATE()) - model_year) AS avg_vehicle_age,
    color,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    location_id, color
ORDER BY 
    location_id, avg_vehicle_age DESC;
    
#13.Is there a correlation between vehicle thefts and regional socioeconomic factors (if additional data is available)?
SELECT 
    sv.location_id,
    COUNT(sv.vehicle_id) AS theft_count,
    rd.density
FROM 
    stolen_vehicles sv
JOIN 
    locations rd 
ON 
    sv.location_id = rd.location_id
GROUP BY 
    sv.location_id, rd.density
ORDER BY 
    theft_count DESC;


    
#14.Do certain regions report higher thefts on specific days of the week?
SELECT 
    location_id,
    DAYNAME(date_stolen) AS day_of_week,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    location_id, DAYNAME(date_stolen)
ORDER BY 
    location_id, theft_count DESC;
    
#Trend Analysis
#15.How do vehicle thefts trend over time (monthly or weekly)?
SELECT 
    DATE_FORMAT(date_stolen, '%Y-%m') AS month,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    DATE_FORMAT(date_stolen, '%Y-%m')
ORDER BY 
    month ASC;
    
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
#21.What percentage of stolen vehicles belong to each vehicle type?
SELECT 
    vehicle_type, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles) AS percentage
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type
ORDER BY 
    percentage DESC;


#22.Are there outliers, such as vehicles of extremely high or low value, that are frequently stolen?
SELECT 
    vehicle_type, 
    make_id, 
    model_year, 
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
WHERE 
    model_year <= 2000 OR model_year >= 2020
GROUP BY 
    vehicle_type, make_id, model_year
ORDER BY 
    theft_count DESC;


#23.Is there any pattern in thefts linked to specific regions that may suggest organized theft rings?
SELECT 
    location_id, 
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    location_id
HAVING 
    theft_count > (SELECT AVG(theft_count) FROM (SELECT COUNT(*) AS theft_count FROM stolen_vehicles GROUP BY location_id) AS subquery)
ORDER BY 
    theft_count DESC;


#24.Which vehicle colors are disproportionately stolen?
SELECT 
    color, 
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    color
ORDER BY 
    theft_count DESC;


#Advanced Analysis
#25.Are thefts concentrated in urban versus rural regions (if regional data granularity is available)?
SELECT 
    CASE 
        WHEN l.density > 1000 THEN 'Urban' 
        ELSE 'Rural' 
    END AS area_type,
    COUNT(s.vehicle_id) AS theft_count
FROM 
    stolen_vehicles s
JOIN 
    locations l ON s.location_id = l.location_id
GROUP BY 
    area_type;


#26.Is there any correlation between vehicle theft rates and the average age of vehicles registered in a region?
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



#27.Which regions have the most diverse mix of vehicle types stolen?
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


#28.Are newer vehicle models more likely to be stolen in certain regions?
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


#29.What proportion of thefts involve vehicles that are over 10 years old?
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
#30.Are any vehicle types predominantly stolen during weekends?
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

#31.Which vehicle colors are most likely stolen during weekdays versus weekends?
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

#32.What proportion of thefts occur within each region, and how does this compare to the national average?
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



#33.Are certain colors of vehicles more likely to be stolen in regions with high theft rates?
WITH TheftCounts AS (
    SELECT 
        l.region,
        COUNT(s.vehicle_id) AS total_thefts
    FROM 
        stolen_vehicles s
    JOIN 
        locations l ON s.location_id = l.location_id
    GROUP BY 
        l.region
),
HighTheftRegions AS (
    SELECT 
        region
    FROM 
        TheftCounts
    WHERE 
        total_thefts > (SELECT AVG(total_thefts) FROM TheftCounts)
)
SELECT 
    s.color,
    COUNT(s.vehicle_id) AS theft_count,
    COUNT(s.vehicle_id) * 100.0 / (SELECT COUNT(*) FROM stolen_vehicles) AS proportion_of_total_thefts
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


#34.Which vehicle colors are most likely to be stolen during weekends, and does this trend vary by region?
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
#35.Are there any unexpected spikes or drops in vehicle thefts in certain regions?
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


#36.Do certain vehicle makes or models experience theft spikes in specific months or seasons?
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


#37.What is the distribution of theft incidents for vehicles older than 20 years?
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


#38.Which regions have thefts that deviate significantly from national averages in vehicle type or age?
SELECT 
    vehicle_type,
    COUNT(*) AS total_thefts,
    AVG(model_year) AS average_age
FROM 
    stolen_vehicles
GROUP BY 
    vehicle_type;
#3. SQL Query to Calculate Regional Theft Counts
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
