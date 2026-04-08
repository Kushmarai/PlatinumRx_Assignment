-- 03_Clinic_Schema_Setup.sql

CREATE DATABASE IF NOT EXISTS platinumrx_clinic;
USE platinumrx_clinic;


-- CREATE TABLES


CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(200),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


-- INSERT SAMPLE DATA


INSERT INTO clinics VALUES
('cnc-001', 'Apollo Clinic', 'Hyderabad', 'Telangana', 'India'),
('cnc-002', 'Care Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-003', 'Health Plus', 'Hyderabad', 'Telangana', 'India'),
('cnc-004', 'MedLife', 'Pune', 'Maharashtra', 'India');

INSERT INTO customer VALUES
('cust-001', 'John Doe', '9700000001'),
('cust-002', 'Jane Smith', '9700000002'),
('cust-003', 'Ravi Kumar', '9700000003'),
('cust-004', 'Priya Rao', '9700000004'),
('cust-005', 'Ali Khan', '9700000005');

INSERT INTO clinic_sales VALUES
('ord-001', 'cust-001', 'cnc-001', 24999, '2021-01-10 10:00:00', 'online'),
('ord-002', 'cust-002', 'cnc-001', 15000, '2021-01-15 11:00:00', 'offline'),
('ord-003', 'cust-003', 'cnc-002', 30000, '2021-02-05 09:00:00', 'online'),
('ord-004', 'cust-001', 'cnc-002', 12000, '2021-02-20 14:00:00', 'referral'),
('ord-005', 'cust-004', 'cnc-003', 45000, '2021-03-10 10:00:00', 'online'),
('ord-006', 'cust-002', 'cnc-003', 8000,  '2021-03-18 16:00:00', 'offline'),
('ord-007', 'cust-005', 'cnc-004', 20000, '2021-04-05 11:00:00', 'referral'),
('ord-008', 'cust-003', 'cnc-001', 35000, '2021-04-22 13:00:00', 'online'),
('ord-009', 'cust-004', 'cnc-002', 18000, '2021-05-08 10:00:00', 'offline'),
('ord-010', 'cust-001', 'cnc-004', 22000, '2021-05-25 15:00:00', 'online'),
('ord-011', 'cust-002', 'cnc-003', 50000, '2021-06-12 09:00:00', 'online'),
('ord-012', 'cust-005', 'cnc-001', 9000,  '2021-06-30 17:00:00', 'referral');

INSERT INTO expenses VALUES
('exp-001', 'cnc-001', 'first-aid supplies',   557,  '2021-01-12 07:00:00'),
('exp-002', 'cnc-001', 'staff salary',          5000, '2021-01-31 08:00:00'),
('exp-003', 'cnc-002', 'equipment maintenance', 3000, '2021-02-10 09:00:00'),
('exp-004', 'cnc-002', 'medicines',             2000, '2021-02-28 10:00:00'),
('exp-005', 'cnc-003', 'rent',                  8000, '2021-03-01 08:00:00'),
('exp-006', 'cnc-003', 'utilities',             1500, '2021-03-15 09:00:00'),
('exp-007', 'cnc-004', 'staff salary',          4000, '2021-04-30 08:00:00'),
('exp-008', 'cnc-001', 'medicines',             2500, '2021-04-10 10:00:00'),
('exp-009', 'cnc-002', 'rent',                  6000, '2021-05-01 08:00:00'),
('exp-010', 'cnc-004', 'utilities',             1000, '2021-05-20 09:00:00'),
('exp-011', 'cnc-003', 'equipment',             7000, '2021-06-05 10:00:00'),
('exp-012', 'cnc-001', 'miscellaneous',         800,  '2021-06-25 11:00:00');

SELECT * FROM clinics;
SELECT * FROM customer;
SELECT * FROM clinic_sales;
SELECT * FROM expenses;