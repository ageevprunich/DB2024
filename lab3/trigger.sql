----Тригер на bike.range > 50 
CREATE OR REPLACE FUNCTION check_bike_range()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.bike_range < 50 THEN
        RAISE EXCEPTION 'Bike range must be at least 50 kilometers.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_bike_range_trigger
BEFORE INSERT ON bikes
FOR EACH ROW
EXECUTE FUNCTION check_bike_range();

---виклик тригера

CALL add_bike (6,3,4,42,550,14);


---Тригер на видалення батареї при видаленні бренда
CREATE OR REPLACE FUNCTION delete_related_batteries()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM battery
    WHERE brand_id = OLD.brand_id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_related_batteries_trigger
AFTER DELETE ON brand
FOR EACH ROW
EXECUTE FUNCTION delete_related_batteries();

--Перевірка
CALL add_brand ('Canondale','USA')
CALL add_battery(21,48,'a234',3);
DELETE FROM brand WHERE brand_id = 3;

---Тригер на видалення мотора при видаленні бренда
CREATE OR REPLACE FUNCTION delete_related_motor()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM motor
    WHERE brand_id = OLD.brand_id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_related_motor_trigger
AFTER DELETE ON brand
FOR EACH ROW
EXECUTE FUNCTION delete_related_motor();

--Перевірка
CALL add_brand ('Canondale','USA');
CALL add_motor(750,48,'reducer',19);
DELETE FROM brand WHERE brand_id = 19;
