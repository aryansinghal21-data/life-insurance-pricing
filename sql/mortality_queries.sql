-- ============================================================
-- PROJECT 3: Life Insurance Mortality Risk & Premium Pricing
-- SQL Queries for Actuarial Risk Factor Analysis
-- ============================================================


-- ── QUERY 1: Mortality Risk Rate by Age Band ────────────────
-- Business Use: Mirrors actuarial life table construction.
-- Age is the primary rating factor in all life insurance pricing

SELECT CASE
           WHEN age < 40 THEN '1. Under 40'
           WHEN age < 50 THEN '2. Age 40-49'
           WHEN age < 60 THEN '3. Age 50-59'
           ELSE               '4. Age 60+'
       END                                              AS age_band,
       COUNT(*)                                         AS patients,
       SUM(target)                                      AS high_risk_count,
       ROUND(100.0 * SUM(target) / COUNT(*), 1)         AS risk_rate_pct,
       ROUND(AVG(chol), 0)                              AS avg_cholesterol,
       ROUND(AVG(trestbps), 0)                          AS avg_blood_pressure,
       ROUND(AVG(thalach), 0)                           AS avg_max_heart_rate
FROM   patients
GROUP  BY age_band
ORDER  BY age_band;


-- ── QUERY 2: Mortality Risk by Gender ───────────────────────
-- Business Use: Gender is a standard actuarial rating factor.
-- Males have higher mortality rates — justifies premium differential

SELECT CASE WHEN sex = 1 THEN 'Male' ELSE 'Female' END  AS gender,
       COUNT(*)                                          AS patients,
       SUM(target)                                       AS high_risk_count,
       ROUND(100.0 * SUM(target) / COUNT(*), 1)          AS risk_rate_pct,
       ROUND(AVG(age), 1)                                AS avg_age,
       ROUND(AVG(chol), 0)                               AS avg_cholesterol,
       ROUND(AVG(trestbps), 0)                           AS avg_blood_pressure
FROM   patients
GROUP  BY sex;


-- ── QUERY 3: Risk by Cholesterol Level ──────────────────────
-- Business Use: Cholesterol is a key underwriting factor.
-- High cholesterol (240+) triggers loading multipliers in pricing

SELECT CASE
           WHEN chol < 200 THEN '1. Optimal (<200)'
           WHEN chol < 240 THEN '2. Borderline (200-239)'
           ELSE                 '3. High Risk (240+)'
       END                                              AS cholesterol_band,
       COUNT(*)                                         AS patients,
       SUM(target)                                      AS high_risk_count,
       ROUND(100.0 * SUM(target) / COUNT(*), 1)         AS risk_rate_pct
FROM   patients
GROUP  BY cholesterol_band
ORDER  BY cholesterol_band;


-- ── QUERY 4: Risk by Blood Pressure Level ───────────────────
-- Business Use: Hypertension is a leading mortality factor.
-- BP above 140 mmHg is classified as Stage 2 hypertension

SELECT CASE
           WHEN trestbps < 120 THEN '1. Normal (<120)'
           WHEN trestbps < 130 THEN '2. Elevated (120-129)'
           WHEN trestbps < 140 THEN '3. Stage 1 (130-139)'
           ELSE                     '4. Stage 2 (140+)'
       END                                              AS bp_band,
       COUNT(*)                                         AS patients,
       SUM(target)                                      AS high_risk_count,
       ROUND(100.0 * SUM(target) / COUNT(*), 1)         AS risk_rate_pct,
       ROUND(AVG(chol), 0)                              AS avg_cholesterol
FROM   patients
GROUP  BY bp_band
ORDER  BY bp_band;


-- ── QUERY 5: Multi-Factor High Risk Profile ──────────────────
-- Business Use: Combined risk factors identify applicants
-- likely to be rated, postponed, or declined by underwriters

SELECT age,
       CASE WHEN sex = 1 THEN 'Male' ELSE 'Female' END  AS gender,
       ROUND(chol, 0)                                    AS cholesterol,
       trestbps                                          AS blood_pressure,
       CASE WHEN fbs = 1  THEN 'Yes' ELSE 'No' END       AS diabetes_marker,
       CASE WHEN exang = 1 THEN 'Yes' ELSE 'No' END      AS exercise_angina,
       ca                                                AS blocked_vessels,
       target                                            AS high_risk,
       CASE
           WHEN target = 1
            AND chol > 240
            AND trestbps > 140
            AND exang = 1     THEN 'LIKELY DECLINE'
           WHEN target = 1
            AND (chol > 240 OR trestbps > 140
                 OR exang = 1) THEN 'SUBSTANDARD RATED'
           WHEN target = 1   THEN 'STANDARD RATED'
           ELSE                   'STANDARD / PREFERRED'
       END                                               AS underwriting_decision
FROM   patients
WHERE  age > 50
ORDER  BY underwriting_decision, age DESC
LIMIT  20;


-- ── QUERY 6: Risk Factor Correlation Summary ─────────────────
-- Business Use: Identifies which clinical variables are
-- most associated with high mortality risk for model validation

SELECT 'Exercise Angina'   AS risk_factor,
       ROUND(100.0 * SUM(CASE WHEN exang = 1 AND target = 1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(CASE WHEN exang = 1 THEN 1 ELSE 0 END), 0), 1) AS risk_rate_pct
FROM patients
UNION ALL
SELECT 'Diabetes Marker',
       ROUND(100.0 * SUM(CASE WHEN fbs = 1 AND target = 1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(CASE WHEN fbs = 1 THEN 1 ELSE 0 END), 0), 1)
FROM patients
UNION ALL
SELECT 'High Cholesterol (240+)',
       ROUND(100.0 * SUM(CASE WHEN chol >= 240 AND target = 1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(CASE WHEN chol >= 240 THEN 1 ELSE 0 END), 0), 1)
FROM patients
UNION ALL
SELECT 'Stage 2 Hypertension (140+)',
       ROUND(100.0 * SUM(CASE WHEN trestbps >= 140 AND target = 1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(CASE WHEN trestbps >= 140 THEN 1 ELSE 0 END), 0), 1)
FROM patients
UNION ALL
SELECT 'Male Gender',
       ROUND(100.0 * SUM(CASE WHEN sex = 1 AND target = 1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(CASE WHEN sex = 1 THEN 1 ELSE 0 END), 0), 1)
FROM patients
ORDER  BY risk_rate_pct DESC;


-- ── QUERY 7: Portfolio Premium Summary ──────────────────────
-- Business Use: After pricing all applicants, this summarises
-- the expected annual premium income and risk tier distribution

SELECT risk_tier,
       COUNT(*)                                          AS policy_count,
       ROUND(AVG(annual_premium_usd), 2)                AS avg_annual_premium,
       ROUND(SUM(annual_premium_usd), 0)                AS total_premium_income,
       ROUND(100.0 * COUNT(*) /
             (SELECT COUNT(*) FROM priced_portfolio), 1) AS pct_of_portfolio
FROM   priced_portfolio
GROUP  BY risk_tier
ORDER  BY avg_annual_premium;
