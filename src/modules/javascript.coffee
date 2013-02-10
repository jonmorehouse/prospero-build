{Base} = require "./base"
Q = require "q"

class Javascript extends Base

	constructor: (@files, @pageId, @config, @db) ->

	_controller: =>

		# first get the compressed files -- into a string
		# second compress the string
		# write the data
		# save the filename to a database with the proper credentials

		q = Q.defer()
		# create the proper file name
		outputFile = "resources/javascript/live/#{@pageId}.js"
		outputPath = "#{@config.basePath}/#{outputFile}"

		# read the data first for all files and then intiialize the compression / saving process
		@readData(@files).then (data) ->

			# now that we have the data, compress it
			@_compress(data).then (data) ->

				# now that the data is compressed, write it out
				@writeData data

		# correctly save the database credentials
		@_updateDatabase(@pageId, outputFile).then ->

			# resolve the promise once the database is finished
			# this will ensure that there are never multiple functions trying to call the database at once
			q.resolve()

		# return a promise to the caller
		return q.promise



	_compress: (data) =>

		# returns a promise to deliver the file that would then be compressed / minimized etc

	_updateDatabase : (pageId, outputFile) =>


		# make sure that the inputs are both valid
		if typeof pageId != "string" or typeof pageId != "string"

			return false

		q = Q.defer()	

		# insert data
		data = 

			page_id : pageId,
			status: true,
			type: "live"

		# search and remove all previous occurrences
		@db.where(data).delete "javascript_modules", (error) =>

			#  
			if error

				throw error
				q.resolve()

			data.url = outputFile

			# insert the data
			@db.insert "javascript_modules", data, (error, info) =>

				# resolve the promise for the caller
				if error
					throw error

				# resolve our promise to the caller function
				q.resolve()

		# return a promise		
		return q.promise		




		
# now export the proper variable to the global / calling scope
# window would be if we are using this in a browser etc
root = exports ? window
root.Javascript = Javascript

