class GetFiles 

	constructor : (@db, @basePath) ->

		# empty constructor for the time being


	getCss : (pageId, callback) =>

		# responsible for grabbing the proper css files and returnin them in order!

		@_getFiles pageId, "css", (rawFiles) ->

			# this is the callback function necessary for this application
			# will call the callback in this function later

			# loop through each row and grab the url out of the row and then pluck it into 
			urls = @basePath + file.url for file in rawFiles

			# check if we need to use a callback function here
			if callback
				callback urls


		# urls = row.file for row in rawFiles

		return []


	getJavascript : (pageId, callback) =>

		# responsible for grabbing the proper javascript files from the datbase and returning them
		[]		

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


			# check for errors here
			# 


						



	_sortJavascript : (files) =>

		# responsible for sorting the javascript files correctly



root = exports ? window
root.GetFiles = GetFiles
