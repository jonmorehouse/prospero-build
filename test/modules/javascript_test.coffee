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
			javascript = new Javascript files
			done()

	it "should be instantiated by passing a list of files and a config object", ->

		fileList.should.not.be.undefined
		fileList.should.be.an "array"
		javascript = new Javascript fileList
		javascript.should.not.be.undefined
		javascript.should.be.an "object"

	describe "Controller function", ->

		it "Should be a function", ->

			should.exist javascript._controller
			javascript._controller.should.be.a "function"

	describe "Combine function", ->

		it "Should be a function", ->

			should.exist javascript._combine
			javascript._combine.should.be.a "function"


	describe "Compress function", ->

		it "Should be a function", ->

			should.exist javascript._compress 
			javascript._compress.should.be.a "function"

	describe "Output function", ->

		it "Should be a function", ->

			should.exist javascript._output
			javascript._output.should.be.a "function"

	describe "updateDatabase function", ->		

		it "Should be a function", ->

			should.exist javascript._updateDatabase
			javascript._updateDatabase.should.be.a "function"

			

		
