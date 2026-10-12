-- =========================================================
-- CASE STUDY 155: Travel Agency Booking Management
-- Database Management Systems
-- =========================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS travel_agency_db;

-- Select Database
USE travel_agency_db;


-- =========================================================
-- 1. CREATE DOMESTIC BOOKINGS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS domestic_bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    booking_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);


-- =========================================================
-- 2. CREATE INTERNATIONAL BOOKINGS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS international_bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    booking_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);


-- =========================================================
-- 3. INSERT DOMESTIC BOOKING DATA
-- =========================================================

INSERT INTO domestic_bookings
(customer_name, destination, booking_date, amount)
VALUES
('Asha', 'Goa', '2026-01-10', 15000),
('Vikram', 'Jaipur', '2026-01-15', 12000),
('Rohan', 'Kerala', '2026-02-05', 18000),
('Meera', 'Goa', '2026-02-20', 14000);


-- =========================================================
-- 4. INSERT INTERNATIONAL BOOKING DATA
-- =========================================================

INSERT INTO international_bookings
(customer_name, destination, booking_date, amount)
VALUES
('Asha', 'Dubai', '2026-03-10', 45000),
('Vikram', 'Singapore', '2026-03-15', 55000),
('Rohan', 'Bangkok', '2026-04-05', 40000),
('Meera', 'Dubai', '2026-04-20', 48000),
('Asha', 'Singapore', '2026-05-01', 52000);


-- =========================================================
-- 5. UNION - UNIQUE CUSTOMERS
-- =========================================================

SELECT customer_name
FROM domestic_bookings

UNION

SELECT customer_name
FROM international_bookings;


-- =========================================================
-- 6. UNION ALL - ALL CUSTOMERS INCLUDING DUPLICATES
-- =========================================================

SELECT customer_name
FROM domestic_bookings

UNION ALL

SELECT customer_name
FROM international_bookings;


-- =========================================================
-- 7. CUSTOMERS PRESENT IN BOTH DATASETS
-- =========================================================

SELECT DISTINCT d.customer_name
FROM domestic_bookings d
INNER JOIN international_bookings i
ON d.customer_name = i.customer_name;


-- =========================================================
-- 8. ALL DESTINATIONS
-- =========================================================

SELECT destination
FROM domestic_bookings

UNION

SELECT destination
FROM international_bookings;


-- =========================================================
-- 9. TOTAL BOOKING COUNT PER CUSTOMER
-- =========================================================

SELECT
    customer_name,
    COUNT(*) AS booking_count
FROM (
    SELECT customer_name
    FROM domestic_bookings

    UNION ALL

    SELECT customer_name
    FROM international_bookings
) AS all_bookings
GROUP BY customer_name;


-- =========================================================
-- 10. DOMESTIC VS INTERNATIONAL BOOKING COMPARISON
-- =========================================================

SELECT
    customer_name,
    SUM(domestic_count) AS domestic_bookings,
    SUM(international_count) AS international_bookings,
    SUM(domestic_count + international_count) AS total_bookings
FROM (
    SELECT
        customer_name,
        COUNT(*) AS domestic_count,
        0 AS international_count
    FROM domestic_bookings
    GROUP BY customer_name

    UNION ALL

    SELECT
        customer_name,
        0 AS domestic_count,
        COUNT(*) AS international_count
    FROM international_bookings
    GROUP BY customer_name
) AS booking_summary
GROUP BY customer_name;


-- =========================================================
-- 11. COMBINED BOOKING REPORT
-- =========================================================

SELECT
    customer_name,
    destination,
    booking_date,
    amount,
    'Domestic' AS booking_type
FROM domestic_bookings

UNION ALL

SELECT
    customer_name,
    destination,
    booking_date,
    amount,
    'International' AS booking_type
FROM international_bookings;


-- =========================================================
-- 12. TOTAL AMOUNT SPENT BY EACH CUSTOMER
-- =========================================================

SELECT
    customer_name,
    SUM(amount) AS total_amount
FROM (
    SELECT customer_name, amount
    FROM domestic_bookings

    UNION ALL

    SELECT customer_name, amount
    FROM international_bookings
) AS all_bookings
GROUP BY customer_name;


-- =========================================================
-- 13. HIGHEST-SPENDING CUSTOMER
-- =========================================================

SELECT
    customer_name,
    SUM(amount) AS total_amount
FROM (
    SELECT customer_name, amount
    FROM domestic_bookings

    UNION ALL

    SELECT customer_name, amount
    FROM international_bookings
) AS all_bookings
GROUP BY customer_name
ORDER BY total_amount DESC
LIMIT 1;


-- =========================================================
-- 14. DOMESTIC-ONLY CUSTOMERS
-- =========================================================

SELECT DISTINCT d.customer_name
FROM domestic_bookings d
WHERE NOT EXISTS (
    SELECT 1
    FROM international_bookings i
    WHERE i.customer_name = d.customer_name
);


-- =========================================================
-- 15. INTERNATIONAL-ONLY CUSTOMERS
-- =========================================================

SELECT DISTINCT i.customer_name
FROM international_bookings i
WHERE NOT EXISTS (
    SELECT 1
    FROM domestic_bookings d
    WHERE d.customer_name = i.customer_name
);


-- =========================================================
-- 16. FINAL VERIFICATION
-- =========================================================

SELECT DATABASE();

SHOW TABLES;

SELECT * FROM domestic_bookings;

SELECT * FROM international_bookings;

SELECT COUNT(*) AS domestic_count
FROM domestic_bookings;

SELECT COUNT(*) AS international_count
FROM international_bookings;