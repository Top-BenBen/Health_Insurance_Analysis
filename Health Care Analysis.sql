-- 1.  What is the demographic composition of our patient base?
-- Who are our patients, and how are they distributed across age, gender, and insurance type?
Use hi_data_2;
-- Distribution across gender
select gender, count(gender) as Number
from patients
group by gender
order by number desc;

-- Distribution across age
select
CASE 
 When age < 18 then 'Below 18'
 when age between 18 and 30 then 'Young Adult'
 when age between 31 and 49 then 'Senior Adult'
ELSE 'Retirees'
End as Age_group, count(*) as TNoP
from patients
group by age_group
order by age_group desc;

-- 2. Which cities or states have the highest concentration of patients?
-- “Where are our patients located geographically?”
select state, count(*) AS Pop
from patients
group by state
order by pop desc
limit 5;

-- 3. What is the age and gender breakdown across cities or states?
-- “Are seniors more concentrated in certain cities or is a city more female-dominant?”
SELECT 
  state,
  gender,
  CASE 
    WHEN age < 18 THEN '0-17'
    WHEN age BETWEEN 18 AND 34 THEN '18-34'
    WHEN age BETWEEN 35 AND 54 THEN '35-54'
    WHEN age BETWEEN 55 AND 74 THEN '55-74'
    ELSE '75+'
  END AS age_group,
  COUNT(*) AS patient_count
FROM patients
GROUP BY state, gender, age_group
ORDER BY state, gender, age_group;

-- 4. Are there underserved or low-volume zip codes?
-- “Where do we have few patients, and possibly poor reach or service?
select zip_code, count(*) NoPZ
from patients
group by zip_code
order by NoPZ Asc
Limit 10;


-- 5. What is the total claim volume and value over time?
-- “How many claims are we processing, and how much do they cost month over month?".
Select 
Date_format(claim_date, '%y-%m') as Claim_months, 
count(*) as NoC, 
round(sum(claim_amount),2) as Total_Claim_Value
from claims
group by claim_months
order by Total_Claim_Value;

-- 6. What’s the average claim amount by status?
-- “Are rejected or pending claims costing us more or less?”

select status, 
COUNT(*) AS NoC,
ROUND(avg(claim_amount),2) as AvgClaim_Value
from claims 
group by status
order by AvgClaim_Value DESC;

-- 7. Which providers are submitting the highest-value claims?
-- “Who are our most expensive providers — and do they align with quality?”
Select provider_id, 
count(*) as claim_count,
round(sum(claim_amount), 2) as TClaim_Value,
round((round(sum(claim_amount), 2)/ COUNT(Provider_id)),2) as AvgCCost
from claims
group by provider_id
order by TClaim_Value Desc
Limit 5;

-- 8. Are there spikes in claim submissions from certain patients or providers?
-- “Any behavioral outliers that suggest fraud or errors?”
SELECT 
  patient_id,
  COUNT(*) AS claim_count,
  round(SUM(claim_amount),2) AS TClaim_Value
FROM claims
GROUP BY patient_id
HAVING claim_count > 10
ORDER BY TClaim_Value DESC;

-- 9. What is the average time between claims per patient or provider?
-- “How frequently do patients/providers submit claims?”
WITH patient_claims AS (
  SELECT 
    patient_id,
    claim_date,
    LAG(claim_date) OVER (PARTITION BY patient_id ORDER BY claim_date) AS prev_date
  FROM claims
)
SELECT 
  patient_id,
  AVG(DATEDIFF(claim_date, prev_date)) AS avg_days_between_claims
FROM patient_claims
WHERE prev_date IS NOT NULL
GROUP BY patient_id
ORDER BY avg_days_between_claims desc;


-- 10. What is the overall claim reimbursement rate?
select round(sum(payment_amount),2)/ round(sum(claim_amount),2) as reimbursement_rate
from payments;

-- 11. How long does it typically take to get paid after a claim is submitted?
select avg(datediff(payment_date, claim_date)) as avg_Wait_period
from payments
WHERE payment_date IS NOT NULL AND claim_date IS NOT NULL;

-- 12. Which claims have the largest payment shortfalls?
SELECT 
  claim_id,
  patient_id,
  claim_amount,
  payment_amount,
  (claim_amount - payment_amount) AS shortfall
FROM payments
WHERE payment_amount < claim_amount
ORDER BY shortfall DESC
LIMIT 15;

-- 13. How does reimbursement rate vary by claim status?
select status,
count(*) as NoC,
sum(claim_amount) as total_claim,
sum(payment_amount),
round(sum(payment_amount),2)/ round(sum(claim_amount),2) as reimbursement_rate
from payments
group by status
order by reimbursement_rate Desc ;

-- 14. Which providers are consistently reimbursed below the claim value?
select provider_id, 
count(*) as Noc,
sum(claim_amount) as total_claim,
sum(payment_amount) as total_payment,
round(payment_amount - claim_amount) as payment_gap
from payments
group by provider_id, payment_gap
having payment_gap < 0
order by payment_gap desc;

-- 15. Which specialties are most represented across our provider network?
select specialty, count(*) as Number_of_Providers
from providers
group by specialty
order by Number_of_Providers Desc;

-- 16. How is our provider network distributed geographically?
select state, count(*) as Geo_Dis
from providers
group by state
order by Geo_Dis Desc;

-- 17. Which specialties are concentrated in specific states or cities?
select state, specialty, count(*) as Geo_Dis
from providers
group by state, specialty
order by Geo_Dis desc;

-- 18. Do any zip codes have unusually high or low provider density?
select zip_code, count(*) as pop_den
from providers
group by zip_code
order by pop_den desc;

-- 19. Are there providers with duplicate phone numbers or suspicious records?
select provider_id, count(*)
from providers
where phone > 1
group by provider_id;

--  FRAUD DETECTION AND BEHAVOURAL ANALYSIS
-- 1. Are there patients submitting claims to multiple providers within a very short timeframe?
SELECT 
  patient_id,
  COUNT(DISTINCT provider_id) AS unique_providers,
  MIN(claim_date) AS first_claim,
  MAX(claim_date) AS last_claim,
  DATEDIFF(MAX(claim_date), MIN(claim_date)) AS span_days
FROM claims
GROUP BY patient_id
HAVING unique_providers > 2 AND span_days <= 20
ORDER BY unique_providers DESC;

-- 2. Do any providers consistently file high numbers of claims on non-working days (weekends, holidays)?
SELECT 
  provider_id,
  COUNT(*) AS weekend_claims
FROM claims
WHERE DAYOFWEEK(claim_date) IN (1, 7) -- Sunday(1), Saturday(7)
GROUP BY provider_id
ORDER BY weekend_claims DESC
LIMIT 10;

-- 3. Are there claims with full payments made unusually fast (same day or within 1 day)?
SELECT 
  claim_id,
  patient_id,
  provider_id,
  claim_date,
  payment_date,
  DATEDIFF(payment_date, claim_date) AS payment_gap_days,
  claim_amount,
  payment_amount
FROM payments
WHERE DATEDIFF(payment_date, claim_date) <= 1
  AND payment_amount = claim_amount and payment_date > claim_date
ORDER BY payment_gap_days desc;

-- 4. Are there payment records where the total payment exceeds the total claimed amount for a provider or patient?
select provider_id, 
sum(payment_amount) as total_payment,
sum(claim_amount) as claimed_amount,
(sum(payment_amount) - sum(claim_amount)) as overpaid_amount
from payments
group by provider_id
having overpaid_amount > 0
order by overpaid_amount DESC;

-- 5. Which providers have unusually high total claim amounts but very low patient counts?
SELECT 
  c.provider_id,
  pr.name AS provider_name,
  COUNT(DISTINCT c.patient_id) AS unique_patients,
  SUM(c.claim_amount) AS total_claimed
FROM claims c
JOIN providers pr ON c.provider_id = pr.provider_id
GROUP BY c.provider_id, pr.name
HAVING unique_patients < 5 AND total_claimed > 50000
ORDER BY total_claimed DESC;

-- 6. Which patients have received payments for claims from multiple providers in different cities or states?
SELECT 
  p.patient_id,
  COUNT(DISTINCT pr.city) AS cities_used,
  COUNT(DISTINCT pr.state) AS states_used,
  COUNT(DISTINCT pr.provider_id) AS providers_seen
FROM payments pay
JOIN claims c ON pay.claim_id = c.claim_id
JOIN providers pr ON c.provider_id = pr.provider_id
JOIN patients p ON c.patient_id = p.patient_id
GROUP BY p.patient_id
HAVING cities_used > 2 OR states_used > 1
ORDER BY providers_seen DESC;
