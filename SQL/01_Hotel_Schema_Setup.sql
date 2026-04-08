-- 01_Hotel_Schema_Setup.sql

CREATE DATABASE platinumrx_hotel;
USE platinumrx_hotel;


-- CREATE TABLES


CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
	booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
	item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
	id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);


-- INSERT SAMPLE DATA


INSERT INTO users VALUES 
('user-001', 'John Doe', '9700000001','john.doe@example.com','04, Street A, ABC city'),
('user-002', 'Taylor Swift', '9700000002','taylor.swift@example.com','16, Street S, DEF city'),
('user-003', 'Selena Gomez', '9700000003','selena.gomez@example.com','32, Street K, XYZ city');

INSERT INTO items VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18.00),
('itm-a07vh-aer8', 'Mix Veg', 89.00),
('itm-w978-23u4', 'Paneer Butter Masala', 150.00),
('itm-b123-x1y2', 'Cold Coffee', 120.00),
('itm-c456-z3w4', 'Mushroom Biryani', 200.00);

INSERT INTO bookings VALUES
('bk-001', '2021-09-23 07:36:48', 'rm-101', 'user-001'),
('bk-002', '2021-10-05 10:20:00', 'rm-102', 'user-002'),
('bk-003', '2021-10-18 14:00:00', 'rm-103', 'user-001'),
('bk-004', '2021-11-02 09:15:00', 'rm-104', 'user-003'),
('bk-005', '2021-11-20 11:30:00', 'rm-105', 'user-002'),
('bk-006', '2021-11-25 16:45:00', 'rm-101', 'user-001');

INSERT INTO booking_commercials VALUES
('bc-001', 'bk-001', 'bl-001', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('bc-002', 'bk-001', 'bl-001', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('bc-003', 'bk-002', 'bl-002', '2021-10-05 13:00:00', 'itm-w978-23u4', 0.5),
('bc-004', 'bk-002', 'bl-002', '2021-10-05 13:00:00', 'itm-b123-x1y2', 1),
('bc-005', 'bk-003', 'bl-003', '2021-10-18 15:00:00', 'itm-c456-z3w4', 3),
('bc-006', 'bk-003', 'bl-003', '2021-10-18 15:00:00', 'itm-a9e8-q8fu', 2),
('bc-007', 'bk-004', 'bl-004', '2021-11-02 10:00:00', 'itm-a07vh-aer8', 4),
('bc-008', 'bk-004', 'bl-004', '2021-11-02 10:00:00', 'itm-w978-23u4', 1),
('bc-009', 'bk-005', 'bl-005', '2021-11-20 12:00:00', 'itm-b123-x1y2', 2),
('bc-010', 'bk-005', 'bl-005', '2021-11-20 12:00:00', 'itm-c456-z3w4', 1),
('bc-011', 'bk-006', 'bl-006', '2021-11-25 17:00:00', 'itm-a9e8-q8fu', 5),
('bc-012', 'bk-006', 'bl-006', '2021-11-25 17:00:00', 'itm-w978-23u4', 2),
('bc-013', 'bk-003', 'bl-003', '2021-10-18 15:00:00', 'itm-c456-z3w4', 5);

SELECT * FROM users;
SELECT * FROM items;
SELECT * FROM bookings;
SELECT * FROM booking_commercials;
