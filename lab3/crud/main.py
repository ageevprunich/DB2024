from flask import Flask, request, jsonify, render_template
import psycopg2

app = Flask(__name__)

conn = psycopg2.connect(
    dbname="ebike_db",
    user="postgres",
    password="1234",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

# GET /bikes
@app.route('/bikes', methods=['GET'])
def get_bikes():
    cur.execute("SELECT * FROM bikes")
    bikes = cur.fetchall()
    return jsonify(bikes)

# POST /bikes
@app.route('/bikes', methods=['POST'])
def add_bike():
    data = request.json
    cur.execute("INSERT INTO bikes (motor_id, battery_id, controller_id, bike_range, price, brand_id) VALUES (%s, %s, %s, %s, %s, %s)", (data['motor_id'], data['battery_id'], data['controller_id'], data['bike_range'], data['price'], data['brand_id']))
    conn.commit()
    return jsonify({'message': 'Bike added successfully'})

# PUT /bikes/<bike_id>
@app.route('/bikes/<int:bike_id>', methods=['PUT'])
def update_bike(bike_id):
    try:
        # Отримання нових даних про велосипед з запиту
        data = request.json
        motor_id = data.get('motor_id')
        battery_id = data.get('battery_id')
        controller_id = data.get('controller_id')
        bike_range = data.get('bike_range')
        price = data.get('price')
        brand_id = data.get('brand_id')

        # Виконання оновлення в базі даних
        cur.execute("UPDATE bikes SET motor_id = %s, battery_id = %s, controller_id = %s, bike_range = %s, price = %s, brand_id = %s WHERE bike_id = %s", 
                    (motor_id, battery_id, controller_id, bike_range, price, brand_id, bike_id))
        
        conn.commit()

        return jsonify({'message': 'Bike updated successfully'})
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500

# DELETE /bikes/<bike_id> 
@app.route('/bikes/<int:bike_id>', methods=['DELETE'])
def delete_bike(bike_id):
    try:
        # Виконання видалення в базі даних
        cur.execute("DELETE FROM bikes WHERE bike_id = %s", (bike_id,))
        
        conn.commit()

        return jsonify({'message': 'Bike deleted successfully'})
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500

# Розрахунок вартості доставки по bike_id
@app.route('/shipping_cost/<int:bike_id>', methods=['GET'])
def calculate_shipping_cost(bike_id):
    try:
        # Отримати ціну велосипеда за його id
        cur.execute("SELECT price FROM bikes WHERE bike_id = %s", (bike_id,))
        bike_price = cur.fetchone()[0]

        # Розрахунок вартості доставки: price + 10 + (price * 0.1)
        shipping_cost = bike_price + 10 + round(bike_price * 0.1)

        return jsonify({'shipping_cost': shipping_cost})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Отримання кількості велосипедів за брендом
@app.route('/bikes/count/<brand_name>', methods=['GET'])
def get_bikes_count_by_brand(brand_name):
    try:
        # Виконання запиту до бази даних
        cur.execute("SELECT COUNT(*) FROM bikes b INNER JOIN brand br ON b.brand_id = br.brand_id WHERE br.brand_name = %s", (brand_name,))
        bike_count = cur.fetchone()[0]

        return jsonify({'bike_count': bike_count})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Запуск сервера
if __name__ == '__main__':
    app.run(debug=True)