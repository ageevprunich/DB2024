BEGIN; 
-- Додавання нового велосипеда
INSERT INTO bikes (motor_id, battery_id, controller_id, bike_range, price, brand_id)
VALUES (1, 2, 3, 60, 500, 11);
ROLLBACK;
COMMIT;


BEGIN;
--Оновлення емності батареї  Huawei
UPDATE battery
SET battery_cappacity = battery_cappacity + 1
WHERE brand_id = (SELECT brand_id FROM brand WHERE brand_name = 'HUAWEI');
COMMIT;