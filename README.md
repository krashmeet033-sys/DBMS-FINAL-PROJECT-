# Travel Agency Booking Management System

A SQL-based Database Management System (DBMS) case study that manages domestic and international travel bookings and demonstrates the use of `UNION`, `UNION ALL`, `INNER JOIN`, aggregate functions, and set operations in MySQL.

## Project Overview

Travel agencies manage bookings for customers travelling to different domestic and international destinations. This project uses MySQL to store booking information in separate tables and generate combined reports for customer analysis.

The database contains two tables, `domestic_bookings` and `international_bookings`, which store customer names, destinations, booking dates, and booking amounts.

The project demonstrates how SQL queries can combine booking records, identify common customers, display unique destinations, and compare booking counts.

## Case Study Details

- **Case Study Number:** 155
- **Project Title:** Travel Agency Booking Management
- **Domain:** Database Management Systems (DBMS)
- **Database:** MySQL
- **Language:** SQL

## Objectives

- Combine domestic and international customer records using `UNION`.
- Display all customer records, including duplicates, using `UNION ALL`.
- Identify customers who have bookings in both datasets.
- Generate a combined list of unique travel destinations.
- Calculate the total number of bookings made by each customer.
- Compare domestic and international booking counts.
- Generate combined booking reports and customer spending summaries.
- Verify database tables, sample records, and booking counts.

## Technologies Used

- **MySQL** — Database creation, table management, and SQL query execution.
- **SQL** — Data definition, data insertion, joins, set operations, and aggregation.
- **VS Code** — Project file management and SQL script editing.
- **Git and GitHub** — Version control and project hosting.

## Repository Structure

```text
DBMS-FINAL-PROJECT-/
├── database.sql
├── terminal-output.txt
└── README.md
```

| File | Description |
|---|---|
| `database.sql` | SQL script containing database and table creation, sample data, analysis queries, and final verification statements. |
| `terminal-output.txt` | Recorded MySQL terminal session showing database selection, table verification, sample records, query results, and table structures. |
| `README.md` | Project overview, objectives, setup instructions, and query explanations. |

## Database Design

The project uses two tables.

### 1. `domestic_bookings`

Stores domestic travel booking records.

| Column | Data Type | Description |
|---|---|---|
| `booking_id` | INT | Primary key with auto-increment |
| `customer_name` | VARCHAR(100) | Name of the customer |
| `destination` | VARCHAR(100) | Domestic travel destination |
| `booking_date` | DATE | Date of booking |
| `amount` | DECIMAL(10,2) | Booking amount |

### 2. `international_bookings`

Stores international travel booking records using the same column structure.

| Column | Data Type | Description |
|---|---|---|
| `booking_id` | INT | Primary key with auto-increment |
| `customer_name` | VARCHAR(100) | Name of the customer |
| `destination` | VARCHAR(100) | International travel destination |
| `booking_date` | DATE | Date of booking |
| `amount` | DECIMAL(10,2) | Booking amount |

**Note:** Each table has its own primary key. The shared customer names are used to compare booking records across the two tables.

## Sample Data

The database contains the following sample records:

### Domestic Bookings

| Customer | Destination | Booking Date | Amount |
|---|---|---|---:|
| Asha | Goa | 2026-01-10 | 15,000 |
| Vikram | Jaipur | 2026-01-15 | 12,000 |
| Rohan | Kerala | 2026-02-05 | 18,000 |
| Meera | Goa | 2026-02-20 | 14,000 |

### International Bookings

| Customer | Destination | Booking Date | Amount |
|---|---|---|---:|
| Asha | Dubai | 2026-03-10 | 45,000 |
| Vikram | Singapore | 2026-03-15 | 55,000 |
| Rohan | Bangkok | 2026-04-05 | 40,000 |
| Meera | Dubai | 2026-04-20 | 48,000 |
| Asha | Singapore | 2026-05-01 | 52,000 |

## SQL Concepts Demonstrated

### 1. UNION — Unique Customers

Combines customer names from both tables and removes duplicate values.

```sql
SELECT customer_name
FROM domestic_bookings
UNION
SELECT customer_name
FROM international_bookings;
```

**Result:** 4 unique customers — Asha, Vikram, Rohan, and Meera.

### 2. UNION ALL — All Customer Records

Combines both sets of customer records while preserving duplicates.

```sql
SELECT customer_name
FROM domestic_bookings
UNION ALL
SELECT customer_name
FROM international_bookings;
```

**Result:** 9 records, representing all domestic and international bookings.

### 3. INNER JOIN — Customers in Both Tables

Identifies customers who appear in both booking tables.

```sql
SELECT DISTINCT d.customer_name
FROM domestic_bookings d
INNER JOIN international_bookings i
ON d.customer_name = i.customer_name;
```

**Result:** All 4 customers appear in both datasets.

### 4. UNION — Unique Destinations

Combines domestic and international destinations into one list without duplicates.

```sql
SELECT destination
FROM domestic_bookings
UNION
SELECT destination
FROM international_bookings;
```

**Result:** 6 unique destinations — Goa, Jaipur, Kerala, Dubai, Singapore, and Bangkok.

### 5. UNION ALL and GROUP BY — Booking Counts

Combines the customer names from both tables and counts the number of bookings for each customer.

```sql
SELECT customer_name, COUNT(*) AS booking_count
FROM (
    SELECT customer_name
    FROM domestic_bookings
    UNION ALL
    SELECT customer_name
    FROM international_bookings
) AS all_bookings
GROUP BY customer_name;
```

**Result:**

| Customer | Total Bookings |
|---|---:|
| Asha | 3 |
| Vikram | 2 |
| Rohan | 2 |
| Meera | 2 |

### Additional Queries

The `database.sql` file also includes queries for:

- Comparing domestic and international booking counts per customer.
- Generating a combined booking report with a booking type.
- Calculating the total amount spent by each customer.
- Identifying the highest-spending customer.
- Finding domestic-only and international-only customers.
- Verifying the selected database, tables, and record counts.

These additional queries extend the analysis beyond the core case study objectives.

## How to Run the Project

### Prerequisites

- MySQL installed and running.
- A terminal application, such as the macOS Terminal.
- The `database.sql` file from this repository.

### Step 1: Download or Clone the Repository

```bash
git clone https://github.com/krashmeet033-sys/DBMS-FINAL-PROJECT-.git
cd DBMS-FINAL-PROJECT-
```

Alternatively, download the repository using GitHub's **Code → Download ZIP** option.

### Step 2: Start MySQL

On macOS with MySQL installed through Homebrew:

```bash
brew services start mysql
```

If the service is already running, MySQL can be used without restarting it.

### Step 3: Open the MySQL Monitor

```bash
mysql -u root
```

Use the appropriate MySQL username if your installation uses a different account.

### Step 4: Execute the SQL Script

From the regular terminal, in the repository directory, run:

```bash
mysql -u root < database.sql
```

If your MySQL account requires a password, use your configured authentication method.

**Important:** The script inserts sample rows each time it is executed. Running it repeatedly against the same existing tables can create duplicate booking records. Use a fresh database or clear the existing sample data before rerunning the full script.

### Step 5: Verify the Database

Open the MySQL monitor and execute:

```sql
USE travel_agency_db;

SHOW TABLES;

SELECT COUNT(*) AS domestic_count
FROM domestic_bookings;

SELECT COUNT(*) AS international_count
FROM international_bookings;
```

For the supplied sample dataset, the expected counts are **4 domestic bookings** and **5 international bookings**.

## Results and Verification

The recorded MySQL terminal output confirms the following results for the supplied dataset:

| Verification | Result |
|---|---:|
| Domestic booking records | 4 |
| International booking records | 5 |
| Total booking records | 9 |
| Unique customers | 4 |
| Customers appearing in both tables | 4 |
| Unique destinations | 6 |

The booking-count query returns 3 bookings for Asha and 2 bookings each for Vikram, Rohan, and Meera.

The SQL script also contains further analysis queries for spending totals, booking-type comparisons, and customer categories.

## Learning Outcomes

Through this case study, I practised:

- Creating databases and tables in MySQL.
- Defining primary keys and using `AUTO_INCREMENT`.
- Inserting and retrieving structured data.
- Understanding the difference between `UNION` and `UNION ALL`.
- Combining related records using `INNER JOIN`.
- Using `COUNT()`, `SUM()`, `GROUP BY`, and `ORDER BY`.
- Writing subqueries and using `NOT EXISTS`.
- Verifying query results through the MySQL terminal.
- Managing project files with Git and GitHub.

## Conclusion

The Travel Agency Booking Management case study demonstrates how SQL can be used to organise and analyse domestic and international travel bookings. By applying set operations, joins, aggregate functions, and subqueries, the project produces combined customer reports, destination lists, booking counts, and spending summaries.

This project strengthened my understanding of relational database concepts and practical SQL query development.

---

**Project:** Travel Agency Booking Management System  
**Case Study:** 155  
**Database:** MySQL  
**Author:** Rashmeet Kaur
