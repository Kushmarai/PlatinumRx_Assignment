-- 1. Find the revenue we got from each sales channel in a given year

SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- 2. Find top 10 the most valuable customers for a given year

SELECT
    cs.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- 3. Find month wise revenue, expense, profit , status (profitable / not-profitable) for a given year
WITH monthly_revenue AS (
    SELECT
        MONTH(datetime) AS month,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
monthly_expense AS (
    SELECT
        MONTH(datetime) AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT
    r.month,
    r.revenue,
    COALESCE(e.expense, 0) AS expense,
    (r.revenue - COALESCE(e.expense, 0)) AS profit,
    CASE
        WHEN (r.revenue - COALESCE(e.expense, 0)) > 0 THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON r.month = e.month
ORDER BY r.month;

-- 4. For each city find the most profitable clinic for a given month

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        MONTH(cs.datetime) AS month,
        SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cl.cid, cl.clinic_name, cl.city, MONTH(cs.datetime)
),
clinic_expense AS (
    SELECT
        cid,
        MONTH(datetime) AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, MONTH(datetime)
),
clinic_net AS (
    SELECT
        p.city,
        p.clinic_name,
        p.month,
        (p.revenue - COALESCE(e.expense, 0)) AS profit,
        RANK() OVER (PARTITION BY p.city, p.month
                     ORDER BY (p.revenue - COALESCE(e.expense, 0)) DESC) AS rnk
    FROM clinic_profit p
    LEFT JOIN clinic_expense e ON p.cid = e.cid AND p.month = e.month
)
SELECT city, clinic_name, month, profit
FROM clinic_net
WHERE rnk = 1
ORDER BY month, city;

-- 5. For each state find the second least profitable clinic for a given month

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        MONTH(cs.datetime) AS month,
        SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cl.cid, cl.clinic_name, cl.state, MONTH(cs.datetime)
),
clinic_expense AS (
    SELECT
        cid,
        MONTH(datetime) AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, MONTH(datetime)
),
clinic_net AS (
    SELECT
        p.state,
        p.clinic_name,
        p.month,
        (p.revenue - COALESCE(e.expense, 0)) AS profit,
        RANK() OVER (PARTITION BY p.state, p.month
                     ORDER BY (p.revenue - COALESCE(e.expense, 0)) ASC) AS rnk
    FROM clinic_profit p
    LEFT JOIN clinic_expense e ON p.cid = e.cid AND p.month = e.month
)
SELECT state, clinic_name, month, profit
FROM clinic_net
WHERE rnk = 2
ORDER BY month, state;
