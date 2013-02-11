{Base} = require "./base"
Q = require "q"
yui = require "yuicompressor"

class Javascript extends Base

	constructor: (@files, @pageId, config, db) ->

		super config, db
		
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
		@_updateDatabase(@config.global.javascriptTable, @pageId, outputFile).then ->

			# resolve the promise once the database is finished
			# this will ensure that there are never multiple functions trying to call the database at once
			q.resolve()

		# return a promise to the caller return q.promise


	_compress: (data) =>

		# returns a promise to deliver the file that would then be compressed / minimized etc
		return false if not data

		q = Q.defer()
			
		options = 

			charset: "utf-8"
			type: "js"
			nomunge: true
			# "line-break": 80

		yui.compress data, options, (err, data, extra) =>

			#  
			q.resolve data


		return q.promise
		




		
# now export the proper variable to the global / calling scope
# window would be if we are using this in a browser etc
root = exports ? window
root.Javascript = Javascript

