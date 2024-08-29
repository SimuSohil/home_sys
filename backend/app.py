from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
    host="Simus-MacBook-Air.local",
    user="root",
    password="Simu@1305",
    database="HomeManage"
)

@app.route('/data', methods=['GET'])
def getdata():
    cursor = db.cursor(dictionary=True)
    cursor.execute('select * from family_tasks')
    rows = cursor.fetchall()
    cursor.close()
    return jsonify(rows)

if __name__ == '__main__':
    app.run(debug=True)
