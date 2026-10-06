CREATE DATABASE IF NOT EXISTS VehicleRentalDB;
USE VehicleRentalDB;

-- MODULE 1: USER AUTHENTICATION
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Customer') NOT NULL DEFAULT 'Customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- MODULE 2: CUSTOMER MANAGEMENT
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    address TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- MODULE 3: VEHICLE MANAGEMENT
CREATE TABLE Vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(20) NOT NULL UNIQUE,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    manufacture_year INT NOT NULL,
    rental_rate_per_day DECIMAL(10, 2) NOT NULL,
    status ENUM('Available', 'Rented', 'Under Maintenance', 'Out of Service') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- MODULE 4: BOOKING MANAGEMENT
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    booking_status ENUM('Pending', 'Confirmed', 'Cancelled', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE
);

-- MODULE 5: PAYMENT MANAGEMENT
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Cash') NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Completed',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- MODULE 6: RENTAL MANAGEMENT
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT UNIQUE NOT NULL,
    pickup_datetime DATETIME NOT NULL,
    return_datetime DATETIME,
    odometer_start INT NOT NULL,
    odometer_end INT,
    rental_status ENUM('Active', 'Returned', 'Overdue') DEFAULT 'Active',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- MODULE 7: VEHICLE CONDITION HISTORY & DAMAGE REPORTS
CREATE TABLE Condition_History (
    condition_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    inspection_stage ENUM('Pre-Rental', 'Post-Rental') NOT NULL,
    cleanliness_rating INT CHECK (cleanliness_rating BETWEEN 1 AND 5),
    fuel_level_percent INT CHECK (fuel_level_percent BETWEEN 0 AND 100),
    inspector_notes TEXT,
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE CASCADE
);

CREATE TABLE Damage_Reports (
    damage_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    damage_description TEXT NOT NULL,
    repair_cost_estimate DECIMAL(10, 2) DEFAULT 0.00,
    severity ENUM('Minor', 'Moderate', 'Major', 'Critical') NOT NULL,
    reported_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE
);

-- MODULE 8: MAINTENANCE MANAGEMENT
CREATE TABLE Maintenance_Records (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    service_date DATE NOT NULL,
    service_type ENUM('Routine Servicing', 'Repair', 'Breakdown Fix', 'Inspection') NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    description TEXT,
    next_service_due DATE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE
);

-- MODULE 9: RELIABILITY SCORING
CREATE TABLE Reliability_Scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT UNIQUE NOT NULL,
    maintenance_penalty DECIMAL(5, 2) DEFAULT 0.00,
    damage_penalty DECIMAL(5, 2) DEFAULT 0.00,
    age_penalty DECIMAL(5, 2) DEFAULT 0.00,
    reliability_score DECIMAL(5, 2) DEFAULT 100.00,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE
);