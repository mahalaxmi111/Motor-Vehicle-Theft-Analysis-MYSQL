# Motor-Vehicle-Theft-Analysis-MYSQL
## Project Overview
This project analyzes motor vehicle theft data from the New Zealand police department's vehicle of interest database. The primary goal is to identify patterns and trends in vehicle thefts to assist law enforcement and inform policy decisions.

# Tools & Library Used

![MySQL](https://github.com/user-attachments/assets/ee3c21b7-e789-41c4-aaf4-93164756dada)


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
#1.On which day of the week are vehicles most and least often stolen?

![Q1](https://github.com/user-attachments/assets/02d4442c-83f5-4dd0-b449-ce51cc983b67)


#2.How does the distribution of thefts vary between weekdays and weekends?

![Q2](https://github.com/user-attachments/assets/ab0fefa5-3aeb-4ae3-8a93-7805249cbdf4)

    
#3.What is the most common time of the month for vehicle thefts?

![Q3](https://github.com/user-attachments/assets/3e8715d9-2921-4b15-b790-d8dea16237bd)

#4.What are the most and least stolen vehicle types overall?

![Q4](https://github.com/user-attachments/assets/f649cbf1-dd60-4134-9090-21958f4afee3)


#5.Are there specific vehicle makes or models that are more commonly stolen?

![Q5](https://github.com/user-attachments/assets/372d2c6f-5624-43cb-80ab-6780f405b2b8)



#6.What is the distribution of stolen vehicles by their production year?

![Q6](https://github.com/user-attachments/assets/f3337d55-7a40-4301-9a79-467b6a34b323)

    
#7.How does the average vehicle age vary across vehicle types (e.g., sedans, SUVs, trucks)?

![Q7](https://github.com/user-attachments/assets/c1e78104-6aa2-4e28-b112-0e41021e8ef9)

#8.Which colors of vehicles are most and least commonly stolen?

![Q8](https://github.com/user-attachments/assets/14b03917-85f8-4ebc-8293-7e941610b27e)

    
#9.Are older vehicles more likely to be stolen than newer ones?

![Q9](https://github.com/user-attachments/assets/6aee6751-659f-4118-8324-b1a3eb0a1d4b)

    

#10.Which regions report the highest and lowest vehicle thefts?

![Q10](https://github.com/user-attachments/assets/bdb0d15a-c5ae-4d8a-a131-4a51ae98c072)


    
#11.What is the distribution of stolen vehicle types across regions?

![Q11](https://github.com/user-attachments/assets/4c7bd0c1-44d0-4e5a-98e6-cd1823232987)


    
#12.Are there regional patterns in the age or color of stolen vehicles?

![Q12](https://github.com/user-attachments/assets/ca437d36-0650-44e3-803d-1d9c8c7ab45b)


    
#13.Is there a correlation between vehicle thefts and regional socioeconomic factors?

![Q13](https://github.com/user-attachments/assets/ea108480-bab4-4656-bcc9-3baee54ab5af)


#14.Do certain regions report higher thefts on specific days of the week?

![Q14](https://github.com/user-attachments/assets/eee04ccc-b779-4474-9eab-439fbd7450c4)


#15.How do vehicle thefts trend over time (monthly or weekly)?

![Q15](https://github.com/user-attachments/assets/a091ad62-f855-44aa-9894-cc380173c67a)


    
#16.Are there seasonal variations in vehicle thefts?

![Q16](https://github.com/user-attachments/assets/cc78c190-8cf2-446d-bb72-5dfa31d8ab73)

    
#17.Are there any spikes in vehicle thefts during holidays or long weekends?

![Q17a](https://github.com/user-attachments/assets/20c519c9-6f77-4f44-9aff-947f9018385b)


#18.What is the most common combination of vehicle type, make, year, and color for stolen vehicles?

![Q18](https://github.com/user-attachments/assets/76b1ee75-cfd8-43ad-b051-47e34a80868e)



#19.Which combination of day, vehicle type, and region has the highest theft frequency?

![Q19](https://github.com/user-attachments/assets/40bcf098-1677-480a-b6cb-73b032230d34)


#20.What percentage of stolen vehicles belong to each vehicle type?

![Q20](https://github.com/user-attachments/assets/f7bc9d50-defc-44cf-9e93-8a66366e796c)




#21.Are there outliers, such as vehicles of extremely high or low value, that are frequently stolen?

![Q21](https://github.com/user-attachments/assets/1a8418ea-c9ad-46aa-bda0-ffe350434135)



#22.Is there any pattern in thefts linked to specific regions that may suggest organized theft rings?

![Q22](https://github.com/user-attachments/assets/fee0cad5-f788-46f2-8705-9b6b47a749c3)



#23.Which vehicle colors are disproportionately stolen?

![Q23](https://github.com/user-attachments/assets/db44acd4-be28-4217-b76a-35040d771c8b)



#24.Are thefts concentrated in urban versus rural regions (if regional data granularity is available)?

![Q24](https://github.com/user-attachments/assets/4cbfdb40-02a3-48bc-8a32-9945491c5c5d)



#25.Is there any correlation between vehicle theft rates and the average age of vehicles registered in a region?

![Q25](https://github.com/user-attachments/assets/243bcde7-6c2b-4512-88ac-2fa1a2857883)




#26.Which regions have the most diverse mix of vehicle types stolen?

![Q26](https://github.com/user-attachments/assets/cb68045a-7f2c-4325-8b92-969db0ca94d7)



#27.Are newer vehicle models more likely to be stolen in certain regions?

![Q27](https://github.com/user-attachments/assets/ff6fddee-8df9-42a9-b918-62ed8a36bff3)



#28.What proportion of thefts involve vehicles that are over 10 years old?
![Q28](https://github.com/user-attachments/assets/9e778f66-3862-4256-b144-fc4f44089b34)


#29.Are any vehicle types predominantly stolen during weekends?

![Q29](https://github.com/user-attachments/assets/d454e652-8dfe-4b32-aa94-b2acd35442d3)



#30.Which vehicle colors are most likely stolen during weekdays versus weekends?

![Q30](https://github.com/user-attachments/assets/c7207776-8a06-4f9d-8953-b62c67d6c1be)


#31.What proportion of thefts occur within each region, and how does this compare to the national average?

![Q31](https://github.com/user-attachments/assets/7def208a-89a1-4403-b7b9-0a8acae2b76d)




#32.Are certain colors of vehicles more likely to be stolen in regions with high theft rates?

![Q32](https://github.com/user-attachments/assets/c2f4ce61-1605-43e2-b24f-af3e80cc0f9b)



#33.Which vehicle colors are most likely to be stolen during weekends, and does this trend vary by region?

![Q33](https://github.com/user-attachments/assets/6aa6b80e-2970-4fd4-82b3-7229c6a8e988)



#34.Are there any unexpected spikes or drops in vehicle thefts in certain regions?

![Q34](https://github.com/user-attachments/assets/3bd81ce2-44aa-424a-97fd-8b2374db3ca5)




#35.Do certain vehicle makes or models experience theft spikes in specific months or seasons?

![Q35](https://github.com/user-attachments/assets/51eccbc1-b04d-4252-b8d6-b491a2db622d)




#36.What is the distribution of theft incidents for vehicles older than 20 years?

![Q36](https://github.com/user-attachments/assets/80492fef-b8d2-48eb-935e-9f5c304a1386)



#37.Which regions have thefts that deviate significantly from national averages in vehicle type or age?

![Q37](https://github.com/user-attachments/assets/744648a7-a562-4004-b23e-00ff5ee49f81)

    
#38. SQL Query to Calculate Regional Theft Counts, we need to calculate the total theft counts by region for comparison:

![Q38](https://github.com/user-attachments/assets/2e3cf4aa-d7e8-47ce-bc28-73a574570eae)


## Conclusion
This project provides a comprehensive analysis of motor vehicle theft patterns in New Zealand, facilitating informed decision-making for law enforcement and policy development. By leveraging SQL queries and data analysis techniques, users can uncover valuable insights into vehicle theft trends and characteristics.  
