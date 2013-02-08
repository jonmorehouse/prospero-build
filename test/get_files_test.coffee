chai = require "chai"
mocha = require "mocha"

should = chai.should()


# we want to export the database connection from our main controller file
{DB} = require "../src/main.coffee"
# get_files is the class currently being tested
{GetFiles} = require "../src/modules/get_files"

describe "GetFiles", ->

	getFiles = new GetFiles DB

	# test basic setting up of files etc
	it "should have a DB connection", ->

		should.exist getFiles.db

	it "should have css and javascript functions", ->

		should.exist getFiles.getCss
		should.exist getFiles.getJavascript

	it "should have a private javascript sort function", ->

		should.exist getFiles._sortJavascript #specifically designed function to help ensure that we sort the javascript files correctly

	it "should have a private getFiles function", ->

		should.exist getFiles._getFiles #specifically for getting the objects


	# test the actual functions here
	describe "Getfiles._getFiles", ->

		it "Should have an element", (done)->

			getFiles._getFiles "homepage", "css", (data) ->

				data.should.not.be.undefined
				data.should.be.an "array"
				data.should.have.length.above 0

				done()

	describe "Getfiles._sortJavascript", ->

		test = null
		before (done) ->

			test = "null"
			done()

		beforeEach (done) ->

			console.log "Before each!"
			done()


		it "Should return a sorted list", (done) ->

			test.should.not.be.undefined

			done()

		it "Should have something that looks cool!", (done) ->



			done()

				

	describe "Getfiles.getCSS", ->

		it "Should return a list of full urls for css files given the correct page_id", -> 

			files = getFiles.getCss "homepage"
			# files.should.be.defined


	describe "Getfiles.getJavascript", ->

		it "should return a list of file urls", ->

			# files = getFiles.getJavascript "homepage"
			# should.exist files
			
			# files.should.be.an "array"









