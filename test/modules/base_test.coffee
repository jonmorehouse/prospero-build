{mocha, chai, Q, basePath} = require "../test_helper.coffee"

should = chai.should()

{DB, config} = require "#{basePath}/main"
{GetFiles} = require "#{basePath}/modules/get_files"
{Base} = require "#{basePath}/modules/base"

describe "Base", ->

	base = null
	files = null
	getFiles = new GetFiles DB, config

	before (done) ->

		base = new Base config
		# grab the promise object from the getFiles function
		filesPromise = getFiles.getJavascript "homepage"

		# called once the function resolves its return
		files.then (data) ->

			files = data
			done()



	it "Should be instantiated with just a config object", ->

		base = new Base config
		base.should.not.be.undefined
		base.should.be.an "object"

	describe "Base.readData", ->

		it "Should be a function", ->

			should.exist base.readData
			base.readData.should.be.a "function"

		it "Should return false given anything other than an array of strings", ->

			fileData = base.readData ""

			fileData.should.equal false

		it "Should return a promise object, synchronously", ->

			# files
			fileDataPromise = base.readData files
			fileDataPromise.should.not.be.undefined
			fileDataPromise.should.be.an "object"	

		it "Should should return a string from the promise asynchronously", (done) ->

			fileDataPromise = base.readData files

			fileDataPromise.then (fileData) ->

				should.exist fileData
				fileData.should.be.a "string"

