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
> state	gender	age_group	patient_count
Alabama	Female	18-34	108
Alabama	Female	35-54	128
Alabama	Female	55-74	140
Alabama	Female	75+	93
Alabama	Male	18-34	97
Alabama	Male	35-54	144
Alabama	Male	55-74	132
Alabama	Male	75+	119
Alabama	Other	18-34	12
Alabama	Other	35-54	10
Alabama	Other	55-74	14
Alabama	Other	75+	13
Alaska	Female	18-34	106
Alaska	Female	35-54	131
Alaska	Female	55-74	136
Alaska	Female	75+	109
Alaska	Male	18-34	119
Alaska	Male	35-54	128
Alaska	Male	55-74	131
Alaska	Male	75+	121
Alaska	Other	18-34	7
Alaska	Other	35-54	8
Alaska	Other	55-74	11
Alaska	Other	75+	7
Arizona	Female	18-34	101
Arizona	Female	35-54	137
Arizona	Female	55-74	138
Arizona	Female	75+	106
Arizona	Male	18-34	102
Arizona	Male	35-54	119
Arizona	Male	55-74	142
Arizona	Male	75+	96
Arizona	Other	18-34	11
Arizona	Other	35-54	5
Arizona	Other	55-74	11
Arizona	Other	75+	6
Arkansas	Female	18-34	97
Arkansas	Female	35-54	122
Arkansas	Female	55-74	121
Arkansas	Female	75+	115
Arkansas	Male	18-34	108
Arkansas	Male	35-54	139
Arkansas	Male	55-74	134
Arkansas	Male	75+	100
Arkansas	Other	18-34	11
Arkansas	Other	35-54	13
Arkansas	Other	55-74	10
Arkansas	Other	75+	5
California	Female	18-34	93
California	Female	35-54	135
California	Female	55-74	132
California	Female	75+	89
California	Male	18-34	113
California	Male	35-54	126
California	Male	55-74	139
California	Male	75+	107
California	Other	18-34	7
California	Other	35-54	5
California	Other	55-74	6
California	Other	75+	5
Colorado	Female	18-34	126
Colorado	Female	35-54	139
Colorado	Female	55-74	130
Colorado	Female	75+	96
Colorado	Male	18-34	116
Colorado	Male	35-54	132
Colorado	Male	55-74	122
Colorado	Male	75+	121
Colorado	Other	18-34	11
Colorado	Other	35-54	12
Colorado	Other	55-74	10
Colorado	Other	75+	8
Connecticut	Female	18-34	117
Connecticut	Female	35-54	132
Connecticut	Female	55-74	133
Connecticut	Female	75+	91
Connecticut	Male	18-34	130
Connecticut	Male	35-54	137
Connecticut	Male	55-74	118
Connecticut	Male	75+	103
Connecticut	Other	18-34	3
Connecticut	Other	35-54	9
Connecticut	Other	55-74	11
Connecticut	Other	75+	11
Delaware	Female	18-34	102
Delaware	Female	35-54	120
Delaware	Female	55-74	146
Delaware	Female	75+	101
Delaware	Male	18-34	109
Delaware	Male	35-54	110
Delaware	Male	55-74	118
Delaware	Male	75+	96
Delaware	Other	18-34	9
Delaware	Other	35-54	11
Delaware	Other	55-74	9
Delaware	Other	75+	13
Florida	Female	18-34	106
Florida	Female	35-54	128
Florida	Female	55-74	119
Florida	Female	75+	78
Florida	Male	18-34	110
Florida	Male	35-54	129
Florida	Male	55-74	140
Florida	Male	75+	90
Florida	Other	18-34	6
Florida	Other	35-54	15
Florida	Other	55-74	12
Florida	Other	75+	10
Georgia	Female	18-34	104
Georgia	Female	35-54	135
Georgia	Female	55-74	115
Georgia	Female	75+	90
Georgia	Male	18-34	114
Georgia	Male	35-54	143
Georgia	Male	55-74	99
Georgia	Male	75+	107
Georgia	Other	18-34	14
Georgia	Other	35-54	11
Georgia	Other	55-74	5
Georgia	Other	75+	8
Hawaii	Female	18-34	107
Hawaii	Female	35-54	131
Hawaii	Female	55-74	123
Hawaii	Female	75+	86
Hawaii	Male	18-34	125
Hawaii	Male	35-54	123
Hawaii	Male	55-74	137
Hawaii	Male	75+	80
Hawaii	Other	18-34	5
Hawaii	Other	35-54	7
Hawaii	Other	55-74	13
Hawaii	Other	75+	7
Idaho	Female	18-34	107
Idaho	Female	35-54	139
Idaho	Female	55-74	139
Idaho	Female	75+	90
Idaho	Male	18-34	101
Idaho	Male	35-54	147
Idaho	Male	55-74	159
Idaho	Male	75+	105
Idaho	Other	18-34	10
Idaho	Other	35-54	12
Idaho	Other	55-74	14
Idaho	Other	75+	6
Illinois	Female	18-34	113
Illinois	Female	35-54	126
Illinois	Female	55-74	135
Illinois	Female	75+	106
Illinois	Male	18-34	126
Illinois	Male	35-54	140
Illinois	Male	55-74	132
Illinois	Male	75+	96
Illinois	Other	18-34	10
Illinois	Other	35-54	14
Illinois	Other	55-74	17
Illinois	Other	75+	10
Indiana	Female	18-34	97
Indiana	Female	35-54	134
Indiana	Female	55-74	133
Indiana	Female	75+	98
Indiana	Male	18-34	111
Indiana	Male	35-54	124
Indiana	Male	55-74	118
Indiana	Male	75+	103
Indiana	Other	18-34	13
Indiana	Other	35-54	15
Indiana	Other	55-74	8
Indiana	Other	75+	5
Iowa	Female	18-34	121
Iowa	Female	35-54	123
Iowa	Female	55-74	138
Iowa	Female	75+	112
Iowa	Male	18-34	100
Iowa	Male	35-54	132
Iowa	Male	55-74	133
Iowa	Male	75+	95
Iowa	Other	18-34	8
Iowa	Other	35-54	14
Iowa	Other	55-74	10
Iowa	Other	75+	7
Kansas	Female	18-34	127
Kansas	Female	35-54	139
Kansas	Female	55-74	146
Kansas	Female	75+	101
Kansas	Male	18-34	122
Kansas	Male	35-54	134
Kansas	Male	55-74	154
Kansas	Male	75+	90
Kansas	Other	18-34	11
Kansas	Other	35-54	9
Kansas	Other	55-74	12
Kansas	Other	75+	13
Kentucky	Female	18-34	103
Kentucky	Female	35-54	126
Kentucky	Female	55-74	166
Kentucky	Female	75+	113
Kentucky	Male	18-34	128
Kentucky	Male	35-54	129
Kentucky	Male	55-74	129
Kentucky	Male	75+	85
Kentucky	Other	18-34	10
Kentucky	Other	35-54	9
Kentucky	Other	55-74	14
Kentucky	Other	75+	10
Louisiana	Female	18-34	133
Louisiana	Female	35-54	127
Louisiana	Female	55-74	145
Louisiana	Female	75+	102
Louisiana	Male	18-34	104
Louisiana	Male	35-54	152
Louisiana	Male	55-74	112
Louisiana	Male	75+	107
Louisiana	Other	18-34	12
Louisiana	Other	35-54	11
Louisiana	Other	55-74	21
Louisiana	Other	75+	7
Maine	Female	18-34	104
Maine	Female	35-54	120
Maine	Female	55-74	157
Maine	Female	75+	105
Maine	Male	18-34	103
Maine	Male	35-54	130
Maine	Male	55-74	139
Maine	Male	75+	82
Maine	Other	18-34	5
Maine	Other	35-54	13
Maine	Other	55-74	6
Maine	Other	75+	6
Maryland	Female	18-34	132
Maryland	Female	35-54	146
Maryland	Female	55-74	139
Maryland	Female	75+	87
Maryland	Male	18-34	113
Maryland	Male	35-54	137
Maryland	Male	55-74	144
Maryland	Male	75+	87
Maryland	Other	18-34	11
Maryland	Other	35-54	12
Maryland	Other	55-74	13
Maryland	Other	75+	6
Massachusetts	Female	18-34	122
Massachusetts	Female	35-54	154
Massachusetts	Female	55-74	123
Massachusetts	Female	75+	94
Massachusetts	Male	18-34	121
Massachusetts	Male	35-54	115
Massachusetts	Male	55-74	127
Massachusetts	Male	75+	108
Massachusetts	Other	18-34	8
Massachusetts	Other	35-54	15
Massachusetts	Other	55-74	8
Massachusetts	Other	75+	13
Michigan	Female	18-34	96
Michigan	Female	35-54	143
Michigan	Female	55-74	142
Michigan	Female	75+	103
Michigan	Male	18-34	124
Michigan	Male	35-54	131
Michigan	Male	55-74	140
Michigan	Male	75+	112
Michigan	Other	18-34	8
Michigan	Other	35-54	15
Michigan	Other	55-74	11
Michigan	Other	75+	7
Minnesota	Female	18-34	112
Minnesota	Female	35-54	141
Minnesota	Female	55-74	135
Minnesota	Female	75+	110
Minnesota	Male	18-34	115
Minnesota	Male	35-54	144
Minnesota	Male	55-74	126
Minnesota	Male	75+	86
Minnesota	Other	18-34	4
Minnesota	Other	35-54	7
Minnesota	Other	55-74	9
Minnesota	Other	75+	7
Mississippi	Female	18-34	122
Mississippi	Female	35-54	133
Mississippi	Female	55-74	145
Mississippi	Female	75+	95
Mississippi	Male	18-34	110
Mississippi	Male	35-54	129
Mississippi	Male	55-74	107
Mississippi	Male	75+	91
Mississippi	Other	18-34	5
Mississippi	Other	35-54	14
Mississippi	Other	55-74	11
Mississippi	Other	75+	15
Missouri	Female	18-34	131
Missouri	Female	35-54	130
Missouri	Female	55-74	138
Missouri	Female	75+	104
Missouri	Male	18-34	127
Missouri	Male	35-54	134
Missouri	Male	55-74	134
Missouri	Male	75+	96
Missouri	Other	18-34	13
Missouri	Other	35-54	10
Missouri	Other	55-74	15
Missouri	Other	75+	7
Montana	Female	18-34	109
Montana	Female	35-54	124
Montana	Female	55-74	134
Montana	Female	75+	114
Montana	Male	18-34	133
Montana	Male	35-54	116
Montana	Male	55-74	124
Montana	Male	75+	100
Montana	Other	18-34	7
Montana	Other	35-54	14
Montana	Other	55-74	11
Montana	Other	75+	13
Nebraska	Female	18-34	106
Nebraska	Female	35-54	130
Nebraska	Female	55-74	135
Nebraska	Female	75+	98
Nebraska	Male	18-34	120
Nebraska	Male	35-54	120
Nebraska	Male	55-74	125
Nebraska	Male	75+	105
Nebraska	Other	18-34	9
Nebraska	Other	35-54	11
Nebraska	Other	55-74	8
Nebraska	Other	75+	12
Nevada	Female	18-34	113
Nevada	Female	35-54	130
Nevada	Female	55-74	134
Nevada	Female	75+	85
Nevada	Male	18-34	125
Nevada	Male	35-54	123
Nevada	Male	55-74	123
Nevada	Male	75+	91
Nevada	Other	18-34	12
Nevada	Other	35-54	10
Nevada	Other	55-74	12
Nevada	Other	75+	10
New Hampshire	Female	18-34	105
New Hampshire	Female	35-54	126
New Hampshire	Female	55-74	125
New Hampshire	Female	75+	97
New Hampshire	Male	18-34	122
New Hampshire	Male	35-54	146
New Hampshire	Male	55-74	117
New Hampshire	Male	75+	85
New Hampshire	Other	18-34	11
New Hampshire	Other	35-54	13
New Hampshire	Other	55-74	12
New Hampshire	Other	75+	14
New Jersey	Female	18-34	105
New Jersey	Female	35-54	141
New Jersey	Female	55-74	152
New Jersey	Female	75+	84
New Jersey	Male	18-34	122
New Jersey	Male	35-54	130
New Jersey	Male	55-74	116
New Jersey	Male	75+	98
New Jersey	Other	18-34	12
New Jersey	Other	35-54	8
New Jersey	Other	55-74	12
New Jersey	Other	75+	8
New Mexico	Female	18-34	115
New Mexico	Female	35-54	140
New Mexico	Female	55-74	108
New Mexico	Female	75+	104
New Mexico	Male	18-34	119
New Mexico	Male	35-54	122
New Mexico	Male	55-74	131
New Mexico	Male	75+	87
New Mexico	Other	18-34	11
New Mexico	Other	35-54	6
New Mexico	Other	55-74	13
New Mexico	Other	75+	13
New York	Female	18-34	100
New York	Female	35-54	131
New York	Female	55-74	140
New York	Female	75+	92
New York	Male	18-34	115
New York	Male	35-54	121
New York	Male	55-74	123
New York	Male	75+	100
New York	Other	18-34	7
New York	Other	35-54	10
New York	Other	55-74	10
New York	Other	75+	6
North Carolina	Female	18-34	109
North Carolina	Female	35-54	113
North Carolina	Female	55-74	120
North Carolina	Female	75+	94
North Carolina	Male	18-34	136
North Carolina	Male	35-54	139
North Carolina	Male	55-74	106
North Carolina	Male	75+	104
North Carolina	Other	18-34	8
North Carolina	Other	35-54	9
North Carolina	Other	55-74	17
North Carolina	Other	75+	8
North Dakota	Female	18-34	120
North Dakota	Female	35-54	131
North Dakota	Female	55-74	125
North Dakota	Female	75+	95
North Dakota	Male	18-34	116
North Dakota	Male	35-54	129
North Dakota	Male	55-74	144
North Dakota	Male	75+	116
North Dakota	Other	18-34	13
North Dakota	Other	35-54	9
North Dakota	Other	55-74	17
North Dakota	Other	75+	6
Ohio	Female	18-34	106
Ohio	Female	35-54	144
Ohio	Female	55-74	133
Ohio	Female	75+	116
Ohio	Male	18-34	113
Ohio	Male	35-54	146
Ohio	Male	55-74	137
Ohio	Male	75+	91
Ohio	Other	18-34	8
Ohio	Other	35-54	17
Ohio	Other	55-74	10
Ohio	Other	75+	8
Oklahoma	Female	18-34	115
Oklahoma	Female	35-54	142
Oklahoma	Female	55-74	158
Oklahoma	Female	75+	103
Oklahoma	Male	18-34	108
Oklahoma	Male	35-54	151
Oklahoma	Male	55-74	114
Oklahoma	Male	75+	118
Oklahoma	Other	18-34	12
Oklahoma	Other	35-54	10
Oklahoma	Other	55-74	11
Oklahoma	Other	75+	12
Oregon	Female	18-34	100
Oregon	Female	35-54	114
Oregon	Female	55-74	153
Oregon	Female	75+	106
Oregon	Male	18-34	114
Oregon	Male	35-54	122
Oregon	Male	55-74	119
Oregon	Male	75+	110
Oregon	Other	18-34	12
Oregon	Other	35-54	12
Oregon	Other	55-74	13
Oregon	Other	75+	8
Pennsylvania	Female	18-34	129
Pennsylvania	Female	35-54	142
Pennsylvania	Female	55-74	130
Pennsylvania	Female	75+	96
Pennsylvania	Male	18-34	135
Pennsylvania	Male	35-54	147
Pennsylvania	Male	55-74	124
Pennsylvania	Male	75+	92
Pennsylvania	Other	18-34	11
Pennsylvania	Other	35-54	15
Pennsylvania	Other	55-74	11
Pennsylvania	Other	75+	9
Rhode Island	Female	18-34	114
Rhode Island	Female	35-54	149
Rhode Island	Female	55-74	114
Rhode Island	Female	75+	109
Rhode Island	Male	18-34	125
Rhode Island	Male	35-54	139
Rhode Island	Male	55-74	131
Rhode Island	Male	75+	109
Rhode Island	Other	18-34	10
Rhode Island	Other	35-54	14
Rhode Island	Other	55-74	13
Rhode Island	Other	75+	5
South Carolina	Female	18-34	101
South Carolina	Female	35-54	131
South Carolina	Female	55-74	138
South Carolina	Female	75+	115
South Carolina	Male	18-34	120
South Carolina	Male	35-54	122
South Carolina	Male	55-74	140
South Carolina	Male	75+	95
South Carolina	Other	18-34	9
South Carolina	Other	35-54	15
South Carolina	Other	55-74	9
South Carolina	Other	75+	7
South Dakota	Female	18-34	124
South Dakota	Female	35-54	146
South Dakota	Female	55-74	124
South Dakota	Female	75+	102
South Dakota	Male	18-34	118
South Dakota	Male	35-54	143
South Dakota	Male	55-74	119
South Dakota	Male	75+	99
South Dakota	Other	18-34	10
South Dakota	Other	35-54	10
South Dakota	Other	55-74	12
South Dakota	Other	75+	4
Tennessee	Female	18-34	112
Tennessee	Female	35-54	116
Tennessee	Female	55-74	131
Tennessee	Female	75+	102
Tennessee	Male	18-34	123
Tennessee	Male	35-54	129
Tennessee	Male	55-74	134
Tennessee	Male	75+	97
Tennessee	Other	18-34	15
Tennessee	Other	35-54	11
Tennessee	Other	55-74	11
Tennessee	Other	75+	8
Texas	Female	18-34	107
Texas	Female	35-54	132
Texas	Female	55-74	140
Texas	Female	75+	84
Texas	Male	18-34	123
Texas	Male	35-54	142
Texas	Male	55-74	132
Texas	Male	75+	100
Texas	Other	18-34	14
Texas	Other	35-54	13
Texas	Other	55-74	10
Texas	Other	75+	12
Utah	Female	18-34	115
Utah	Female	35-54	136
Utah	Female	55-74	141
Utah	Female	75+	109
Utah	Male	18-34	128
Utah	Male	35-54	128
Utah	Male	55-74	135
Utah	Male	75+	103
Utah	Other	18-34	10
Utah	Other	35-54	12
Utah	Other	55-74	14
Utah	Other	75+	8
Vermont	Female	18-34	98
Vermont	Female	35-54	124
Vermont	Female	55-74	123
Vermont	Female	75+	104
Vermont	Male	18-34	115
Vermont	Male	35-54	125
Vermont	Male	55-74	142
Vermont	Male	75+	119
Vermont	Other	18-34	15
Vermont	Other	35-54	15
Vermont	Other	55-74	15
Vermont	Other	75+	6
Virginia	Female	18-34	118
Virginia	Female	35-54	133
Virginia	Female	55-74	121
Virginia	Female	75+	105
Virginia	Male	18-34	137
Virginia	Male	35-54	142
Virginia	Male	55-74	130
Virginia	Male	75+	89
Virginia	Other	18-34	9
Virginia	Other	35-54	10
Virginia	Other	55-74	6
Virginia	Other	75+	10
Washington	Female	18-34	120
Washington	Female	35-54	160
Washington	Female	55-74	135
Washington	Female	75+	100
Washington	Male	18-34	99
Washington	Male	35-54	133
Washington	Male	55-74	157
Washington	Male	75+	112
Washington	Other	18-34	12
Washington	Other	35-54	11
Washington	Other	55-74	11
Washington	Other	75+	13
West Virginia	Female	18-34	120
West Virginia	Female	35-54	145
West Virginia	Female	55-74	144
West Virginia	Female	75+	108
West Virginia	Male	18-34	120
West Virginia	Male	35-54	124
West Virginia	Male	55-74	120
West Virginia	Male	75+	96
West Virginia	Other	18-34	3
West Virginia	Other	35-54	11
West Virginia	Other	55-74	12
West Virginia	Other	75+	7
Wisconsin	Female	18-34	129
Wisconsin	Female	35-54	115
Wisconsin	Female	55-74	144
Wisconsin	Female	75+	104
Wisconsin	Male	18-34	104
Wisconsin	Male	35-54	122
Wisconsin	Male	55-74	140
Wisconsin	Male	75+	104
Wisconsin	Other	18-34	13
Wisconsin	Other	35-54	9
Wisconsin	Other	55-74	11
Wisconsin	Other	75+	8
Wyoming	Female	18-34	108
Wyoming	Female	35-54	118
Wyoming	Female	55-74	134
Wyoming	Female	75+	103
Wyoming	Male	18-34	124
Wyoming	Male	35-54	148
Wyoming	Male	55-74	145
Wyoming	Male	75+	94
Wyoming	Other	18-34	17
Wyoming	Other	35-54	13
Wyoming	Other	55-74	6
Wyoming	Other	75+	7
<img width="257" height="12021" alt="image" src="https://github.com/user-attachments/assets/55c59060-ef01-4230-9910-b11a17abfcf8" />


<details>
  <summary>View Code</summary>

 ``` SQL
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






Claims Analysis: 

- What is the average claim amount per provider?

- How many claims are submitted per patient on average?

- What is the monthly trend of submitted claims?

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




