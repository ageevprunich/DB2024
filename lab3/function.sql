--Function

--Розрахунок вартості доставки 
CREATE OR REPLACE FUNCTION shipping_cost(bike_id INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    bike_price INTEGER;
    shipping_cost INTEGER;
BEGIN
    -- Отримати ціну велосипеда за його іid
    SELECT price INTO bike_price FROM bikes b WHERE b.bike_id = shipping_cost.bike_id;

    -- Розрахунок вартості доставки: price + 10 + (price * 0.1)
    shipping_cost := bike_price + 10 + ROUND(bike_price * 0.1::NUMERIC);
    
    RETURN shipping_cost;
END;
$$;

--перевірка
SELECT shipping_cost(1);

----Кількість велосипедів за брендом
CREATE OR REPLACE FUNCTION bikes_by_brand(brand_name VARCHAR)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    bike_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO bike_count
    FROM bikes b
    INNER JOIN brand br ON b.brand_id = br.brand_id
    WHERE br.brand_name = bikes_by_brand.brand_name;

    RETURN bike_count;
END;
$$;

--Перевірка
SELECT bikes_by_brand('Merida');