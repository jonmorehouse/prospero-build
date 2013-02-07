DB = require "mysql-activerecord"
config = require "../config.coffee"

# instantiate a database connection
db = new DB.Adapter
	server : config.mysql.host
	username : config.mysql.username
	password : config.mysql.password
	database : config.mysql.database


table = "valid_page_ids"
# db.select("category").get "category_type_categories", (err, rows, fields) =>
for page_id in config.page_ids

	# data to be inserted
	data = 
		page_id : page_id

	# run the insertion
	db.insert table, data, (err, info) =>

		# insertion ran correctly

name = "Jon"

root = exports ? window
root.DB = db

