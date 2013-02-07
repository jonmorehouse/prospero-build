DB = require "mysql-activerecord"
config = require "./config.coffee"

db = new DB.Adapter
	server : "localhost"
	username : ""
	password : ""
	database : "test"


console.log config.mysql.username

