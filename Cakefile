fs = require "fs"
# use walk to help when walking proper directories
walk = require "walk"
# use exec to run shell commands
{exec} = require "child_process" 

task "test", "Mocha Tests", ->

	walker = walk.walk "./test", { followLinks: false }

	walker.on "file", (root, stat, next) ->

		file = "#{root}/#{stat.name}"

		# generate the command for the mocha test to be run!
		command = "./node_modules/.bin/mocha"
		# include the coffe-script
		command += " --compilers coffee:coffee-script"
		# include coffeescrip
		# command += " --require coffee-script"
		# ensure that colors are output correctly
		command += " --colors"
		# use the proper test output
		command += " -R spec"
		# run the correct file
		command += " #{file}"

		exec command, (err, output) ->

			throw err if err
			console.log output

			do next






