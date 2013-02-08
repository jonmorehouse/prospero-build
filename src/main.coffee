# node modules
DB = require "mysql-activerecord"
Q = require "q"

# project files
config = require "../config.coffee"
getFiles = require "./modules/get_files.coffee"

# instantiate a database connection
db = new DB.Adapter
	server : config.mysql.host
	username : config.mysql.username
	password : config.mysql.password
	database : config.mysql.database



get = new getFiles.GetFiles db, "base_path"

get.getCss("homepage").then (files) ->

	console.log files
	process.exit 1 #this is what kills the database functionality because otherwise it will keep the program alive

root = exports ? window
root.DB = db
