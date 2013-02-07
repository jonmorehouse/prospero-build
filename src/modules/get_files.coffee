class GetFiles 

	constructor : (@db) ->

		# empty constructor for the time being


	getCss : (pageId) =>

		# responsible for grabbing the proper css files and returnin them in order!

	getJavascript : (pageId) =>

		# responsible for grabbing the proper javascript files from the datbase and returning them
		[]		

	_getFiles : (pageId, type) =>

		# this will be hardcoded to allow for control over the table mappings
		table = "javascript_modules"		

		if pageId === "css"

			table = "stylesheets"

		else if pageId === "javascript_resources" or pageId === "resources"

			table = "javascript_resources"


		# initialize the data for the request
		data = 
			status : false
			page_id : pageId

		@db.where(data).get table, (err, rows, fields) => 

			return rows


						



	_sortJavascript : (files) =>

		# responsible for sorting the javascript files correctly



root = exports ? window
root.GetFiles = GetFiles
