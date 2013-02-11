{mocha, chai, Q, basePath, fs} = require "../test_helper.coffee"

should = chai.should()

{DB, config} = require "#{basePath}/main"
{GetFiles} = require "#{basePath}/modules/get_files"
{Base} = require "#{basePath}/modules/base"

describe "Base", ->

	base = null
	files = null
	getFiles = new GetFiles DB, config
	tempFile = "#{basePath}/tempTest.tmp"

	before (done) ->

		base = new Base config
		# grab the promise object from the getFiles function
		filesPromise = getFiles.getJavascript "homepage"

		# called once the function resolves its return
		filesPromise.then (data) ->

			files = data
			done()

	after (done) ->

		fs.exists tempFile, (status) ->

			if status

				fs.unlink tempFile, ->

					console.log "#{tempFile} deleted."
			done()		
					

	it "Should be instantiated with just a config object", ->

		base = new Base config, DB
		base.should.not.be.undefined
		base.should.be.an "object"

	# test readData functionality
	describe "Base.readData", ->

		it "Should be a function", ->

			should.exist base.readData
			base.readData.should.be.a "function"

		it "Should return false when given anything other than an array of strings", ->

			data = base.readData ""
			data.should.equal false

		it "Should return a string when passed a list of paths", (done) ->
			# now test the readData asynchronous function when we pass it in a valid files object
			data = base.readData files
			data.then (fileData) ->

				should.exist fileData
				fileData.should.not.be.undefined
				fileData.should.be.a "string"

				done()

		it "Should return a promise object, synchronously", ->

			# files
			fileDataPromise = base.readData files
			fileDataPromise.should.not.be.undefined
			fileDataPromise.should.be.an "object"	



	# test the writeData function
	describe "base.writeData", ->

		it "Should properly write the file data", (done) ->

			# write the file and test the status that it exists afterwards
			base.writeData(tempFile, "Hello world from writeData").then ->

				fs.exists tempFile, (status) ->

					status.should.equal true
					done()

	# test the getPaths function to ensure proper functionality
	describe "Base._getPaths", ->

		it "Should be a defined object method", ->

			should.exist base._getPaths files
			base._getPaths.should.not.be.undefined

		it "Should return false given anything other than an array", ->

			paths = base._getPaths files
			paths.should.be.an "array"	

			paths = base._getPaths null
			paths.should.equal false

		it "Should return an array of strings given an array of relative paths", ->

			paths = base._getPaths files
			paths.should.be.an "array"
			paths.should.have.length.above 0


	# test the updateDatabase section
	describe "Base._updateDatabase function", ->		

		pageId = "homepage_test"

		# delete any weirdness from the database after the calls 
		after (done) ->

			DB.where({"page_id" : pageId}).delete "javascript_modules", (info) ->

				done()


		# initialize all tests		
		it "Should be a function", ->

			should.exist base._updateDatabase
			base._updateDatabase.should.be.a "function"

		it "Should return false when given anything but two strings", ->

			status = base._updateDatabase null, null

		# 
		it "Should not throw any errors when given two strings", (done) ->

			# create handler variables to help with the multitude of tests that we are running herr
			errorHandler = (error) ->

				error.should.be.defined
				done()

			successHandler = (status) ->

				status.should.be.undefined
				done()

			base._updateDatabase(config.global.javascriptTable, pageId, "test_url").then () ->

				done()



			
