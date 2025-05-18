# DataAnalytics-Assessment

This repository contains my solutions to an SQL proficiency assessment involving customer and transaction data. It evaluates data retrieval, aggregation, filtering, joins, and customer insights.


## Question 1: High-Value Customers with Multiple Products

**Objective:** Identify customers who own both a savings plan and an investment plan, sorted by total deposits.

**Approach:**
- Joined `users_customuser`, `plans_plan`, and `savings_savingsaccount`.
- Used `CASE` + `COUNT(DISTINCT ...)` to count plan types.
- Aggregated confirmed deposit inflows.
- Filtered for customers who own **both** plan types.

 **Challenges:** 
- Ensuring that savings transactions were linked to the correct plans using both owner_id and plan_id.
- Cleaning null values from name fields using `CONCAT_WS()` for fallback.




## Question 2: Transaction Frequency Analysis

**Objective:** Categorize customers by their average number of deposit transactions per month.

**Approach:**
- Calculated the number of active months per user using PERIOD_DIFF.
- Calculated average transactions per month and categorized them using a CASE statement.
- Grouped and averaged results by frequency category

 **Challenges:**
- PERIOD_DIFF() required CAST(... AS UNSIGNED) because it only accepts numeric YYYYMM format.



## Question 3: Account Inactivity Alert

**Objective:** Identify active savings or investment plans with **no inflow** in the last **365 days**.

**Approach:**
- Used LEFT JOIN to include even plans with no transactions.
- Grouped by plan and calculated the last transaction date using MAX().
- Filtered using DATEDIFF() and HAVING.
- Classified plan types as "Savings" or "Investment".

 **Challenges:**
- Ensured that both plans with zero transactions and stale transactions were flagged correctly


## Question 4: Customer Lifetime Value (CLV) Estimation

**Objective:** Estimate each customer’s CLV using account tenure and average profit per transaction.

**Formula:**

CLV=( Total Transactions/ Tenure)×12×0.1%×Average Transaction Value

**Approach:**
- TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) → tenure in months
- AVG(s.confirmed_amount) → average transaction value
- Multiplied by 0.1% profit rate
- GREATEST(..., 1) avoids divide-by-zero for very recent signups
- Final CLV is rounded to 2 decimal places and expressed in Naira.


**Challenges:**
 - Getting the tenure logic and averaging per user required multiple steps, and ensuring that kobo-to-naira conversion was consistently applied.
  




