fs = require "fs"
Q = require "q"


class Base 

	constructor : (@config) ->



	readData : (files) ->

		if not files or not files instanceof Array

			return false

		# normalize the proper paths
		files = @getPaths files

		q = Q.defer()
		fileData = null	

		# recursive worker function
		# need to check that each file exists
		worker = (path) =>

			# check file exists
			fs.exists path, (exists) =>

				if not exists 

					throw new Error "Path #{path} doesn't exist."
					return q.resolve

				# grab the file data and then call the next round of the function
				fs.readFile path, 'utf-8', (err, data) ->

					if err

						throw new Error "Error reading #{path}."
						return q.resolve

					
					# append the data
					fileData += data	
					
					# return the data
					q.resolve data	

				# return another call of this function or return the resolved promise
		worker files[0]

		return q.promise

	getPaths : (files) =>


		if not files or not files instanceof Array

			return false

		return files
		
		files = ("#{@config.basePath}/#{file}" for file in files)

		return files


exports.Base = Base