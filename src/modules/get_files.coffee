Q = require "q"



class GetFiles 

	constructor : (@db, @basePath) ->

		# empty constructor for the time being

	getCss : (pageId) =>

		q = Q.defer()

		# grab the files from the page_id
		@_getFiles pageId, "css", (files) ->

			# loop through the files and create the proper elements
			q.resolve files

		# return the promise to the calling program -- outsie
		return q.promise

	getJavascript : (pageId) => 

		# responsible for sorting the javascript etc



	_getFiles : (pageId, type, callback) =>


		# this will be hardcoded to allow for control over the table mappings
		table = "javascript_modules"		

		if type == "css"

			table = "stylesheets"

		else if type == "javascript_resources" or type == "resources"

			table = "javascript_resources"

		# initialize the data for the request
		data = 
			status : false
			page_id : pageId


		@db.where(data).get table, (err, rows, fields) -> 

			if err

				console.log "query not working"
				# there was a problem need to exit the program

			else
				callback rows



	_sortJavascript : (files) =>

		# responsible for sorting the javascript files correctly



root = exports ? window
root.GetFiles = GetFiles
