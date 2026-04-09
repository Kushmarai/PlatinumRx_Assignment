# PlatinumRx Data Analyst Assignment

## About
This repository contains my solutions for the PlatinumRx Data Analyst assignment.
It covers three areas — SQL, Spreadsheets, and Python.

## Folder Structure
```
Data_Analyst_Assignment/
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
└── README.md
```
## Tools Used
- SQL: MySQL 8.0 (MySQL Workbench)
- Spreadsheet: Microsoft Excel
- Python: Python 3.x (VS Code)

## Phase 1 — SQL

### Part A: Hotel Management System
- Used 4 tables: users, bookings, booking_commercials, items
- Q1: Used correlated subquery with MAX(booking_date) to get last booked room per user
- Q2: Joined 3 tables and used SUM(quantity x rate) to get total billing for November 2021
- Q3: Used HAVING clause to filter bills above 1000 in October 2021
- Q4: Used RANK() window function with PARTITION BY month to find most and least ordered items
- Q5: Used RANK() window function to find customer with second highest bill per month

### Part B: Clinic Management System
- Used 4 tables: clinics, customer, clinic_sales, expenses
- Q1: Used GROUP BY sales_channel with SUM(amount) to get revenue per channel
- Q2: Joined clinic_sales and customer, ordered by total spend DESC, used LIMIT 10
- Q3: Used two CTEs for revenue and expenses separately, joined them to calculate profit and status
- Q4: Used RANK() with PARTITION BY city and month to find most profitable clinic per city
- Q5: Used RANK() ASC with PARTITION BY state and month, picked rank 2 for second least profitable

## Phase 2 — Spreadsheets
- Created two sheets: ticket and feedbacks
- Q1: Used INDEX-MATCH formula to pull ticket created_at into feedbacks sheet using cms_id as key
- Q2a: Added Same_Day helper column using INT() to compare date parts of created_at and closed_at
- Q2b: Added Same_Hour helper column using HOUR() to compare hour parts
- Used COUNTIFS to get outlet-wise count for both same day and same hour

## Phase 3 — Python
- Script 1: Converts total minutes into human readable format using integer division and modulo
- Script 2: Removes duplicate characters from a string using a simple for loop

## Assumptions
- Hotel queries: Used bill_date for October/November filters in booking_commercials
- Added one extra row to October 2021 data to demonstrate the HAVING > 1000 filter in Q3
- Clinic queries: Year 2021 used as the given year parameter for all queries
- Spreadsheet: cms_id used as the common key between ticket and feedbacks sheets