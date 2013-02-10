class Javascript

	constructor: (@files, @config) ->


	_controller: =>

		# will be responsible for calling the combine section
		# will then compress the file

	
	_combine: (files) =>

		# returns a promise for the file that would be compressed


	_compress: (data) =>

		# returns a promise to deliver the file that would then be compressed / minimized etc

	_output: (data) =>
		# will be responsible for saving the file to the proper output file based upon our given logic etc

	_updateDatabase : (data) =>

		# will be a function that later is responsible for updating the database with particular elements to ensure that our data is being recieved / updated accordingly on our site

		
# now export the proper variable to the global / calling scope
# window would be if we are using this in a browser etc
root = exports ? window
root.Javascript = Javascript

