CREATE INDEX idx_bikes_price ON bikes (bike_price);
CREATE INDEX idx_motor ON motor (motor_power);

SELECT * FROM bikes b 
JOIN motor m ON b.motor_id = m.motor_id
JOIN battery bat ON b.battery_id = bat.battery_id
JOIN controller c ON b.controller_id = c.controller_id
WHERE b.bike_id = 3