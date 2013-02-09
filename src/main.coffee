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

# 
root = exports ? window
root.DB = db
root.config = config