from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
    host="Simus-MacBook-Air.local",
    user="root",
    password="Simu@1305",
    database="HomeManage"
)

@app.route('/tasks/<user_id>', methods=['GET'])
def get_tasks(user_id):
    cursor = db.cursor(dictionary=True)
    query = 'SELECT * FROM tasks WHERE user_id = %s'
    cursor.execute(query, (user_id,))
    tasks = cursor.fetchall()
    cursor.close()
    return jsonify(tasks)

if __name__ == '__main__':
    app.run(debug=True, port=5001)
