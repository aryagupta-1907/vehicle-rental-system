DELIMITER //

CREATE PROCEDURE Recalculate_Vehicle_Reliability(IN p_vehicle_id INT)
BEGIN
    DECLARE v_age_years INT DEFAULT 0;
    DECLARE v_damage_count INT DEFAULT 0;
    DECLARE v_maintenance_count INT DEFAULT 0;
    
    DECLARE penalty_age DECIMAL(5,2) DEFAULT 0.00;
    DECLARE penalty_damage DECIMAL(5,2) DEFAULT 0.00;
    DECLARE penalty_maint DECIMAL(5,2) DEFAULT 0.00;
    DECLARE final_score DECIMAL(5,2) DEFAULT 100.00;

    -- Calculate Age Penalty (2 points deduction per year of age)
    SELECT (YEAR(CURRENT_DATE()) - manufacture_year) INTO v_age_years 
    FROM Vehicles WHERE vehicle_id = p_vehicle_id;
    SET penalty_age = LEAST(v_age_years * 2.0, 20.0);

    -- Calculate Damage Penalty (5 points deduction per recorded damage report)
    SELECT COUNT(*) INTO v_damage_count 
    FROM Damage_Reports WHERE vehicle_id = p_vehicle_id;
    SET penalty_damage = LEAST(v_damage_count * 5.0, 30.0);

    -- Calculate Maintenance Penalty (3 points deduction per non-routine repair)
    SELECT COUNT(*) INTO v_maintenance_count 
    FROM Maintenance_Records 
    WHERE vehicle_id = p_vehicle_id AND service_type IN ('Repair', 'Breakdown Fix');
    SET penalty_maint = LEAST(v_maintenance_count * 3.0, 25.0);

    -- Final Score Calculation
    SET final_score = GREATEST(100.00 - (penalty_age + penalty_damage + penalty_maint), 0.00);

    -- Upsert Into Reliability_Scores Table
    INSERT INTO Reliability_Scores (vehicle_id, maintenance_penalty, damage_penalty, age_penalty, reliability_score)
    VALUES (p_vehicle_id, penalty_maint, penalty_damage, penalty_age, final_score)
    ON DUPLICATE KEY UPDATE 
        maintenance_penalty = VALUES(maintenance_penalty),
        damage_penalty = VALUES(damage_penalty),
        age_penalty = VALUES(age_penalty),
        reliability_score = VALUES(reliability_score);
END //

DELIMITER ;