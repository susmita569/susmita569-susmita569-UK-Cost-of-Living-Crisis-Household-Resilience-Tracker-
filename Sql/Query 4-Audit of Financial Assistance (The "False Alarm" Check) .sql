USE Cleaned_Data;

SELECT 
    Region,
    COUNT(*) AS total_supported_households,
    SUM(CASE WHEN Savings_Buffer > 5000 THEN 1 ELSE 0 END) AS households_over_5000_savings,
    ROUND(
        SUM(CASE WHEN Savings_Buffer > 5000 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS percentage_over_5000
FROM cleaned_ai_enriched_household_costs
WHERE UPPER(TRIM(Receiving_Support)) = 'YES'
GROUP BY Region
ORDER BY percentage_over_5000 DESC;