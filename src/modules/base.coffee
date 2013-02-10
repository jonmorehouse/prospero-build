fs = require "fs"
Q = require "q"


class Base 

	constructor : (@config) ->



	readData : (files) ->

		if not files or not files instanceof Array

			return false

		# normalize the proper paths
		files = @_getPaths(files).reverse()

		q = Q.defer()
		fileData = ""

		# recursive worker function
		# need to check that each file exists
		worker = (path) =>

			fs.exists path, (status) =>

				# if the file doesn't exist we want to throw an error and stop compilation because this will be a problem for compiled applications
				if not status

					throw new Error "File doesn't exist"
					q.resolve 

				# now that we know the file exists, lets read it and grab the data to append to our string that's already being saved
				fs.readFile path, "utf-8", (err, data) =>

					# ensure that the data was read properly
					if err

						throw new Error "File data could not be read properly"
						q.resolve

					# append the data
					fileData += data

					# handle recursivity 
					if files.length > 0

						# initialize the next iteration
						return worker files.pop()

					else	

						return q.resolve fileData	


		# initialize the worker recursive function to start the file saving
		worker files.pop()

		return q.promise


	writeData : (path, data) =>

		q = Q.defer()

		fs.writeFile path, data, (error) =>

			# ensure that no error occured
			if error

				throw error

			q.resolve()

		return q.promise


	_getPaths : (files) =>


		if not files or not files instanceof Array

			return false

		files = ("#{@config.basePath}/#{file}" for file in files)

		return files








exports.Base = Base