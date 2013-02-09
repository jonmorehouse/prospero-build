# load in proper modules for this test app
chai = require "chai"
mocha = require "mocha"
Q = require "q"


# initialize should statements
should = chai.should()


# we want to export the database connection from our main controller file
{DB, config} = require "../src/main.coffee"
# get_files is the class currently being tested
{GetFiles} = require "../src/modules/get_files"

# desribe getFiles class
describe "GetFiles", ->

	getFiles = new GetFiles DB, config

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
				data[0].should.be.an "object"

				done()

	describe "Getfiles._sortJavascript", ->

		# need to get files
		# test the files against each page etc
		files = null #initialize the files element	
		before (done) ->

			getFiles._getFiles "homepage", "javascript", (data) ->

				files = data
				done()

		it "Should return a list of sorted javascript files given a files object", (done) ->

			getFiles._sortJavascript files, (sortedFiles) ->

				sortedFiles.should.not.be.undefined
				sortedFiles.should.be.an "array"
				sortedFiles.should.have.length.above 0
				sortedFiles[0].should.be.a "string"
				done()

		it "Should sort the list properly for the homepage", (done) ->

			getFiles._sortJavascript files, (sortedFiles) ->


				console.log sortedFiles

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









