class Javascript

	constructor: (@page_id) ->



	get_files : () =>


		console.log "asdf"




# now export the proper variable to the global / calling scope
# window would be if we are using this in a browser etc
root = exports ? window
root.Javascript = Javascript

