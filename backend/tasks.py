from flask import Flask, jsonify, request
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

@app.route('/add/<user_id>', methods=['POST'])
def add_tasks(user_id):
    data = request.get_json()
    task_name = data['task_name']
    description = data['description']
    assigned_to = data['assigned_to']
    due_date = data['due_date']
    priority = data['priority']
    status = data['status']
    
    if not all([task_name, due_date]):
        return jsonify({"error" : "missing task name or due date"}), 400
    
    cursor = db.cursor()
    query = '''INSERT INTO tasks (user_id, task_name, description, assigned_to, due_date, priority, status) VALUES (%s, %s, %s, %s, %s, %s, %s)'''
    values = (user_id, task_name, description, assigned_to, due_date, priority, status)
    
    try:
        cursor.execute(query, values)
        db.commit()
        cursor.close()
        return jsonify({"message" : "task added successfully"}), 200
    except mysql.connector.Error as err: 
        return jsonify({"error" : str(err)}), 500
    
@app.route('/delete/<user_id>/<task_name>', methods=['DELETE'])
def delete_task(user_id, task_name):
    cursor = db.cursor()
    try:
        # Step 1: Check if the task exists
        select_query = 'SELECT * FROM tasks WHERE user_id = %s AND task_name = %s'
        cursor.execute(select_query, (user_id, task_name))
        task = cursor.fetchone()

        if task is None:
            cursor.close()
            return jsonify({"error": "Task not found"}), 404

        # Step 2: If task exists, delete it
        delete_query = 'DELETE FROM tasks WHERE user_id = %s AND task_name = %s'
        cursor.execute(delete_query, (user_id, task_name))
        db.commit()
        cursor.close()

        return jsonify({"message": "Task deleted successfully"}), 200

    except mysql.connector.Error as err:
        # Handle any potential database error
        cursor.close()
        return jsonify({"error": str(err)}), 500


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8000) #changed the port and host of the flask API to run on all devices