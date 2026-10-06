# Vehicle Rental & Registration System

**Course:** Database Management Systems (DBMS)  
**Submitted To:** Dr. Sudhakar K  
**Team Members:** 
* Arya Gupta (25BDS0279)
* Aarya Pande (25BBS0084)

---

## 📌 Project Overview
The **Vehicle Rental & Registration System** is a relational database project designed to streamline vehicle rentals, user bookings, payment transactions, and fleet maintenance. Unlike conventional rental platforms, this project integrates **Vehicle Condition Tracking** and an automated **Reliability Scoring Engine** that dynamically computes vehicle condition scores based on maintenance events, damage history, and vehicle age.

---

## 🛠️ System Architecture & Database Modules
The database supports 10 core modules:
1. **User Authentication:** Login credentials and role-based access (Admin/Customer).
2. **Customer Management:** Profiles, contact details, and driving license records.
3. **Vehicle Management:** Fleet inventory, rental rates, and real-time availability status.
4. **Booking Management:** Reservations, rental durations, and total cost estimates.
5. **Payment Management:** Transaction processing and payment audits.
6. **Rental Management:** Active rental tracking, pickup/return datetimes, and odometer readings.
7. **Vehicle Condition & Damage Reports:** Pre/post-rental inspection reports and damage logs.
8. **Maintenance Management:** Servicing history, repair logs, maintenance costs, and schedules.
9. **Reliability Scoring Engine:** Stored procedure logic computing real-time reliability scores.
10. **Reports & Analytics:** Fleet reliability rankings, total revenue, and maintenance overhead summaries.

---

## 📁 Repository Structure
```text
vehicle-rental-system/
│
├── database/
│   ├── 01_schema.sql             # Table creation DDL scripts (All 10 modules)
│   ├── 02_procedures.sql         # Reliability scoring stored procedure
│   ├── 03_seed_data.sql          # Test dataset (Users, Vehicles, Bookings, Repairs)
│   └── 04_reports.sql            # Analytical queries & fleet summary reports
│
├── docs/                         # Project diagrams & report PDFs
│
├── src/                          # Application source files (Optional backend/UI)
│
└── README.md                     # Project documentation & setup instructions