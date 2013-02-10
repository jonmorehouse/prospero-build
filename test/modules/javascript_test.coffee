{mocha, chai, Q, basePath} = require "../test_helper.coffee"

should = chai.should()

{DB, config} = require "#{basePath}/main"
{GetFiles} = require "#{basePath}/modules/get_files"
{Javascript} = require "#{basePath}/modules/javascript"

describe "Javascript", ->


	# will be responsible for grabbing basic database files etc
	getFiles = new GetFiles DB, config
	# fileList is an array of files that should be returned from the getFiles object to be passed into the javascript section
	fileList = null 
	javascript = null

	# initialize the files by using a promise and then finishing the call
	before (done) ->

		getFiles.getJavascript("homepage").then (files) ->

			fileList = files
			javascript = new Javascript files, "homepage", config, DB
			done()

	describe "Javascript Class should have various properties", ->

		objectTest = new Javascript fileList, "homepage", config, DB

		it "Should store a files variable", ->

			# test the file list
			objectTest.should.not.be.undefined

		it "Should store a pageId string properly", ->

			objectTest.pageId.should.be.defined
			objectTest.pageId.should.be.a "string"

		it "Should store a configuration properly", ->

			objectTest.config.should.be.defined
			objectTest.config.should.be.an "object"

		it "Should store a DB variable properly", ->

			objectTest.db.should.be.defined
			objectTest.db.should.be.an "object"


	describe "Controller function", ->

		it "Should be a function", ->

			should.exist javascript._controller
			javascript._controller.should.be.a "function"

	describe "Compress function", ->

		it "Should be a function", ->

			should.exist javascript._compress 
			javascript._compress.should.be.a "function"

	describe "updateDatabase function", ->		


		pageId = "homepage_test"

		# delete any weirdness from the database after the calls 
		after (done) ->

			done()

			return

			DB.where({"page_id" : pageId}).delete "javascript_modules", (info) ->

				done()


		# initialize all tests		
		it "Should be a function", ->

			should.exist javascript._updateDatabase
			javascript._updateDatabase.should.be.a "function"

		it "Should return false when given anything but two strings", ->

			status = javascript._updateDatabase null, null

		it "Should not throw any errors when given two strings", (done) ->

			# create handler variables to help with the multitude of tests that we are running herr
			errorHandler = (error) ->

				error.should.be.defined
				done()

			successHandler = (status) ->

				status.should.be.undefined
				done()

			javascript._updateDatabase(pageId, "test_url").then () ->

				done()



			
