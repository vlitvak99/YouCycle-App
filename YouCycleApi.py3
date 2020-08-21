from flask import Flask, jsonify
from flask_restful import Api, Resource, reqparse
import sqlite3
import pandas as pd

def run_sql_query(query):
	sql_connect = sqlite3.connect('database.db')
	cursor = sql_connect.cursor()
	results = cursor.execute(query).fetchall()
	sql_connect.commit()
	sql_connect.close()
	return results

def run_sql_update(statement):
	sql_connect = sqlite3.connect('database.db')
	cursor = sql_connect.cursor()
	cursor.execute(statement)
	sql_connect.commit()
	sql_connect.close()
	return cursor

class User(Resource):
	def get(self):
		parser = reqparse.RequestParser()
		parser.add_argument("Username")
		params = parser.parse_args()
		result = run_sql_query("SELECT Username, FirstName, LastName, Email, ZipCode FROM Users WHERE Username = \'" + params["Username"] + "\' ;")
		for row in result:
			return jsonify(username=row[0], first_name=row[1], last_name=row[2], email=row[3], zip_code=row[4])

	def post(self):
		args_list = ("Username", "Password", "FirstName", "LastName", "Email", "ZipCode")
		parser = reqparse.RequestParser()
		for arg in args_list:
			parser.add_argument(arg)
		params = parser.parse_args()
		args_str= ', '.join(list(args_list))
		params_used = [str(params[x]) for x in args_list]
		statement = "INSERT OR IGNORE INTO Users ("+args_str+") VALUES (\'%s\', \'%s\', \'%s\', \'%s\', \'%s\', %s);"  % tuple(params_used)
		update = run_sql_update(statement)
		if(update.rowcount == 0): return jsonify(success=False)
		return jsonify(success=True)

	def delete(self):
		parser = reqparse.RequestParser()
		parser.add_argument("Username")
		parser.add_argument("Password")
		params = parser.parse_args()
		update = run_sql_update("DELETE FROM Users WHERE Username = \'" + params["Username"] + "\' AND Password = \'" + params["Password"] + "\';")
		if(update.rowcount == 0): return jsonify(success=False)
		return jsonify(success=True)

class Login(Resource):
	def get(self):
		parser = reqparse.RequestParser()
		parser.add_argument("Username")
		parser.add_argument("Password")
		params = parser.parse_args()
		result = run_sql_query("SELECT COUNT(*) FROM Users WHERE Username = \'" + params["Username"] + "\' AND Password = \'" + params["Password"] + "\';")
		for count in result:
			if(count[0] == 0): return jsonify(login=False)
			return jsonify(login=True)

class UserInstructions(Resource):
	def get(self):
		parser = reqparse.RequestParser()
		parser.add_argument("Username")
		params = parser.parse_args()
		result = run_sql_query("SELECT Users.ZipCode, Source, Instructions FROM Users LEFT JOIN RecyclingInstructions ON Users.ZipCode = RecyclingInstructions.ZipCode WHERE Username = \'" + params["Username"] + "\';")
		for info in result:
			return jsonify(zip_code=info[0], source=info[1], instructions=info[2])

class Recycle(Resource):
	def get(self):
		parser = reqparse.RequestParser()
		parser.add_argument("Username")
		params = parser.parse_args()
		items = []
		result = run_sql_query("SELECT ID, ProductName, Category, RecycleNumber, TimeStamp FROM Recycling WHERE Username = \'" + params["Username"] + "\' ORDER BY ID DESC;")
		for row in result:
			categoryName = ""
			if(row[2] == "M"): categoryName = "Mixed Paper"
			elif(row[2] == "C"): categoryName = "Commingled Materials"
			elif(row[2] == "S"): categoryName = "Scrap Metal"
			elif(row[2] == "E"): categoryName = "Electronics"
			items.append(dict(id=row[0], product_name=row[1], category=categoryName, recycle_number=row[3], timestamp=row[4]))
		return jsonify(items=items)

	def post(self):
		args_list = ("Username", "ProductName", "Category", "RecycleNumber")
		parser = reqparse.RequestParser()
		for arg in args_list:
			parser.add_argument(arg)
		params = parser.parse_args()
		args_str= ', '.join(list(args_list))
		params_used = [str(params[x]) for x in args_list]
		statement = "INSERT OR IGNORE INTO Recycling ("+args_str+") VALUES (\'%s\', \'%s\', \'%s\', \'%s\');"  % tuple(params_used)
		update = run_sql_update(statement)
		if(update.rowcount == 0): return jsonify(success=False)
		return jsonify(success=True)

	def delete(self):
		parser = reqparse.RequestParser()
		parser.add_argument("ID")
		params = parser.parse_args()
		update = run_sql_update("DELETE FROM Recycling WHERE ID = " + params["ID"] + ";")
		if(update.rowcount == 0): return jsonify(success=False)
		return jsonify(success=True)


class Impact(Resource):
	def get(self):
		parser = reqparse.RequestParser()
		parser.add_argument("Username")
		params = parser.parse_args()

		mixedPaper = 0
		commingledGoods = 0
		scrapMetal = 0
		electronics = 0

		mixedPaperCount = run_sql_query("SELECT COUNT(*) FROM Recycling WHERE Username = \'" + params["Username"] + "\' AND Category = 'M';")
		for count in mixedPaperCount:
			mixedPaper = count[0]
		commingledGoodsCount = run_sql_query("SELECT COUNT(*) FROM Recycling WHERE Username = \'" + params["Username"] + "\' AND Category = 'C';")
		for count in commingledGoodsCount:
			commingledGoods = count[0]
		scrapMetalCount = run_sql_query("SELECT COUNT(*) FROM Recycling WHERE Username = \'" + params["Username"] + "\' AND Category = 'S';")
		for count in scrapMetalCount:
			scrapMetal = count[0]
		electronicsCount = run_sql_query("SELECT COUNT(*) FROM Recycling WHERE Username = \'" + params["Username"] + "\' AND Category = 'E';")
		for count in electronicsCount:
			electronics = count[0]

		# ASSUMPTIONS:
		# avg Mixed Paper = .125 lbs
		# avg Commingled Goods = .5 lbs
		# avg Scrap Metal = 143 lbs
		# avg Electronics = 5 lbs

		# conversion calculations can be found in RecyclingConversionCalculations.txt

		trees = round(mixedPaper * .125 * 13806 / 100000, 2)
		oil = round((mixedPaper * .125 * 131560 / 100000) + (commingledGoods * .5 * 194220 / 100000) + (scrapMetal * 143 * 197600 / 100000), 2)
		electricity = round((mixedPaper * .125 * 1389466 / 100000) + (commingledGoods * .5 * 1227148 / 100000) + (scrapMetal * 143 * 30846400 / 100000) + (electronics * 5 * 207064000 / 100000), 2)
		water = round(mixedPaper * .125 * 4163250 / 100000, 2)

		return jsonify(trees_saved=trees, oil_gallons_saved=oil, electricity_hours_saved=electricity, water_gallons_saved=water)

class Instructions(Resource):
	def get(self):
		parser = reqparse.RequestParser()
		parser.add_argument("ZipCode")
		params = parser.parse_args()
		result = run_sql_query("SELECT ZipCode, Source, Instructions FROM RecyclingInstructions WHERE Zipcode = " + params["ZipCode"] + ";")
		for info in result:
			return jsonify(zip_code=info[0], source=info[1], instructions=info[2])



app = Flask(__name__)
api = Api(app)
api.add_resource(User, "/youcycle/user")
api.add_resource(Login, "/youcycle/user/login")
api.add_resource(UserInstructions, "/youcycle/user/instructions")
api.add_resource(Recycle, "/youcycle/recycle")
api.add_resource(Impact, "/youcycle/impact")
api.add_resource(Instructions, "/youcycle/instructions")

if __name__ == '__main__':
	app.run(debug=True)