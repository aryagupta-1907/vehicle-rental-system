const express = require('express');
const router = express.Router();
const db = require('./db');

// MODULE 1: USER AUTHENTICATION (LOGIN)
router.post('/auth/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const [users] = await db.query(
            'SELECT user_id, username, email, role FROM Users WHERE email = ? AND password_hash = ?',
            [email, password]
        );

        if (users.length === 0) {
            return res.status(401).json({ message: 'Invalid email or password' });
        }

        const user = users[0];
        res.json({
            message: 'Login successful',
            user: {
                id: user.user_id,
                username: user.username,
                email: user.email,
                role: user.role
            }
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// MODULE 3: GET ALL AVAILABLE VEHICLES WITH QUANTITY COUNT
router.get('/vehicles', async (req, res) => {
    try {
        const [vehicles] = await db.query(`
            SELECT 
                v.vehicle_id, 
                v.make, 
                v.model, 
                v.manufacture_year AS year, 
                v.registration_number AS license_plate, 
                v.rental_rate_per_day AS daily_rate, 
                v.status,
                (
                    SELECT COUNT(*) 
                    FROM Vehicles v2 
                    WHERE v2.make = v.make 
                      AND v2.model = v.model 
                      AND v2.status = 'Available'
                ) AS available_quantity
            FROM Vehicles v
            WHERE v.status = 'Available'
        `);
        res.json(vehicles);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// MODULE 4: CREATE A BOOKING
router.post('/bookings', async (req, res) => {
    const { customer_id, vehicle_id, start_date, end_date, total_cost } = req.body;
    try {
        const [result] = await db.query(
            'INSERT INTO Bookings (customer_id, vehicle_id, start_date, end_date, total_cost, booking_status) VALUES (?, ?, ?, ?, ?, "Confirmed")',
            [customer_id, vehicle_id, start_date, end_date, total_cost]
        );
        res.json({ message: 'Booking confirmed', booking_id: result.insertId });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// MODULE 7: GET DAMAGE & INSPECTION REPORTS (SAFE FETCH)
router.get('/damage-reports', async (req, res) => {
    try {
        const [reports] = await db.query(`
            SELECT 
                d.*, 
                v.make, 
                v.model 
            FROM Damage_Reports d
            LEFT JOIN Vehicles v ON d.vehicle_id = v.vehicle_id
        `);
        res.json(reports);
    } catch (err) {
        console.error("SQL Error in /damage-reports:", err.message);
        res.status(500).json({ error: err.message });
    }
});

// MODULE 9: RECALCULATE & GET RELIABILITY SCORE
router.get('/vehicles/:id/reliability', async (req, res) => {
    const vehicleId = req.params.id;
    try {
        await db.query('CALL Recalculate_Vehicle_Reliability(?)', [vehicleId]);
        const [scores] = await db.query('SELECT * FROM Reliability_Scores WHERE vehicle_id = ?', [vehicleId]);
        res.json(scores[0] || {});
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;