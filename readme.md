Prospero Build Module
=

Overview
=

This application is useful for grabbing proper resources from a database. For each possible page id, this application will grab the proper less files, combine them and compress them. This will also apply minimzr, prefixr etc for each of these files. This will then run the proper save / compression algorithms to ensure proper saving etc.

Application also responsible for building javascript for the site by combining assets into one file / compression of each.

Problem
=

Before I knew of the beauty of modular javascript such as Require.js / CommonJS etc I used a combination of the object-literal design pattern and a self-revealing factory module pattern design style. The problem I ran into with these were the massive amounts of files I was loading in and how they needed to be delivered in a particular order for the problem I was solving.


Modules / Seperation
-

1.) Main file -- grab page ids
	
	foreach page_ids as page_id 

		instantiate a javascript and css module



2.) CSS Module
	
	get all the proper files
	generate proper urls / files
	combine files
	run prefixr on files
	minimize / compress 
	save file

3.) Javascript Module // responsible for controlling and 

	get all proper files // -- need to sort -- external modules


	generate proper urls / files
	combine files
	minimize javascript

	
