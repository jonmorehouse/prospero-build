fs = require "fs"
Q = require "q"


class Base 

	constructor : (@config) ->



	readData : (files) ->

		if not files or typeof files != "array" or files.length == 0

			return false

		# will be responsible for loading in the proper files each time etc
		# create a deferment promise for this object
		q = Q.defer()

		# fileData variable will contain all of the information from all of the files etc
		fileData = ""

		# need an asynchronouse function here to return the promises etc
		read = fs.readData array.splice(files, 1), (err, data) ->

			# append the file data
			fileData += data

			# if there are no other files to append then we need to append the data that we recieved
			if files.length == 0

				# end the function by fulfilling the promise
				return q.resolve fileData

			# return this function
			else
				return read


		return q.promise