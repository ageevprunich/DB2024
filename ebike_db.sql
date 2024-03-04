CREATE TABLE bikes (
    bike_id SERIAL PRIMARY KEY,
    bike_brand VARCHAR,
    motor_id INTEGER,
    battery_id INTEGER,
    controller_id INTEGER,
    bike_range INTEGER,
    producing_country VARCHAR
);
CREATE TABLE motor(
    motor_id SERIAL PRIMARY KEY,
    motor_power INTEGER,
    motor_volt INTEGER,
    motor_type VARCHAR,
    producing_country VARCHAR
);

CREATE TABLE battery (
    battery_id SERIAL PRIMARY KEY,
    battery_cappacity INTEGER,
    battery_volt INTEGER,
    bms VARCHAR,
    producing_country VARCHAR
);

CREATE TABLE controller (
    controller_id SERIAL PRIMARY KEY,
    controller_name VARCHAR,
    controller_power INTEGER,
    controller_country VARCHAR
);

ALTER TABLE "bikes"
ADD FOREIGN KEY ("motor_id") REFERENCES "motor" ("motor_id");

ALTER TABLE "bikes"
ADD FOREIGN KEY ("battery_id") REFERENCES "battery" ("battery_id");

ALTER TABLE "bikes"
ADD FOREIGN KEY ("controller_id") REFERENCES "controller" ("controller_id");

INSERT INTO 
    controller (controller_name,controller_power,controller_country)
VALUES ('HUAWEI',350,'China'),
    ('Bosch',500,'Germany'),
    ('Instrade',350,'Japan'),
    ('Bosch',1000,'Germany');

INSERT INTO 
    battery (battery_cappacity,battery_volt,bms,producing_country)
VALUES (20,36,'ae1342','China'),
    (15,36,'ky4826','Germany'),
    (20,48,'ae9845','China'),
    (15,48,'qw685','Korea');

INSERT INTO 
    motor (motor_power,motor_volt,motor_type,producing_country)
VALUES (350,36,'reducer','China'),
    (350,48,'reducer','China'),
    (500,36,'straight','Korea'),
    (500,48,'straight','Korea'),
    (500,48,'reducer','Germany'),
    (1000,48,'straight','USA');

INSERT INTO 
    bikes (bike_brand,motor_id,battery_id,controller_id,bike_range,producing_country)
VALUES ('Formula',2,4,1,60,'Ukraine'),
    ('Ardis',5,3,2,100,'Ukraine'),
    ('Cube',1,2,3,50,'Germany'),
    ('Pride',6,3,4,80,'Ukraine'),
    ('Pride',3,2,3,70,'Ukraine'),
    ('Merida',2,3,3,60,'Taiwan'),
    ('Luxe',3,1,1,50,'China'),
    ('Formula',4,4,2,70,'Ukraine');