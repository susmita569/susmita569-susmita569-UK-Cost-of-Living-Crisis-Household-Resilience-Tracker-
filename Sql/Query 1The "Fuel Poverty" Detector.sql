# Check the Raw Data 
USE `Cleaned_Data`;

SELECT 
    Region,
    Household_Type,
    Monthly_Income,
    Energy_Bill
FROM `cleaned_ai_enriched_household_costs`
LIMIT 20;

#See grouped averages
SELECT
    Region,
    Household_Type,
    AVG(Monthly_Income) AS avg_income,
    AVG(Energy_Bill) AS avg_energy
FROM `cleaned_ai_enriched_household_costs`
GROUP BY Region, Household_Type;

# Add Ratio 
SELECT
    Region,
    Household_Type,
    AVG(Monthly_Income) AS avg_income,
    AVG(Energy_Bill) AS avg_energy,
    AVG(Energy_Bill) / AVG(Monthly_Income) AS ratio
FROM `cleaned_ai_enriched_household_costs`
GROUP BY Region, Household_Type;

SELECT
    Region,
    Household_Type,
    AVG(Energy_Bill) AS avg_energy_bill,
    AVG(Monthly_Income) AS avg_income
FROM `cleaned_ai_enriched_household_costs`
GROUP BY Region, Household_Type
HAVING AVG(Energy_Bill) > AVG(Monthly_Income) * 0.10;

SELECT 
    Region,
    Household_Type,
    Monthly_Income,
    Energy_Bill,
    Monthly_Income * 0.10 AS ten_percent_income,
    Energy_Bill > Monthly_Income * 0.10 AS is_fuel_poor
FROM `cleaned_ai_enriched_household_costs`
LIMIT 10;