class GetFiles 

	constructor : (@db) ->


	getCss : (pageId) =>

		# responsible for grabbing the proper css files and returnin them in order!

	getJavascript : (pageId) =>

		# responsible for grabbing the proper javascript files from the datbase and returning them

	_getFiles : (pageId, type) =>

		# this will be hardcoded in to be responsible for us 



	_sortJavascript : (files) =>

		# responsible for sorting the javascript files correctly





root = exports ? window
root.GetFiles = GetFiles
