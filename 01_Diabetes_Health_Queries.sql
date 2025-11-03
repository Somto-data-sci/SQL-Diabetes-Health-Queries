-- ANALYTICAL REPORT SUMMARY: Pure SELECT queries focused on basic counts, key aggregations, and simple filtering.

-- 1. Get the total count of individuals with and without diabetes status.
SELECT "Diabetes_Status", COUNT(*) AS count
FROM diabetes_data
GROUP BY "Diabetes_Status";


-- 2. Check the count of 'NR' data in the Fasting Blood Sugar column (Data Quality).
SELECT COUNT(*) AS nr_fasting_blood_sugar_count
FROM diabetes_data
WHERE "Fasting_Blood_Sugar" = 'NR';


-- 3. Compare the average BMI between the two diabetes status groups.
SELECT "Diabetes_Status", AVG("BMI") AS average_bmi
FROM diabetes_data
GROUP BY "Diabetes_Status";


-- 4. Calculate the percentage of individuals with a Family History of diabetes.
SELECT
    "Family_History",
    (COUNT(*)::NUMERIC * 100.0 / (SELECT COUNT(*) FROM diabetes_data)) AS percentage
FROM diabetes_data
GROUP BY "Family_History";


-- 5. Calculate the average Fasting Blood Sugar by converting 'NR' strings to NULL for accurate numeric aggregation. (Data Cleaning)
SELECT AVG(CAST(NULLIF("Fasting_Blood_Sugar", 'NR') AS NUMERIC)) AS average_fbs
FROM diabetes_data;


-- 6. Find the top 3 States by the total count of individuals.
SELECT "State", COUNT(*) AS total_count
FROM diabetes_data
GROUP BY "State"
ORDER BY total_count DESC
LIMIT 3;


-- 7. Filter for individuals who are both Male AND categorized as 'High' Income.
SELECT "Age", "Gender", "Income_Level", "Diabetes_Status"
FROM diabetes_data
WHERE "Gender" = 'Male' AND "Income_Level" = 'High'
LIMIT 10;


-- 8. Calculate the average number of Doctor Visits, grouped by Smoking Status.
SELECT "Smoking_Status", AVG("Doctor_Visits") AS avg_visits
FROM diabetes_data
GROUP BY "Smoking_Status";


-- 9. Calculate the diabetes prevalence rate for each Ethnicity.
SELECT
    "Ethnicity",
    (COUNT(CASE WHEN "Diabetes_Status" = 'Yes' THEN 1 END)::NUMERIC * 100.0 / COUNT(*)) AS prevalence_rate_percent
FROM diabetes_data
GROUP BY "Ethnicity"
ORDER BY prevalence_rate_percent DESC;


-- 10. Find the lowest and highest BMI recorded in the dataset.
SELECT MIN("BMI") AS minimum_bmi, MAX("BMI") AS maximum_bmi
FROM diabetes_data;


-- 11. Identify the County with the highest *count* of individuals with diabetes.
SELECT "County", COUNT(*) AS diabetic_count
FROM diabetes_data
WHERE "Diabetes_Status" = 'Yes'
GROUP BY "County"
ORDER BY diabetic_count DESC
LIMIT 1;


-- 12. Check for individuals with a high number of Doctor Visits (10 or more) AND no family history of diabetes.
SELECT "Age", "Gender", "Doctor_Visits", "Family_History"
FROM diabetes_data
WHERE "Doctor_Visits" >= 10 AND "Family_History" = 'No'
LIMIT 10;