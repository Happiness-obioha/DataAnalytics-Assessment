WITH customer_txn_summary AS (
    SELECT
        s.owner_id,
        COUNT(*) AS total_txn,
        PERIOD_DIFF(
            CAST(DATE_FORMAT(NOW(), '%Y%m') AS UNSIGNED),
            CAST(DATE_FORMAT(MIN(s.transaction_date), '%Y%m') AS UNSIGNED)
        ) + 1 AS active_months,
        COUNT(*) / (
            PERIOD_DIFF(
                CAST(DATE_FORMAT(NOW(), '%Y%m') AS UNSIGNED),
                CAST(DATE_FORMAT(MIN(s.transaction_date), '%Y%m') AS UNSIGNED)
            ) + 1
        ) AS avg_txn_per_month
    FROM
        savings_savingsaccount s
    GROUP BY
        s.owner_id
)
SELECT
    CASE
        WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM
    customer_txn_summary
GROUP BY
    frequency_category
ORDER BY
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
