USE Cleaned_Data;

SELECT
    Region,

    ROUND(AVG(CASE 
        WHEN AI_Risk_Label = 'High Risk' 
        THEN Monthly_Income - Energy_Bill - Food_Spend - Rent_Mortgage
    END), 2) AS avg_high_risk_disposable_income,

    ROUND(AVG(CASE 
        WHEN AI_Risk_Label = 'Stable' 
        THEN Monthly_Income - Energy_Bill - Food_Spend - Rent_Mortgage
    END), 2) AS avg_stable_disposable_income,

    ROUND(
        AVG(CASE 
            WHEN AI_Risk_Label = 'Stable' 
            THEN Monthly_Income - Energy_Bill - Food_Spend - Rent_Mortgage
        END)
        -
        AVG(CASE 
            WHEN AI_Risk_Label = 'High Risk' 
            THEN Monthly_Income - Energy_Bill - Food_Spend - Rent_Mortgage
        END),
        2
    ) AS income_drop,

    CASE
        WHEN (
            AVG(CASE 
                WHEN AI_Risk_Label = 'Stable' 
                THEN Monthly_Income - Energy_Bill - Food_Spend - Rent_Mortgage
            END)
            -
            AVG(CASE 
                WHEN AI_Risk_Label = 'High Risk' 
                THEN Monthly_Income - Energy_Bill - Food_Spend - Rent_Mortgage
            END)
        ) > 200
        THEN 'Stress Test Failed'
        ELSE 'Stress Test Passed'
    END AS resilience_stress_test

FROM cleaned_ai_enriched_household_costs
GROUP BY Region
ORDER BY income_drop DESC;