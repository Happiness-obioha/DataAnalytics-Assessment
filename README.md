# DataAnalytics-Assessment

This repository contains my solutions to an SQL proficiency assessment involving customer and transaction data. It evaluates data retrieval, aggregation, filtering, joins, and customer insights.


## Question 1: High-Value Customers with Multiple Products

**Objective:** Identify customers who own both a savings plan and an investment plan, sorted by total deposits.

**Approach:**
- Joined `users_customuser`, `plans_plan`, and `savings_savingsaccount`.
- Used `CASE` + `COUNT(DISTINCT ...)` to count plan types.
- Aggregated confirmed deposit inflows.
- Filtered for customers who own **both** plan types.
  

## Question 2: Transaction Frequency Analysis

**Objective:** Categorize customers by their average number of deposit transactions per month.

**Approach:**
- Calculated months of activity from first transaction to now.
- Computed average transactions per month.
- Classified users as **High**, **Medium**, or **Low Frequency** using a `CASE` statement.
- Aggregated counts by category.



## Question 3: Account Inactivity Alert

**Objective:** Identify active savings or investment plans with **no inflow** in the last **365 days**.

**Approach:**
- Joined `plans_plan` with `savings_savingsaccount`.
- Used `MAX(transaction_date)` to find last inflow.
- Filtered plans with `DATEDIFF > 365` or no transactions at all using `LEFT JOIN`.
- Classified plan types as "Savings" or "Investment".

---

## Question 4: Customer Lifetime Value (CLV) Estimation

**Objective:** Estimate each customer’s CLV using account tenure and average profit per transaction.

**Formula:**

\[
CLV = \left( \frac{\text{Transactions}}{\text{Tenure in Months}} \right) \times 12 \times 0.1\% \text{ of average transaction}
\]

**Approach:**
- Used `TIMESTAMPDIFF` to get tenure in months.
- Counted deposit transactions.
- Calculated average confirmed inflow per user.
- Applied the formula and ordered by CLV descending.

---

## Challenges

- Ensuring compatibility with **MySQL 8** functions like `PERIOD_DIFF`, `TIMESTAMPDIFF`, and CTEs.
- Avoiding divide-by-zero by wrapping tenure in `GREATEST(..., 1)`.
- Cleaning null values from name fields using `CONCAT_WS()` for fallback.



