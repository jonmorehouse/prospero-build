{mocha, chai, Q, basePath, global} = require "../test_helper.coffee"
fs = require "fs"

should = chai.should()

{DB, config} = require "#{basePath}/main"
{GetFiles} = require "#{basePath}/modules/get_files"
{Css} = require "#{basePath}/modules/css"


describe "CSS", ->

	# generate a proper getFiles object
	getFiles = new GetFiles DB, config

	# async variable assignment

	fileList = null
	css = null

	# initialize the elements before running any tests -- asynchronously
	before (done) ->

		# get the files and then set the proper variables
		getFiles.getCss(config.global.testPageId).then (files) =>

			fileList = files	
			css = new Css fileList, config.global.testPageId, config, DB
			done()

	describe "Css Class should have various properties", ->

		objectTest = new Css fileList, config.global.testPageId, config, DB

		it "Should exist", ->

			objectTest.should.not.be.undefined


		it "Should have a _controller function", ->

			should.exist objectTest._controller
			objectTest._controller.should.be.a "function"

		it "Should have a _convertLess function", ->

			should.exist objectTest._convertLess
			objectTest._convertLess.should.be.a "function"

	describe "_convertLess function should properly convert a string of less data to css", ->

		it "Should return false given anything other than a string of data", ->

			# make sure that we don't return anything but false when passing null
			css._convertLess().should.equal false
			css._convertLess(1).should.equal false
			css._convertLess(".class { width: (1 + 1) }").should.not.equal false


		it "Should return minimized data when passed valid less data", (done) ->

			fs.readFile config.global.testLessFile, "utf-8", (err, data) ->

				css._convertLess(data).then (data) ->

					# make sure that data is a string
					data.should.be.a "string"
					done()






