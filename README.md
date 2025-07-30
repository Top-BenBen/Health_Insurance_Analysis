# Healthcare Analytics Project Documentation & Insights (Report & Analysis)

Industry: Health Insurance | Data Analytics

Tools Used: SQL Workbench | Relational Database
 
#### 1. Project Overview
This project explores health insurance datasets to uncover patterns in patient behaviour, provider practices, claim efficiency, and potential fraud. The analysis is grounded in transactional data captured across four key tables: patients, claims, payments, and providers.

#### Dataset Source, Architecture & Summary
The source of the dataset: The dataset was downloaded from ['Kaggle'](https://www.kaggle.com/datasets/jaiswalmagic1/healthcare-fraud-detection-dataset1)

Data Architecture (Entity Relationship Diagram)

The following diagram represents the relational structure across the key tables: Patients, Claims, Payments, and Providers. It highlights how foreign keys are used to link patient activity, provider details, and financial transactions for end-to-end traceability.
<img width="560" height="560" alt="ERD D" src="https://github.com/user-attachments/assets/e9ce5637-be3f-4658-ba5f-3a20e9997bbb" />

Summary: 

Patients: Demographics of insured individuals included the following columns: patient_id, age, gender, city/state

Claims: Submitted healthcare claims containing transactional records, including: claim_id, patient_id, provider_id, claim_date, claim_amount, status

Payments: Records of payments processed for submitted claims, including: payment_id, claim_id, patient_id, provider_id, claim_date, payment_date, claim_amount, payment_amount, status

Providers: Details about healthcare service providers, including: provider_id, name, speciality, city/state, zip_code, phone

## Insights (Report & Analysis)
## Understanding Customer Demographics
#### Some Key Analytical Questions Answered

Patient Demographics & Behaviour: 

-- 1.  What is the demographic composition of our patient base?
-- Who are our patients, and how are they distributed across age, gender, and insurance type?
-- Distribution across gender


> There are	*23970* males,	*23970* females and	*2060* representing other genders. 
<details>
  <summary>View Code</summary>
 
  ```sql
  select gender, count(gender) as Number
from patients
group by gender
order by number desc;
  ```
</details>
 
-- Distribution across age 
> ABC

<details>
  <summary>View Code</summary>
 
```sql
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
```
</details>

2. Which cities or states have the highest concentration of patients?
   “Where are our patients located geographically?”

> Washington leads with the highest patient population, indicating a potential cluster of healthcare engagement or service demand in that state.

| state          | Pop          |
|----------------|--------------|
| Washington     | 1063         |
| Kansas         | 1053         |
| Oklahoma       | 1054         |
| Pennsylvania   | 1041         |
| Missouri       | 1039         |

<details>
  <summary>View Code</summary>
 
``` sql
select state, count(*) AS Pop
from patients
group by state
order by pop desc
limit 5;
```
</details>

-- 3. What is the age and gender breakdown across cities or states?
-- “Are seniors more concentrated in certain cities or is a city more female-dominant?”
> 
<details>
  <summary>View Code</summary>

 ``` sql
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
```
</details>

-- 4. Are there underserved or low-volume zip codes?
>

<details>
  <summary>View Code</summary>
 
 ```sql
select zip_code, count(*) NoPZ
from patients
group by zip_code
order by NoPZ Asc
Limit 10;
```
</details>


#### Claims Analysis: 

5. What is the total claim volume and value over time? How many claims are we processing, and how much do they cost year over year?

> Between the years 2023 and 2025, the data reveals a notable trend in claim volume and value. In 2024, the number of claims peaked at 100,361, resulting in the highest total claim value of approximately $2.59 billion. This marks a significant increase compared to 2023, which recorded 82,234 claims worth about $2.12 billion. However, by 2025, there was a sharp decline, with only 17,405 claims totaling around $449.6 million. This suggests that 2024 experienced the highest healthcare activity or utilization, while 2025 saw a substantial drop-off in both claim frequency and cost. The pattern may indicate a policy change, coverage shift, or behavioral shift in how services were accessed during that period.

> | provider_id | claim_count | TClaim_Value | AvgCCost  |
|-------------|-------------|--------------|-----------|
| 1868        | 55          | 1809032.8    | 32891.51  |
| 4195        | 60          | 1804410.92   | 30073.52  |
| 1423        | 64          | 1774069      | 27719.83  |
| 4179        | 59          | 1738137.93   | 29459.96  |
| 950         | 59          | 1706995.12   | 28932.12  |


> <img width="752" height="452" alt="image" src="https://github.com/user-attachments/assets/a957f11e-e2ca-4cf2-8977-24c20430f44a" />

<details>
  <summary>View Code</summary>
 
```sql
Select 
Date_format(claim_date, '%y-%m') as Claim_months, 
count(*) as NoC, 
round(sum(claim_amount),2) as Total_Claim_Value
from claims
group by claim_months
order by Total_Claim_Value;
```
</details>


6. What’s the average claim amount by status? Are rejected or pending claims costing us more or less?

> Across all claim statuses, a total of 140,566 approved claims recorded the highest volume and the highest average claim value at $26,106.94. In comparison, 19,973 pending claims had an average claim value of $25,087.35, while 39,461 rejected claims averaged slightly lower at $25,034.68. The relatively small variation in average claim value across statuses suggests that claim size alone may not be a primary determinant of approval. However, the significantly higher volume and value in the approved category indicate stronger validation or faster processing for standard claims, yet the lower figures in pending and rejected categories may signal issues with documentation, policy limits, or potential fraud flags.

> | Status   | No. of Claims | Avg. Claim Value (USD) |
| -------- | ------------- | ---------------------- |
| Approved | 140,566       | 26,106.94              |
| Pending  | 19,973        | 25,087.35              |
| Rejected | 39,461        | 25,034.68              |


> <img width="752" height="452" alt="image" src="https://github.com/user-attachments/assets/f28e85f2-3896-4527-aabb-35a570d32a19" />

<details>
  <summary>View Code</summary>
 
```sql
select status, 
COUNT(*) AS NoC,
ROUND(avg(claim_amount),2) as AvgClaim_Value
from claims 
group by status
order by AvgClaim_Value DESC;
```
</details>


7. Which providers are submitting the highest-value claims? Who are our most expensive providers — and do they align with quality?
>The top 5 highest-cost providers collectively billed over $8.8 million. Provider 1868 had the highest average claim cost at $32,891.51, while Provider 1423 had the most claims (64) but a lower average of $27,719.83. All five providers had average claim values above $27,000, signalling potential high-cost service areas that may require closer review or cost-control measures.

> | Provider ID | Claim Count | Total Claim Value (USD) | Average Claim Cost (USD) |
| ----------- | ----------- | ----------------------- | ------------------------ |
| 1868        | 55          | 1,809,032.80            | 32,891.51                |
| 4195        | 60          | 1,804,410.92            | 30,073.52                |
| 1423        | 64          | 1,774,069.00            | 27,719.83                |
| 4179        | 59          | 1,738,137.93            | 29,459.96                |
| 950         | 59          | 1,706,995.12            | 28,932.12                |


<details>
  <summary>View Code</summary>
 
```sql
Select provider_id, 
count(*) as claim_count,
round(sum(claim_amount), 2) as TClaim_Value,
round((round(sum(claim_amount), 2)/ COUNT(Provider_id)),2) as AvgCCost
from claims
group by provider_id
order by TClaim_Value Desc
Limit 5;
```
</details>

8. Are there spikes in claim submissions from certain patients or providers? Any behavioural outliers that suggest fraud or errors?”
>These patients consistently generate high-value claims, with each contributing over $400K. They may warrant further review for patterns, policy compliance, or potential risk management.

> | Patient ID | Claim Count | Total Claim Value (USD) |
| ---------- | ----------- | ----------------------- |
| 27071      | 15          | 697,056.93              |
| 7935       | 13          | 488,940.54              |
| 47318      | 15          | 469,451.00              |
| 37699      | 14          | 460,587.00              |
| 28425      | 11          | 434,163.94              |
| 20801      | 11          | 425,717.65              |
| 43209      | 13          | 419,157.00              |
| 48192      | 11          | 416,387.38              |
| 43126      | 12          | 407,117.22              |
| 11552      | 14          | 406,950.00              |

<details>
  <summary>View Code</summary>
 
```sql
SELECT 
  patient_id,
  COUNT(*) AS claim_count,
  round(SUM(claim_amount),2) AS TClaim_Value
FROM claims
GROUP BY patient_id
HAVING claim_count > 10
ORDER BY TClaim_Value DESC;
```
</details>

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



Payments Analysis: 

- What is the average payment amount per provider?

- What is the time lag between claim and payment?

- What percentage of claims were paid in full?

Provider Insights: 

- Which specialities submit the most claims?

- Which states or cities have the most active providers?

- Are there providers serving patients from multiple states?

Fraud & Behavioural Patterns: 

- Are there providers who submit many high-value claims in short timeframes?

- Are there any patients with consistent full payments received within one day?

- Do any patients have significantly higher claim frequencies than average?

#### Join-Based Relationship Analysis

Provider-Patient Relationship Mapping
 → Tracked patient loyalty by counting distinct patients per provider.

Claim vs Payment Matching
 → Compared claim and payment values to identify over- and underpayments.




