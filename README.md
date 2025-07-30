## Health Insurance Data Analysis

**A SQL-Powered Exploration of Utilisation, Payments, and Fraud Indicators**

Industry: Health Insurance | Data Analytics

Tools Used: SQL Workbench | Relational Database

### Project Overview

This project analyses health insurance data across four key entities: **patients, providers, claims, and payments**. The primary goal is to derive insights that help:

* Optimise healthcare operations
* Understand patient and provider behaviour
* Detect possible fraudulent or anomalous billing activities

All analyses were conducted using structured SQL queries, focusing on real-world patterns that could impact cost control, service delivery, and risk mitigation in the healthcare system.

### Datasets Used

* `Patients`: Demographic and geographic patient data
* `Providers`: Facility-level information
* `Claims`: Details of services rendered
* `Payments`: Financial information tied to claims

<img width="867" height="560" alt="ERD D" src="https://github.com/user-attachments/assets/3139d5c9-d06a-4b7d-a07e-de818cf8c778" />


These datasets are assumed to be joined via appropriate primary/foreign keys (e.g., `PatientID`, `ProviderID`, `ClaimID`).

### Key Areas of Analysis

#### 1. **Utilisation Patterns**

* Number of claims per patient and provider
* High-frequency users (patients with excessive claims)
* Distribution of services by state or region

#### 2. **Financial Behaviour**

* Average payment amounts per provider
* Unpaid or underpaid claims
* High-cost services and their frequency

#### 3. **Fraud Indicators**

* Duplicate claim entries (same date, patient, provider)
* Payments exceeding expected limits
* Providers with unusual billing frequencies
* Geographic mismatches (e.g., provider and patient in different regions)

Each fraud detection query is built using logical rules, but thresholds can be adjusted based on policy or real-world norms.

### Some Insights (based on SQL output)

*Over half (52%) of all patients are retirees aged 50+, underscoring a healthcare demand skewed toward older populations.

*Some patients submitted claims to multiple providers within tight 10–20 day windows, and others received services across 10+ states. These patterns may indicate complex treatment paths or suggest fragmentation or fraud risk, which needs further investigation.

* Despite a stable 90% reimbursement rate overall, repeated shortfalls of nearly 9,900 units per high-value claim suggest systemic underpayments that merit closer investigation.

### Tools Used

* **SQL Workbench** for query execution
* **Relational Schema** of 4 interlinked tables
* Data cleaning, filtering, and joins performed entirely in SQL
* MS Excel (Visuals)

### Next Steps
  
* Integrate a **dashboard layer** using Power BI, Excel, or Python

* Apply **anomaly detection algorithms** for enhanced fraud scoring
  
* Include **time-based trends** to identify seasonal or monthly patterns

### Conclusion

This project demonstrates how structured SQL analysis can uncover powerful operational and financial insights in healthcare data. From utilisation trends to fraud detection, the structured approach offers transparency and scalability, supporting smarter decision-making in the health insurance ecosystem.

 
## Insights (Report & Analysis)

#### Some Key Analytical Questions Answered

Patient Demographics & Behaviour: 

What is the demographic composition of our patient base? Who are our patients, and how are they distributed across age, gender, and insurance type?
Distribution across gender

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
 
 Distribution across age 
> The patient population is predominantly composed of older adults, with the largest segment being Retirees (50 years and above), representing approximately 52% of the total patients analysed. The Senior Adult group (31-49 years) accounts for about 25%, while Young Adults (18-30 years) make up the remaining 17%.

Notably, there are no patients below 18 years in the dataset, which might reflect the healthcare service’s target demographic or data capture limitations. Understanding this age distribution is critical for tailoring healthcare plans, resource allocation, and risk assessment models, especially since older populations tend to have higher healthcare needs and associated costs.

| Age Group    | Total Number of Patients (TNoP) | Percentage of Total Patients (%) |
| ------------ | ------------------------------- | -------------------------------- |
| Young Adult  | 9,120                           | 17.1%                            |
| Senior Adult | 13,294                          | 24.9%                            |
| Retirees     | 27,586                          | 51.7%                            |

<img width="752" height="452" alt="image" src="https://github.com/user-attachments/assets/bb332357-3189-45e1-a285-f74a8b0f6a6f" />

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

Which cities or states have the highest concentration of patients?
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

What is the age and gender breakdown across cities or states? Are seniors more concentrated in certain cities, or is a city more female-dominant?
> This provides a comprehensive breakdown of patient counts across multiple states, genders, and age groups, revealing varying demographic distributions that may indicate regional health trends and population differences.

| State       | Gender  | Age Group | Patient Count |
|-------------|---------|-----------|---------------|
| Alabama     | Female  | 18-34     | 108           |
| Alabama     | Female  | 35-54     | 128           |
| Alabama     | Female  | 55-74     | 140           |
| Alabama     | Female  | 75+       | 93            |
| Alabama     | Male    | 18-34     | 97            |
| Alabama     | Male    | 35-54     | 144           |
| Alabama     | Male    | 55-74     | 132           |
| Alabama     | Male    | 75+       | 119           |
| Alabama     | Other   | 18-34     | 12            |
| Alabama     | Other   | 35-54     | 10            |
| Alabama     | Other   | 55-74     | 14            |
| Alabama     | Other   | 75+       | 13            |
| Alaska      | Female  | 18-34     | 106           |
| Alaska      | Female  | 35-54     | 131           |
| Alaska      | Female  | 55-74     | 136           |
| Alaska      | Female  | 75+       | 109           |
| Alaska      | Male    | 18-34     | 119           |
| Alaska      | Male    | 35-54     | 128           |
| Alaska      | Male    | 55-74     | 131           |
| Alaska      | Male    | 75+       | 121           |
| Alaska      | Other   | 18-34     | 7             |
| Alaska      | Other   | 35-54     | 8             |
| Alaska      | Other   | 55-74     | 11            |
| Alaska      | Other   | 75+       | 7             |
| Arizona     | Female  | 18-34     | 101           |
| Arizona     | Female  | 35-54     | 137           |
| Arizona     | Female  | 55-74     | 138           |
| Arizona     | Female  | 75+       | 106           |
| Arizona     | Male    | 18-34     | 102           |
| Arizona     | Male    | 35-54     | 119           |
| Arizona     | Male    | 55-74     | 142           |
| Arizona     | Male    | 75+       | 96            |
| Arizona     | Other   | 18-34     | 11            |
| Arizona     | Other   | 35-54     | 5             |
| Arizona     | Other   | 55-74     | 11            |
| Arizona     | Other   | 75+       | 6             |
| Arkansas    | Female  | 18-34     | 97            |
| Arkansas    | Female  | 35-54     | 122           |
| Arkansas    | Female  | 55-74     | 121           |
| Arkansas    | Female  | 75+       | 115           |
| Arkansas    | Male    | 18-34     | 108           |
| Arkansas    | Male    | 35-54     | 139           |
| Arkansas    | Male    | 55-74     | 134           |
| Arkansas    | Male    | 75+       | 100           |
| Arkansas    | Other   | 18-34     | 11            |
| Arkansas    | Other   | 35-54     | 13            |
| Arkansas    | Other   | 55-74     | 10            |
| Arkansas    | Other   | 75+       | 5             |
| California  | Female  | 18-34     | 93            |
| California  | Female  | 35-54     | 135           |
| California  | Female  | 55-74     | 132           |
| California  | Female  | 75+       | 89            |
| California  | Male    | 18-34     | 113           |
| California  | Male    | 35-54     | 126           |
| California  | Male    | 55-74     | 139           |
| California  | Male    | 75+       | 107           |
| California  | Other   | 18-34     | 7             |
| California  | Other   | 35-54     | 5             |
| California  | Other   | 55-74     | 6             |
| California  | Other   | 75+       | 5             |
| Colorado    | Female  | 18-34     | 126           |
| Colorado    | Female  | 35-54     | 139           |
| Colorado    | Female  | 55-74     | 130           |
| Colorado    | Female  | 75+       | 96            |
| Colorado    | Male    | 18-34     | 116           |
| Colorado    | Male    | 35-54     | 132           |
| Colorado    | Male    | 55-74     | 122           |
| Colorado    | Male    | 75+       | 121           |
| Colorado    | Other   | 18-34     | 11            |
| Colorado    | Other   | 35-54     | 12            |
| Colorado    | Other   | 55-74     | 10            |
| Colorado    | Other   | 75+       | 8             |
| Connecticut | Female  | 18-34     | 117           |
| Connecticut | Female  | 35-54     | 132           |
| Connecticut | Female  | 55-74     | 133           |
| Connecticut | Female  | 75+       | 91            |
| Connecticut | Male    | 18-34     | 130           |
| Connecticut | Male    | 35-54     | 137           |
| Connecticut | Male    | 55-74     | 118           |
| Connecticut | Male    | 75+       | 103           |
| Connecticut | Other   | 18-34     | 3             |
| Connecticut | Other   | 35-54     | 9             |
| Connecticut | Other   | 55-74     | 11            |
| Connecticut | Other   | 75+       | 11            |
| Delaware    | Female  | 18-34     | 102           |
| Delaware    | Female  | 35-54     | 120           |
| Delaware    | Female  | 55-74     | 146           |
| Delaware    | Female  | 75+       | 101           |
| Delaware    | Male    | 18-34     | 109           |
| Delaware    | Male    | 35-54     | 110           |
| Delaware    | Male    | 55-74     | 118           |
| Delaware    | Male    | 75+       | 96            |
| Delaware    | Other   | 18-34     | 9             |
| Delaware    | Other   | 35-54     | 11            |
| Delaware    | Other   | 55-74     | 9             |
| Delaware    | Other   | 75+       | 13            |
| Florida     | Female  | 18-34     | 106           |
| Florida     | Female  | 35-54     | 128           |
| Florida     | Female  | 55-74     | 119           |
| Florida     | Female  | 75+       | 78            |
| Florida     | Male    | 18-34     | 110           |
| Florida     | Male    | 35-54     | 129           |
| Florida     | Male    | 55-74     | 140           |
| Florida     | Male    | 75+       | 90            |
| Florida     | Other   | 18-34     | 6             |
| Florida     | Other   | 35-54     | 15            |
| Florida     | Other   | 55-74     | 12            |
| Florida     | Other   | 75+       | 10            |
| Georgia     | Female  | 18-34     | 104           |
| Georgia     | Female  | 35-54     | 135           |
| Georgia     | Female  | 55-74     | 115           |
| Georgia     | Female  | 75+       | 90            |
| Georgia     | Male    | 18-34     | 114           |
| Georgia     | Male    | 35-54     | 143           |
| Georgia     | Male    | 55-74     | 99            |
| Georgia     | Male    | 75+       | 107           |
| Georgia     | Other   | 18-34     | 14            |
| Georgia     | Other   | 35-54     | 11            |
| Georgia     | Other   | 55-74     | 5             |
| Georgia     | Other   | 75+       | 8             |
| Hawaii      | Female  | 18-34     | 

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


#### Claims Analysis: 

What is the total claim volume and value over time? How many claims are we processing, and how much do they cost year over year?

> Between the years 2023 and 2025, the data reveals a notable trend in claim volume and value. In 2024, the number of claims peaked at 100,361, resulting in the highest total claim value of approximately $2.59 billion. This marks a significant increase compared to 2023, which recorded 82,234 claims worth about $2.12 billion. However, by 2025, there was a sharp decline, with only 17,405 claims totalling around $449.6 million. This suggests that 2024 experienced the highest healthcare activity or utilization, while 2025 saw a substantial drop-off in both claim frequency and cost. The pattern may indicate a policy change, coverage shift, or behavioral shift in how services were accessed during that period.

| provider_id | claim_count | TClaim_Value | AvgCCost  |
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

What’s the average claim amount by status? Are rejected or pending claims costing us more or less?

> Across all claim statuses, a total of 140,566 approved claims recorded the highest volume and the highest average claim value at $26,106.94. In comparison, 19,973 pending claims had an average claim value of $25,087.35, while 39,461 rejected claims averaged slightly lower at $25,034.68. The relatively small variation in average claim value across statuses suggests that claim size alone may not be a primary determinant of approval. However, the significantly higher volume and value in the approved category indicate stronger validation or faster processing for standard claims, yet the lower figures in pending and rejected categories may signal issues with documentation, policy limits, or potential fraud flags.

| Status   | No. of Claims | Avg. Claim Value (USD) |
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

Which providers are submitting the highest-value claims? Who are our most expensive providers — and do they align with quality?
>The top 5 highest-cost providers collectively billed over $8.8 million. Provider 1868 had the highest average claim cost at $32,891.51, while Provider 1423 had the most claims (64) but a lower average of $27,719.83. All five providers had average claim values above $27,000, signalling potential high-cost service areas that may require closer review or cost-control measures.

| Provider ID | Claim Count | Total Claim Value (USD) | Average Claim Cost (USD) |
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

Are there spikes in claim submissions from certain patients or providers? Any behavioural outliers that suggest fraud or errors?”
>These patients consistently generate high-value claims, with each contributing over $400K. They may warrant further review for patterns, policy compliance, or potential risk management.

| Patient ID | Claim Count | Total Claim Value (USD) |
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

#### Payments Analysis: 

What is the overall claim reimbursement rate?
> The reimbursement rate of 0.8998 (or approximately 89.98%) signifies that nearly 90% of the claimed amount is successfully reimbursed by the provider network. This is a strong indicator of efficient claims processing and high payment reliability within the system.

| Metric             | Value|
|--------------------|--------|
| Reimbursement Rate | 0.8998 | 

<details>
  <summary>View Code</summary>
 
```sql
select round(sum(payment_amount),2)/ round(sum(claim_amount),2) as reimbursement_rate
from payments;
```
</details>

How long does it typically take to get paid after a claim is submitted?
>An average wait period of 0.6647 (in days) suggests that, on average, claims or payments are being processed with a turnaround of just under 0.67 days. This quick turnaround highlights operational efficiency in processing claims, contributing to higher customer satisfaction and faster cash flow cycles.

| Metric             | Value   |
|--------------------|---------|
| Average Wait Period | 0.6647  | 

<details>
  <summary>View Code</summary>
 
 ```sql
 select avg(datediff(payment_date, claim_date)) as avg_Wait_period
from payments
WHERE payment_date IS NOT NULL AND claim_date IS NOT NULL;
 ```
 </details>

Which claims have the largest payment shortfalls?
> This shows a consistent payment shortfall of around 9,870 to 9,960 units per claim, roughly 20% less than the original claim amounts, indicating potential partial payments or claim denials due to policy or error factors. This highlights a critical area for investigation to distinguish between legitimate adjustments and avoidable disputes, presenting an opportunity to enhance provider relations and streamline reimbursement processes.

| claim_id | patient_id | claim_amount | payment_amount | shortfall |
|----------|------------|--------------|----------------|-----------|
| 156468   | 17087      | 49842        | 39882          | 9960      |
| 49282    | 18262      | 49951        | 40017          | 9934      |
| 193794   | 1719       | 49758        | 39825          | 9933      |
| 82768    | 23264      | 49765        | 39846          | 9919      |
| 127275   | 11444      | 49972        | 40061          | 9911      |
| 147190   | 38000      | 49946        | 40046          | 9900      |
| 31577    | 4545       | 49705        | 39809          | 9896      |
| 57942    | 24719      | 49601        | 39709          | 9892      |
| 169799   | 33120      | 49593        | 39704          | 9889      |
| 91429    | 24220      | 49446        | 39560          | 9886      |
| 160702   | 37743      | 49655        | 39777          | 9878      |
| 175264   | 19033      | 49817        | 39940          | 9877      |
| 10460    | 4638       | 49417        | 39544          | 9873      |
| 100692   | 44302      | 49980        | 40108          | 9872      |
| 169835   | 2648       | 49907        | 40037          | 9870      |


<details>
  <summary>View Code</summary>
 
```sql
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
```
</details>

How does the reimbursement rate vary by claim status?
>Across all claim statuses, the reimbursement rate hovers consistently around 90%, reflecting stable payout ratios despite pending or rejected claims. This consistency highlights robust claims processing practices but also signals opportunities to reduce pending and rejected volumes to improve cash flow and provider satisfaction.

| Status   | NoC    | Total Claim Amount | Sum(Payment Amount) | Reimbursement Rate |
|----------|--------|--------------------|---------------------|--------------------|
| Pending  | 15,091 | 379,015,468        | 341,276,916         | 0.9004             |
| Rejected | 29,932 | 749,114,563        | 674,179,094         | 0.9000             |
| Approved | 104,977| 2,641,339,389      | 2,376,234,701       | 0.8996             |

<details>
  <summary>View Code</summary>
 
```sql
select status,
count(*) as NoC,
sum(claim_amount) as total_claim,
sum(payment_amount),
round(sum(payment_amount),2)/ round(sum(claim_amount),2) as reimbursement_rate
from payments
group by status
order by reimbursement_rate Desc ;
```
</details>

Provider Insights: 

Which specialities are most represented across our provider network?
> The provider network is heavily weighted toward General Practitioners, ensuring strong primary care coverage, with Oncology and Orthopaedics following closely, indicating high specialist availability. This balance supports comprehensive patient care but also highlights opportunities to optimize resource allocation and monitor specialty-specific claim patterns for potential fraud risks. Leveraging this insight can enhance strategic contracting, improve operational KPIs, and drive data-driven decision-making across specialities.

| **Specialty**        | **Number of Providers** |
| -------------------- | ----------------------- |
| General Practitioner | 1031                    |
| Oncologist           | 1027                    |
| Orthopedic           | 1016                    |
| Dermatologist        | 967                     |
| Cardiologist         | 959                     |

<img width="800" height="373" alt="image" src="https://github.com/user-attachments/assets/287e2452-f3bf-436a-b475-50ff1f80b528" />

<details>
  <summary>View Code</summary>
```
select specialty, count(*) as Number_of_Providers
from providers
group by specialty
order by Number_of_Providers Desc;
```
</details>

How is our provider network distributed geographically?
> The geographic distribution reveals Maine, Wisconsin, and Arkansas as the top states by Geo_Dis score, indicating higher activity or network density in these regions. This pattern highlights regional concentration hotspots that can be leveraged for targeted resource deployment, tailored marketing efforts, and localised fraud detection strategies.

| State         | Geo_Dis |
|---------------|---------|
| Maine         | 129     |
| Wisconsin     | 124     |
| Arkansas      | 117     |
| Mississippi   | 116     |
| Montana       | 114     |
| Texas         | 113     |
| Indiana       | 112     |
| Ohio          | 111     |
| Missouri      | 111     |
| Utah          | 109     |
| Florida       | 108     |
| Washington    | 108     |
| Nevada        | 107     |
| Minnesota     | 106     |
| New York      | 106     |
| Maryland      | 106     |
| Massachusetts | 105     |
| Hawaii        | 105     |
| Kentucky      | 104     |
| Wyoming       | 104     |
| Illinois      | 103     |
| Vermont       | 102     |
| Alaska        | 101     |
| North Carolina| 101     |
| West Virginia | 101     |
| Michigan      | 100     |
| New Mexico    | 100     |
| South Carolina| 99      |
| New Hampshire | 98      |
| Alabama       | 97      |
| California    | 96      |
| South Dakota  | 95      |
| Virginia      | 95      |
| New Jersey    | 95      |
| Connecticut   | 94      |
| Idaho         | 94      |
| Oregon        | 92      |
| Louisiana     | 90      |
| Tennessee     | 89      |
| Colorado      | 88      |
| Oklahoma      | 88      |
| North Dakota  | 88      |
| Delaware      | 88      |
| Rhode Island  | 87      |
| Nebraska      | 87      |
| Georgia       | 87      |
| Pennsylvania  | 87      |
| Arizona       | 85      |
| Iowa          | 79      |
| Kansas        | 79      |

<details>
  <summary>View Code</summary>
 
```sql
select state, count(*) as Geo_Dis
from providers
group by state
order by Geo_Dis Desc;
```
</details>

Which specialities are concentrated in specific states or cities?
> General Practitioners dominate provider counts in many states, while Cardiologists and Oncologists lead in select regions like Arkansas and Montana. Orthopaedic and dermatological specialities show strong regional presence, reflecting diverse healthcare demands. This state-speciality distribution can guide strategic resource allocation and targeted healthcare initiatives.

| State         | Specialty           | Geo_Dis |
|---------------|---------------------|---------|
| Maine         | General Practitioner| 36      |
| Arkansas      | Cardiologist        | 34      |
| West Virginia | Orthopedic          | 33      |
| Maine         | Oncologist          | 32      |
| Indiana       | Orthopedic          | 30      |
| Texas         | Cardiologist        | 29      |
| Wyoming       | Cardiologist        | 29      |
| Montana       | Oncologist          | 29      |
| Wisconsin     | General Practitioner| 28      |
| Utah          | Oncologist          | 28      |
| Kentucky      | General Practitioner| 28      |
| Florida       | Dermatologist       | 27      |
| Wisconsin     | Oncologist          | 27      |
| North Carolina| Orthopedic          | 27      |
| Arizona       | Orthopedic          | 27      |
| Kentucky      | Orthopedic          | 27      |
| New Jersey    | General Practitioner| 27      |
| New Hampshire | Cardiologist        | 27      |
| Idaho         | Cardiologist        | 26      |
| New York      | Oncologist          | 26      |
| Maryland      | Oncologist          | 26      |
| Maine         | Dermatologist       | 26      |
| Missouri      | Oncologist          | 26      |
| Minnesota     | General Practitioner| 26      |
| Alabama       | Dermatologist       | 26      |
| Indiana       | Oncologist          | 26      |
| South Carolina| Cardiologist        | 26      |
| Ohio          | Orthopedic          | 26      |
| Wisconsin     | Orthopedic          | 26      |
| Mississippi   | General Practitioner| 25      |
| South Dakota  | Orthopedic          | 25      |
| Minnesota     | Orthopedic          | 25      |
| Washington    | Dermatologist       | 25      |
| Mississippi   | Orthopedic          | 25      |
| Illinois      | Orthopedic          | 25      |
| Pennsylvania  | General Practitioner| 25      |
| Montana       | Dermatologist       | 25      |
| Ohio          | Dermatologist       | 24      |
| Illinois      | Oncologist          | 24      |
| Nevada        | Oncologist          | 24      |
| Missouri      | General Practitioner| 24      |
| Nevada        | General Practitioner| 24      |
| Michigan      | Oncologist          | 24      |
| North Dakota  | Oncologist          | 24      |
| Hawaii        | General Practitioner| 24      |
| Massachusetts | Oncologist          | 24      |
| Alaska        | General Practitioner| 24      |
| Missouri      | Orthopedic          | 24      |
| Mississippi   | Oncologist          | 24      |
| Vermont       | Oncologist          | 24      |
| Connecticut   | General Practitioner| 23      |
| Vermont       | Dermatologist       | 23      |
| Virginia      | General Practitioner| 23      |
| California    | Cardiologist        | 23      |
| Hawaii        | Dermatologist       | 23      |
| Arkansas      | Orthopedic          | 23      |
| Iowa          | General Practitioner| 23      |
| North Carolina| General Practitioner| 23      |
| Utah          | Dermatologist       | 23      |
| Wisconsin     | Cardiologist        | 23      |
| Massachusetts | General Practitioner| 23      |
| New Mexico    | General Practitioner| 23      |
| New Mexico    | Oncologist          | 23      |
| Tennessee     | General Practitioner| 23      |
| Michigan      | Orthopedic          | 23      |
| Virginia      | Oncologist          | 23      |
| New Jersey    | Orthopedic          | 23      |
| Arkansas      | Dermatologist       | 23      |
| North Carolina| Oncologist          | 23      |
| Texas         | Dermatologist       | 22      |
| Indiana       | General Practitioner| 22      |
| Washington    | Oncologist          | 22      |
| Hawaii        | Cardiologist        | 22      |
| Georgia       | Cardiologist        | 22      |
| Utah          | Cardiologist        | 22      |
| Ohio          | General Practitioner| 22      |
| Colorado      | Cardiologist        | 22      |
| Missouri      | Dermatologist       | 22      |
| Texas         | Orthopedic          | 22      |
| Alaska        | Dermatologist       | 22      |
| New York      | Orthopedic          | 22      |
| Oregon        | Orthopedic          | 21      |
| Michigan      | General Practitioner| 21      |
| Oklahoma      | Cardiologist        | 21      |
| Maryland      | Cardiologist        | 21      |
| Rhode Island  | Cardiologist        | 21      |
| Arkansas      | Oncologist          | 21      |
| Nebraska      | Oncologist          | 21      |
| California    | Oncologist          | 21      |
| Connecticut   | Orthopedic          | 21      |
| Louisiana    | Oncologist          | 21      |
| Louisiana    | Orthopedic          | 21      |
| Mississippi  | Cardiologist        | 21      |
| Montana      | Orthopedic          | 21      |
| Minnesota    | Cardiologist        | 21      |
| Washington   | Cardiologist        | 21      |
| Tennessee    | Dermatologist       | 21      |
| Wyoming      | General Practitioner| 21      |
| Hawaii       | Orthopedic          | 21      |
| Nevada       | Cardiologist        | 21      |
| Washington   | Orthopedic          | 21      |
| Montana      | Cardiologist        | 21      |
| South Dakota | Oncologist          | 21      |
| Wyoming      | Dermatologist       | 21      |
| Maryland     | Dermatologist       | 21      |
| Maine        | Orthopedic          | 21      |
| Connecticut  | Dermatologist       | 21      |
| Florida      | General Practitioner| 21      |
| Vermont      | Orthopedic          | 21      |
| New York     | Dermatologist       | 21      |
| Mississippi  | Dermatologist       | 21      |
| Texas        | General Practitioner| 20      |
| Rhode Island | Dermatologist       | 20      |
| Florida      | Oncologist          | 20      |
| Idaho        | General Practitioner| 20      |
| Texas        | Oncologist          | 20      |
| Florida      | Cardiologist        | 20      |
| New Hampshire| Orthopedic          | 20      |
| South Carolina| Dermatologist      | 20      |
| Illinois     | Dermatologist       | 20      |
| Massachusetts| Orthopedic          | 20      |
| Massachusetts| Cardiologist        | 20      |
| California  | General Practitioner| 20      |
| Alaska      | Cardiologist        | 20      |
| New York    | General Practitioner| 20      |
| Wisconsin   | Dermatologist       | 20      |
| North Dakota| General Practitioner| 20      |
| Delaware   | General Practitioner| 20      |
| Ohio       | Oncologist          | 20      |
| Indiana    | Dermatologist       | 20      |
| Oklahoma   | Dermatologist       | 20      |
| Florida    | Orthopedic          | 20      |
| West Virginia| General Practitioner| 20      |
| Georgia    | Oncologist          | 20      |
| Oregon     | Oncologist          | 19      |
| Nevada     | Orthopedic          | 19      |
| Maryland   | General Practitioner| 19      |
| Idaho      | Oncologist          | 19      |
| West Virginia| Oncologist        | 19      |
| Georgia    | Orthopedic          | 19      |
| Oregon     | General Practitioner| 19      |
| Kentucky   | Dermatologist       | 19      |
| Alabama    | Cardiologist        | 19      |
| Washington | General Practitioner| 19      |
| North Dakota| Dermatologist       | 19      |
| New Hampshire| Dermatologist     | 19      |
| Nevada     | Dermatologist       | 19      |
| New Mexico | Dermatologist       | 19      |
| South Dakota| Dermatologist      | 19      |
| Delaware   | Cardiologist        | 19      |
| Ohio       | Cardiologist        | 19      |
| Kansas     | Cardiologist        | 19      |
| Illinois   | Cardiologist        | 19      |
| Utah       | General Practitioner| 19      |
| West Virginia| Cardiologist      | 19      |
| Oregon     | Dermatologist       | 19      |
| Maryland   | Orthopedic          | 19      |
| New Jersey | Cardiologist        | 19      |
| Nebraska   | Cardiologist        | 19      |
| Alaska     | Orthopedic          | 19      |
| Alabama    | General Practitioner| 19      |
| South Carolina| Orthopedic       | 18      |
| California | Orthopedic          | 18      |
| Vermont    | General Practitioner| 18      |
| Oklahoma   | General Practitioner| 18      |
| Pennsylvania| Dermatologist      | 18      |
| Massachusetts| Dermatologist     | 18      |
| Louisiana  | Cardiologist        | 18      |
| South Carolina| General Practitioner| 18     |
| Montana    | General Practitioner| 18      |
| Pennsylvania| Oncologist         | 18      |
| Colorado   | Oncologist          | 18      |
| Kansas     | Oncologist          | 18      |
| New Mexico | Cardiologist        | 18      |
| Michigan   | Dermatologist       | 18      |
| Iowa       | Cardiologist        | 18      |
| Alabama    | Orthopedic          | 18      |
| Connecticut| Oncologist          | 18      |
| Nebraska   | General Practitioner| 18      |
| Louisiana  | Dermatologist       | 18      |
| Tennessee  | Oncologist          | 17      |
| Minnesota  | Oncologist          | 17      |
| Minnesota  | Dermatologist       | 17      |
| Rhode Island| General Practitioner| 17      |
| Colorado   | Dermatologist       | 17      |
| Utah       | Orthopedic          | 17      |
| Virginia   | Cardiologist        | 17      |
| New York   | Cardiologist        | 17      |
| Delaware   | Orthopedic          | 17      |
| North Carolina| Dermatologist     | 17      |
| Wyoming    | Orthopedic          | 17      |
| New Mexico | Orthopedic          | 17      |
| South Carolina| Oncologist       | 17      |
| South Dakota| General Practitioner| 16      |
| North Dakota| Orthopedic          | 16      |
| Virginia   | Orthopedic          | 16      |
| Idaho      | Orthopedic          | 16      |
| Colorado   | Orthopedic          | 16      |
| Tennessee  | Cardiologist        | 16      |
| Arkansas   | General Practitioner| 16      |
| Wyoming    | Oncologist          | 16      |
| New Hampshire| Oncologist        | 16      |
| Delaware   | Dermatologist       | 16      |
| Kentucky   | Oncologist          | 16      |
| New Hampshire| General Practitioner| 16      |
| Virginia   | Dermatologist       | 16      |
| Vermont    | Cardiologist        | 16      |
| Delaware   | Oncologist          | 16      |
| Arizona    | General Practitioner| 16      |
| Oklahoma   | Oncologist          | 16      |
| Alaska     | Oncologist          | 16      |
| Rhode Island| Oncologist         | 15      |
| Nebraska   | Dermatologist       | 15      |
| Hawaii     | Oncologist          | 15      |
| Arizona    | Dermatologist       | 15      |
| Missouri   | Cardiologist        | 15      |
| Colorado   | General Practitioner| 15      |
| Kansas     | Orthopedic          | 15      |
| Arizona    | Oncologist          | 15      |
| Illinois   | General Practitioner| 15      |
| Kansas     | Dermatologist       | 15      |
| Alabama    | Oncologist          | 15      |
| Michigan   | Cardiologist        | 14      |
| Nebraska   | Orthopedic          | 14      |
| Maine      | Cardiologist        | 14      |
| Pennsylvania| Orthopedic         | 14      |
| Georgia    | Dermatologist       | 14      |
| Oregon     | Cardiologist        | 14      |
| Indiana    | Cardiologist        | 14      |
| California | Dermatologist       | 14      |
| Iowa       | Oncologist          | 14      |
| Rhode Island| Orthopedic         | 14      |
| South Dakota| Cardiologist       | 14      |
| Kentucky   | Cardiologist        | 14      |
| Oklahoma   | Orthopedic          | 13      |
| Idaho      | Dermatologist       | 13      |
| New Jersey | Dermatologist       | 13      |
| New Jersey | Oncologist          | 13      |
| Iowa       | Dermatologist       | 13      |
| Tennessee  | Orthopedic          | 12      |
| Pennsylvania| Cardiologist       | 12      |
| Georgia    | General Practitioner| 12      |
| Louisiana  | General Practitioner| 12      |
| Arizona    | Cardiologist        | 12      |
| Kansas     | General Practitioner| 12      |
| Connecticut| Cardiologist        | 11      |
| North Carolina| Cardiologist      | 11      |
| Iowa       | Orthopedic          | 11      |
| West Virginia| Dermatologist     | 10      |
| North Dakota| Cardiologist        | 9       |

<details>
  <summary>View Code</summary>
 
```sql
select state, specialty, count(*) as Geo_Dis
from providers
group by state, specialty
order by Geo_Dis desc;
```
</details>

Are there providers with duplicate phone numbers or suspicious records?
> There are none.

<details>
  <summary>View Code</summary>
 
```sql
select provider_id, count(*)
from providers
where phone > 1
group by provider_id;
```
</details>

### FRAUD DETECTION AND BEHAVIOURAL ANALYSIS
Are there patients submitting claims to multiple providers within a very short timeframe?
>Most patients engage with 3 to 4 unique providers over claim periods ranging from just a few days up to 20 days. The span between their first and last claims varies, indicating varying care continuity or treatment complexity. This pattern highlights opportunities to optimize patient-provider coordination to improve care efficiency and patient outcomes.

| patient_id | unique_providers | first_claim | last_claim  | span_days |
|------------|------------------|-------------|-------------|-----------|
| 1812       | 4                | 2025-01-11  | 2025-01-27  | 16        |
| 1425       | 3                | 2023-12-04  | 2023-12-23  | 19        |
| 2311       | 3                | 2024-09-02  | 2024-09-17  | 15        |
| 3988       | 3                | 2023-12-19  | 2023-12-30  | 11        |
| 5790       | 3                | 2024-09-18  | 2024-10-07  | 19        |
| 9360       | 3                | 2024-04-16  | 2024-05-02  | 16        |
| 12251      | 3                | 2024-08-03  | 2024-08-13  | 10        |
| 12253      | 3                | 2024-04-28  | 2024-05-14  | 16        |
| 13805      | 3                | 2024-01-31  | 2024-02-14  | 14        |
| 20350      | 3                | 2023-09-20  | 2023-10-03  | 13        |
| 21493      | 3                | 2024-02-19  | 2024-03-08  | 18        |
| 22476      | 3                | 2024-07-05  | 2024-07-23  | 18        |
| 28845      | 3                | 2024-03-23  | 2024-04-07  | 15        |
| 34646      | 3                | 2024-07-24  | 2024-08-11  | 18        |
| 36857      | 3                | 2023-12-14  | 2023-12-16  | 2         |
| 37855      | 3                | 2024-02-24  | 2024-03-10  | 15        |
| 37987      | 3                | 2023-03-18  | 2023-04-04  | 17        |
| 39188      | 3                | 2024-12-21  | 2025-01-10  | 20        |
| 44710      | 3                | 2024-08-26  | 2024-09-09  | 14        |
| 44923      | 3                | 2024-12-15  | 2025-01-03  | 19        |
| 47144      | 3                | 2024-09-06  | 2024-09-10  | 4         |
| 49047      | 3                | 2024-01-23  | 2024-02-04  | 12        |

<details>
  <summary>View Code</summary>
 
```sql
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
```
</details>

Do any providers consistently file high numbers of claims on non-working days (weekends, holidays)?

| provider_id | weekend_claims |
|-------------|----------------|
| 4696        | 24             |
| 753         | 24             |
| 898         | 23             |
| 362         | 23             |
| 4195        | 23             |
| 4334        | 23             |
| 3718        | 23             |
| 1559        | 22             |
| 1456        | 22             |
| 1587        | 22             |

> Top 10 providers show high weekend claim activity, indicating strong off-peak service engagement. This pattern offers opportunities for targeted audits and strategic support of weekend operations.

<details>
  <summary>View Code</summary>
 
```
SELECT 
  provider_id,
  COUNT(*) AS weekend_claims
FROM claims
WHERE DAYOFWEEK(claim_date) IN (1, 7) -- Sunday(1), Saturday(7)
GROUP BY provider_id
ORDER BY weekend_claims DESC
LIMIT 10;
```
</details>

Are there claims with full payments made unusually fast (same day or within 1 day)?
>None!

<details>
  <summary>View Code</summary>
 
```sql
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
```
</details>

Are there payment records where the total payment exceeds the total claimed amount for a provider or patient?
>None

<details>
  <summary>View Code</summary>
 
 ```
select provider_id, 
sum(payment_amount) as total_payment,
sum(claim_amount) as claimed_amount,
(sum(payment_amount) - sum(claim_amount)) as overpaid_amount
from payments
group by provider_id
having overpaid_amount > 0
order by overpaid_amount DESC;
```
</details>

Which providers have unusually high total claim amounts but very low patient counts?
>None

<details>
  <summary>View Code</summary>
 
```sql
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
 ```
</details>

Which patients have received payments for claims from multiple providers in different cities or states?
>Absolutely! Patients receiving payments for claims from multiple providers across different cities and states, such as patients 44603, 30761, and 30381, highlight complex healthcare interactions involving several providers and geographic locations. This multi-provider, multi-city, and multi-state payment pattern can signal intricate care pathways or potential red flags for further investigation, making these patients prime candidates for deeper analysis to optimise care coordination or detect possible fraud.

| patient_id | cities_used | states_used | providers_seen |
|------------|-------------|-------------|---------------|
| 44603      | 12          | 9           | 12            |
| 30761      | 12          | 11          | 12            |
| 30381      | 11          | 9           | 11            |
| 30970      | 11          | 9           | 11            |
| 24744      | 11          | 10          | 11            |
| 27071      | 11          | 9           | 11            |
| 110        | 11          | 11          | 11            |
| 949        | 11          | 10          | 11            |
| 5213       | 11          | 8           | 11            |
| 15446      | 11          | 11          | 11            |
| 42253      | 11          | 10          | 11            |
| 44478      | 11          | 10          | 11            |
| 47132      | 11          | 10          | 11            |
| 8760       | 11          | 11          | 11            |
| 11558      | 11          | 8           | 11            |
| 11991      | 11          | 10          | 11            |
| 37699      | 11          | 11          | 11            |
| 36776      | 10          | 10          | 10            |
| 37114      | 10          | 9           | 10            |
| 38056      | 10          | 10          | 10            |
| 38186      | 10          | 9           | 10            |
| 38422      | 10          | 8           | 10            |
| 39766      | 10          | 10          | 10            |
| 41815      | 10          | 9           | 10            |
| 70         | 10          | 8           | 10            |
| 1615       | 10          | 10          | 10            |
| 3807       | 10          | 10          | 10            |
| 5069       | 10          | 8           | 10            |
| 5330       | 10          | 9           | 10            |
| 5396       | 10          | 9           | 10            |
| 28921      | 10          | 10          | 10            |
| 30072      | 10          | 10          | 10            |
| 30655      | 10          | 9           | 10            |
| 31181      | 10          | 10          | 10            |
| 32494      | 10          | 10          | 10            |
| 33170      | 10          | 10          | 10            |
| 33409      | 10          | 9           | 10            |
| 34271      | 9           | 10          | 10            |
| 34806      | 10          | 10          | 10            |
| 22934      | 10          | 10          | 10            |
| 24465      | 10          | 8           | 10            |
| 25191      | 10          | 8           | 10            |
| 26757      | 10          | 8           | 10            |
| 27908      | 10          | 9           | 10            |
| 7935       | 10          | 10          | 10            |
| 8995       | 10          | 10          | 10            |
| 12982      | 10          | 10          | 10            |
| 13706      | 10          | 10          | 10            |
| 16429      | 10          | 9           | 10            |
| 16835      | 10          | 9           | 10            |
| 17903      | 10          | 7           | 10            |
| 42947      | 10          | 10          | 10            |
| 43209      | 10          | 10          | 10            |
| 44830      | 10          | 10          | 10            |
| 47318      | 10          | 10          | 10            |
| 47491      | 10          | 7           | 10            |
| 47876      | 10          | 9           | 10            |
| 48069      | 10          | 9           | 10            |
| 48674      | 10          | 7           | 10            |
| 42074      | 9           | 9           | 9             |
| 42433      | 9           | 8           | 9             |
| 43024      | 9           | 9           | 9             |
| 43906      | 9           | 8           | 9             |
| 44597      | 9           | 8           | 9             |
| 44622      | 9           | 7           | 9             |
| 45039      | 9           | 8           | 9             |
| 45150      | 9           | 9           | 9             |
| 45671      | 9           | 9           | 9             |
| 46578      | 9           | 9           | 9             |
| 46797      | 9           | 7           | 9             |
| 46904      | 9           | 8           | 9             |
| 46996      | 9           | 8           | 9             |
| 48557      | 9           | 8           | 9             |
| 48737      | 9           | 8           | 9             |

<details>
  <summary>View Code</summary>
 
```sql
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
```
</details>
