
# Healthcare Analytics Project Documentation

#### Title: Data-Driven Insights for Healthcare Utilisation & Fraud Detection

 Industry: Health Insurance | Data Analytics
 
 Tools Used: SQL Workbench | Relational Database
 
#### 1. Project Overview
This project explores health insurance datasets to uncover patterns in patient behaviour, provider practices, claim efficiency, and potential fraud. The analysis is grounded in transactional data captured across four key tables: patients, claims, payments, and providers.


#### Dataset Source & Summary
The source of the dataset: The dataset was downloaded from Kaggle[`https://www.kaggle.com/datasets/jaiswalmagic1/healthcare-fraud-detection-dataset1`]

Summary: 

Patients: Demographics of insured individuals included the following columns: patient_id, age, gender, city/state

Claims: Submitted healthcare claims containing transactional records, including: claim_id, patient_id, provider_id, claim_date, claim_amount, status

Payments: Records of payments processed for submitted claims, including: payment_id, claim_id, patient_id, provider_id, claim_date, payment_date, claim_amount, payment_amount, status

Providers: Details about healthcare service providers, including: provider_id, name, speciality, city/state, zip_code, phone

#### Some Key Analytical Questions Answered

Patient Demographics & Behaviour: 

- What is the gender distribution of patients?

- What is the age distribution of patients?

- Which cities or states have the highest concentration of patients?

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


#### Summary & Recommendations
Findings:

The majority of patients are concentrated in major cities with younger age brackets.

Most claims are approved, but payment timelines vary widely.

A few providers and patients display unusual behaviour — possible fraud signals.

#### Recommendations:

Build real-time monitoring dashboards for claim/payment lag.

Trigger automated fraud alerts for high-value, same-day payment claims.

Cross-analyse with treatment or diagnosis data in future iterations.
