------Procedure

--Додавання нового бренду
CREATE OR REPLACE PROCEDURE add_brand(
    IN brand_name VARCHAR,
    IN brand_country VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO brand (brand_name, brand_country) VALUES (brand_name, brand_country);
END;
$$;

----Перевірка
   CALL add_brand('Canondale','USA');

-----Видалення
    DELETE FROM brand WHERE brand_id = 18

--Додавання мотру
CREATE OR REPLACE PROCEDURE add_motor(
    IN motor_power INTEGER,
    IN motor_volt INTEGER,
    IN motor_type VARCHAR,
    IN brand_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF motor_power  NOT BETWEEN 200 AND 1200
    THEN
    RAISE EXCEPTION 'Check power';
    END IF;
    
    INSERT INTO motor (motor_power, motor_volt, motor_type, brand_id)
    VALUES (motor_power, motor_volt, motor_type, brand_id);
    
END;
$$;

--Перевірка
CALL add_motor(150,48,'reducer',2);


--Додавання батареї
CREATE OR REPLACE PROCEDURE add_battery(
    IN battery_capacity INTEGER,
    IN battery_volt INTEGER,
    IN bms VARCHAR,
    IN brand_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO battery (battery_cappacity, battery_volt, bms, brand_id)
    VALUES (battery_capacity, battery_volt, bms, brand_id);
END;
$$;

--Перевірка
CALL add_battery(21,48,'a234',3);
--Додавання нового велосипеду
CREATE OR REPLACE PROCEDURE add_bike(
    IN motor_id INT,
    IN battery_id INT,
    IN controller_id INT,
    IN bike_range INT,
    IN price INT,
    IN brand_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO bikes (motor_id, battery_id, controller_id, bike_range, price, brand_id) VALUES (motor_id, battery_id, controller_id, bike_range, price, brand_id);
END;
$$;

--Перевірка
CALL add_bike (6,3,4,40,600,15);

---brand id
----('HUAWEI','China'),   --1 controller/battary
----('Bosch','Germany'),  --2 motor/controller
----('Instrade','Japan'), --3 controller/battary
----('Luxus','USA'),      --4 motor/controller
----('Shimano','Japan'),  --5 controller/battary
----('MAXus','China'),    --6 motor/controller
----('Straight','USA'),   --7 motor/controller
----('Sram','Japan'),     --8 motor/controller
----('Magic','USA'),      --9 motor/controller
----('Sulfur','Korea'),   --10 controller/battary
----('Ardis','Ukraine'),  --11 bike
----('Pride','Ukraine'),  --12 bike
----('Formula','Ukraine'), --13 bike
----('Cube','Germany'),   --14 bike
----('Merida','Taiwan')   --15 bike

--motor_id
--(350,36,'reducer',6),   1
--(350,48,'reducer',6),   2
--(500,36,'straight',8),  3
--(500,48,'straight',8),  4
--(500,48,'reducer',2),   5
--(1000,48,'straight',9); 6

--battary_id
--(20,36,'ae1342',1), 1 
--(15,36,'ky4826',2), 2
--(20,48,'ae9845',6), 3
--(15,48,'qw685',10); 4

--controller_id
--(350,1), 1
--(500,2), 2
--(350,3), 3
--(1000,2) 4