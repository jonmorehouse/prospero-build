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

				# finally lets go ahead and validly save the data
				@writeData data

		@_updateDatabase(@config.global.cssTable, @pageId "css").then ->

			# data is now written to properly update the database
			q.resolve()

		# return a promise for the proper data
		return q.promise

	_convertLess : (data) =>

		# make sure that the data passed in is a string
		return false if not data or typeof(data) != "string"

		q = Q.defer()

		# compress less
		parserOptions = 

			# list for the css search paths
			paths : @config.global.lessImportPaths

		# conversion options
		options = 

			compress: true

		# create a less parser
		parser = new less.Parser parserOptions

		# parse the data
		parser.parse data, (err, tree) ->

			# check and make sure no errors exist
			if err 
				throw err			

			# resolve the minimized css
			q.resolve tree.toCSS options

		return q.promise

exports.Css = Css














