{Base} = require "./base"
Q = require "q"
yui = require "yuicompressor"
less = require "less"


class Css extends Base


	constructor: (@files, @pageId, config, db) ->

		super config, db

	_controller: =>

		# first we need to get all of the files into a string
		# next convert all of the files using the less api
		# compress the converted string of css and save it properly
		# update the database and then accordingly this will be served as a live file


		q = Q.defer()

		outputFile = "resources/css/live/#{@pageId}.css"
		outputPath = "#{@config.basePath}/#{outputFile}"

		@readData(@files).then (data) ->


			# convert the string of the less into valid css
			@_convertLess(data).then (data) ->

				# now compress the css
				@_compress(data).then (data) ->

					# finally lets go ahead and validly save the data
					@writeData data

		@_updateDatabase(@config.global.cssTable, @pageId "css").then ->

			# data is now written to properly update the database
			q.resolve()


		return q.promise


	_compress : (data) ->

		return string if typeof data != "string"

		q = Q.defer()

		options =

			charset : "utf-8"
			type: "css"
			nomunge: true

		yui.compress data, options, (err, data, extra) =>

			q.resolve data

		return q.promise

	_convertLess : (data) =>

		q = Q.defer()

		# compress less
		parserOptions = 

			# list for the css search paths
			paths : @config.global.lessImportPaths

		# conversion options
		options = 

			compress: true

		# create a less parser
		parser new less.Parser parserOptions

		# parse the data
		parser.parse data, (err, tree)

			if err 
				throw err			

			# resolve the minimized css
			q.resolve tree.toCss options

		return q.promise
















