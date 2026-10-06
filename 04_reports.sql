-- 1. Fleet Vehicle Reliability Rankings Report
SELECT 
    v.vehicle_id, 
    v.registration_number, 
    v.make, 
    v.model, 
    COALESCE(r.reliability_score, 100.00) AS reliability_score
FROM Vehicles v
LEFT JOIN Reliability_Scores r ON v.vehicle_id = r.vehicle_id
ORDER BY reliability_score DESC;

-- 2. Total Revenue and Rental Count per Vehicle
SELECT 
    v.vehicle_id, 
    v.make, 
    v.model, 
    COUNT(b.booking_id) AS total_bookings, 
    SUM(p.amount_paid) AS total_revenue
FROM Vehicles v
JOIN Bookings b ON v.vehicle_id = b.vehicle_id
JOIN Payments p ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Completed'
GROUP BY v.vehicle_id, v.make, v.model
ORDER BY total_revenue DESC;

-- 3. Maintenance Expense & Health Summary Report
SELECT 
    v.vehicle_id, 
    v.registration_number, 
    SUM(m.cost) AS total_maintenance_cost,
    COUNT(m.maintenance_id) AS maintenance_events
FROM Vehicles v
JOIN Maintenance_Records m ON v.vehicle_id = m.vehicle_id
GROUP BY v.vehicle_id, v.registration_number
ORDER BY total_maintenance_cost DESC;