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
		filesPromise.then (data) ->

			files = data
			done()

	it "Should be instantiated with just a config object", ->

		base = new Base config
		base.should.not.be.undefined
		base.should.be.an "object"

	# test readData functionality
	# describe "Base.readData", ->

	# 	it "Should be a function", ->

	# 		should.exist base.readData
	# 		base.readData.should.be.a "function"

	# 	it "Should return false given anything other than an array of strings", ->

	# 		fileData = base.readData ""

	# 		fileData.should.equal false

	# 		# now test when given an array of strings
	# 		fileData = base.readData [""]
	# 		fileData.should.not.equal false


	# 	it "Should return a promise object, synchronously", ->

	# 		# files
	# 		fileDataPromise = base.readData files
	# 		fileDataPromise.should.not.be.undefined
	# 		fileDataPromise.should.be.an "object"	

	# 	it "Should should return an array of strings from the promise asynchronously", (done) ->

	# 		fileDataPromise = base.readData(files).then (fileData) ->

	# 			should.exist fileData
	# 			fileData.should.be.an "array"
	# 			fileData.should.have.length.above 0


	# 		done()	


	# test the getPaths function to ensure proper functionality
	describe "Base.getPaths", ->

		it "Should be a defined object method", ->

			should.exist base.getPaths files
			base.getPaths.should.not.be.undefined

		it "Should return false given anything other than an array", ->

			paths = base.getPaths files
			paths.should.be.an "array"	

			paths = base.getPaths null
			paths.should.equal false

		it "Should return an array of strings given an array of relative paths", ->

			paths = base.getPaths files
			paths.should.be.an "array"
			paths.should.have.length.above 0

