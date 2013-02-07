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

	# test the actual functions here
	describe "Getfiles.getJavascript", ->

		it "should return a list of file urls", ->

			files = getFiles.getJavascript("homepage")
			should.exist files
			
			files.should.be.an "array"

	describe "Getfiles._sortJavascript", ->

		it "should return a sorted list based upon "
		
		










