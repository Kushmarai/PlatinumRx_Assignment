-- 1.For every user in the system, get the user_id and last booked room_no

SELECT u.user_id, b.room_no 
FROM users u INNER JOIN bookings b 
ON u.user_id = b.user_id 
WHERE b.booking_date = (SELECT max(bookings.booking_date) FROM bookings WHERE bookings.user_id = u.user_id);

-- 2.Get booking_id and total billing amount of every booking created in November, 2021

SELECT b.booking_id, SUM(i.item_rate*bc.item_quantity) AS total_billing_amount 
FROM bookings b 
JOIN booking_commercials bc ON b.booking_id = bc.booking_id 
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date)=11 AND YEAR(b.booking_date)=2021
GROUP BY b.booking_id;

-- 3. Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount >1000

SELECT bc.bill_id, SUM(i.item_rate*bc.item_quantity) AS bill_amount
FROM booking_commercials bc 
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date)=2021
GROUP BY bc.bill_id 
HAVING bill_amount > 1000;

-- 4. Determine the most ordered and least ordered item of each month of year 2021

WITH monthly_orders AS (
    SELECT 
        MONTH(bc.bill_date) AS month,
        i.item_name,
        SUM(bc.item_quantity) AS total_quantity,
        RANK() OVER (PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity) DESC) AS rank_most,
        RANK() OVER (PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity) ASC) AS rank_least
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), i.item_name
)
SELECT 
    month,
    MAX(CASE WHEN rank_most = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rank_least = 1 THEN item_name END) AS least_ordered_item
FROM monthly_orders
GROUP BY month
ORDER BY month;

-- 5. Find the customers with the second highest bill value of each month of year 2021

WITH bill_totals AS (
    SELECT
        MONTH(bc.bill_date) AS month,
        bc.bill_id,
        u.user_id,
        u.name,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount,
        RANK() OVER (PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity * i.item_rate) DESC) AS rnk
    FROM booking_commercials bc
    JOIN items    i ON bc.item_id    = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users    u ON b.user_id     = u.user_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), bc.bill_id, u.user_id, u.name
)
SELECT
    month,
    bill_id,
    name AS customer_name,
    bill_amount
FROM bill_totals
WHERE rnk = 2
ORDER BY month;