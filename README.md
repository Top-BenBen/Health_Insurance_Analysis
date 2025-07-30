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




