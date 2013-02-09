fs = require "fs"
# use walk to help when walking proper directories
walk = require "walk"
# use exec to run shell commands
exec = require "child_process" 

task "test", "Mocha Tests", ->

	walker = walk.walk "./test", { followLinks: false }

	walker.on "file", (root, stat, next) ->

		file = "#{root}/#{stat.name}"

		# generate the command for the mocha test to be run!
		command = "./node_modules/.bin/mocha"
		command += " --compilers coffee:coffee-script"
		# command += " --reporter #{REPORTER}"
		command += " --require coffee-script"
		command += " --require test/test_helper.coffee"
		command += " --colors"
			
		exec command, (err, output) ->

			throw err if err
			console.log output

			do next






