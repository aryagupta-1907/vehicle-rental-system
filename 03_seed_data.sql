USE VehicleRentalDB;

-- ========================================================
-- 1. USER AUTHENTICATION MODULE DATA
-- ========================================================
INSERT INTO Users (user_id, username, email, password_hash, role) VALUES
(1, 'admin_mira', 'admin.mira@vehiclerental.com', '$2b$12$e89Fk2XmK1a9Q...hashAdmin1', 'Admin'),
(2, 'admin_rahul', 'admin.rahul@vehiclerental.com', '$2b$12$z30Pl8YqR2b0W...hashAdmin2', 'Admin'),
(3, 'aarya_p', 'aarya.pande@gmail.com', '$2b$12$k81Xm2LpQ9v8T...hashUser1', 'Customer'),
(4, 'arya_g', 'arya.gupta@yahoo.com', '$2b$12$m72Yn3MrR0w9U...hashUser2', 'Customer'),
(5, 'vikram_s', 'vikram.singh@outlook.com', '$2b$12$p45Zo4NsS1x0V...hashUser3', 'Customer'),
(6, 'priya_m', 'priya.sharma@hotmail.com', '$2b$12$q56Ap5OtT2y1W...hashUser4', 'Customer'),
(7, 'rohan_v', 'rohan.verma@gmail.com', '$2b$12$r67Bq6PuU3z2X...hashUser5', 'Customer');

-- ========================================================
-- 2. CUSTOMER MANAGEMENT MODULE DATA
-- ========================================================
INSERT INTO Customers (customer_id, user_id, full_name, phone, license_number, address) VALUES
(1, 3, 'Aarya Pande', '+919876543210', 'DL-1420110012345', '124 Park Street, Sector 62, Noida'),
(2, 4, 'Arya Gupta', '+919812345678', 'DL-0420150098765', '45 Green Glen Layout, Bellandur, Bengaluru'),
(3, 5, 'Vikram Singh', '+919988776655', 'DL-0920180054321', '88 MG Road, Civil Lines, Jaipur'),
(4, 6, 'Priya Sharma', '+919711223344', 'DL-0720190067890', '12 Lake View Apartments, Powai, Mumbai'),
(5, 7, 'Rohan Verma', '+919654321876', 'DL-0320200011223', '302 Anna Salai, T. Nagar, Chennai');

-- ========================================================
-- 3. VEHICLE MANAGEMENT MODULE DATA
-- ========================================================
INSERT INTO Vehicles (vehicle_id, registration_number, make, model, manufacture_year, rental_rate_per_day, status) VALUES
(1, 'KA-01-MJ-1001', 'Toyota', 'Camry', 2022, 65.00, 'Available'),
(2, 'KA-03-NC-2020', 'Honda', 'Civic', 2021, 50.00, 'Rented'),
(3, 'MH-02-DN-3030', 'Hyundai', 'Creta', 2023, 55.00, 'Available'),
(4, 'DL-01-AB-4040', 'Mahindra', 'Thar', 2020, 80.00, 'Under Maintenance'),
(5, 'TN-09-XY-5050', 'Ford', 'EcoSport', 2019, 45.00, 'Available'),
(6, 'KA-05-MM-6060', 'Tata', 'Nexon EV', 2023, 70.00, 'Available');

-- ========================================================
-- 4. BOOKING MANAGEMENT MODULE DATA
-- ========================================================
INSERT INTO Bookings (booking_id, customer_id, vehicle_id, booking_date, start_date, end_date, total_cost, booking_status) VALUES
(1, 1, 1, '2026-08-01 09:00:00', '2026-08-03', '2026-08-06', 195.00, 'Completed'),
(2, 2, 2, '2026-08-10 14:30:00', '2026-08-12', '2026-08-15', 150.00, 'Completed'),
(3, 3, 4, '2026-08-20 11:15:00', '2026-08-22', '2026-08-25', 240.00, 'Completed'),
(4, 4, 3, '2026-09-01 10:00:00', '2026-09-05', '2026-09-08', 165.00, 'Completed'),
(5, 5, 2, '2026-09-18 08:45:00', '2026-09-19', '2026-09-23', 200.00, 'Confirmed'),
(6, 1, 6, '2026-09-20 12:00:00', '2026-09-25', '2026-09-28', 210.00, 'Confirmed');

-- ========================================================
-- 5. PAYMENT MANAGEMENT MODULE DATA
-- ========================================================
INSERT INTO Payments (payment_id, booking_id, payment_date, amount_paid, payment_method, payment_status) VALUES
(1, 1, '2026-08-01 09:05:00', 195.00, 'Credit Card', 'Completed'),
(2, 2, '2026-08-10 14:35:00', 150.00, 'UPI', 'Completed'),
(3, 3, '2026-08-20 11:20:00', 240.00, 'Net Banking', 'Completed'),
(4, 4, '2026-09-01 10:05:00', 165.00, 'Debit Card', 'Completed'),
(5, 5, '2026-09-18 08:50:00', 200.00, 'UPI', 'Completed'),
(6, 6, '2026-09-20 12:02:00', 210.00, 'Credit Card', 'Completed');

-- ========================================================
-- 6. RENTAL MANAGEMENT MODULE DATA
-- ========================================================
INSERT INTO Rentals (rental_id, booking_id, pickup_datetime, return_datetime, odometer_start, odometer_end, rental_status) VALUES
(1, 1, '2026-08-03 10:00:00', '2026-08-06 11:30:00', 12000, 12450, 'Returned'),
(2, 2, '2026-08-12 09:30:00', '2026-08-15 10:00:00', 28500, 28920, 'Returned'),
(3, 3, '2026-08-22 08:00:00', '2026-08-25 18:00:00', 45000, 45800, 'Returned'),
(4, 4, '2026-09-05 10:15:00', '2026-09-08 09:45:00', 15100, 15480, 'Returned'),
(5, 5, '2026-09-19 09:00:00', NULL, 28920, NULL, 'Active');

-- ========================================================
-- 7. VEHICLE CONDITION HISTORY & DAMAGE REPORTS DATA
-- ========================================================
INSERT INTO Condition_History (condition_id, rental_id, inspection_date, inspection_stage, cleanliness_rating, fuel_level_percent, inspector_notes) VALUES
(1, 1, '2026-08-03 09:45:00', 'Pre-Rental', 5, 100, 'Vehicle pristine, full tank.'),
(2, 1, '2026-08-06 11:45:00', 'Post-Rental', 5, 95, 'Vehicle returned in excellent condition.'),
(3, 2, '2026-08-12 09:15:00', 'Pre-Rental', 4, 100, 'Minor scuff on left mirror noted prior to pickup.'),
(4, 2, '2026-08-15 10:15:00', 'Post-Rental', 4, 80, 'Minor scratch on rear bumper upon return.'),
(5, 3, '2026-08-22 07:45:00', 'Pre-Rental', 4, 100, 'All systems checked. Off-road tires inspected.'),
(6, 3, '2026-08-25 18:30:00', 'Post-Rental', 2, 40, 'Vehicle heavy mud exposure, dent on right passenger door.');

INSERT INTO Damage_Reports (damage_id, rental_id, vehicle_id, damage_description, repair_cost_estimate, severity, reported_date) VALUES
(1, 2, 2, 'Scratch on rear bumper during city parking', 120.00, 'Minor', '2026-08-15 10:30:00'),
(2, 3, 4, 'Dent on right side passenger door and misaligned step board', 450.00, 'Moderate', '2026-08-25 18:45:00');

-- ========================================================
-- 8. MAINTENANCE MANAGEMENT MODULE DATA
-- ========================================================
INSERT INTO Maintenance_Records (maintenance_id, vehicle_id, service_date, service_type, cost, description, next_service_due) VALUES
(1, 1, '2026-07-15', 'Routine Servicing', 100.00, '5,000 km regular service, oil filter change.', '2027-01-15'),
(2, 2, '2026-06-10', 'Routine Servicing', 120.00, 'Brake pad replacement and wheel balancing.', '2026-12-10'),
(3, 4, '2026-08-27', 'Repair', 500.00, 'Door dent removal, body repaint, and alignment fix.', '2027-02-27'),
(4, 5, '2026-05-20', 'Breakdown Fix', 350.00, 'Alternator replacement following battery discharge incident.', '2026-11-20');

-- ========================================================
-- 9. RELIABILITY SCORING MODULE INITIAL DATA
-- ========================================================
-- Populating score records using the Stored Procedure for each vehicle
CALL Recalculate_Vehicle_Reliability(1);
CALL Recalculate_Vehicle_Reliability(2);
CALL Recalculate_Vehicle_Reliability(3);
CALL Recalculate_Vehicle_Reliability(4);
CALL Recalculate_Vehicle_Reliability(5);
CALL Recalculate_Vehicle_Reliability(6);