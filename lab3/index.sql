CREATE INDEX idx_bikes_id ON bikes (bike_id);
CREATE INDEX idx_brand_id ON brand (brand_id);

SELECT * FROM bikes b 
JOIN motor m ON b.motor_id = m.motor_id
JOIN battery bat ON b.battery_id = bat.battery_id
JOIN controller c ON b.controller_id = c.controller_id
WHERE b.bike_id = 3