chai = require "chai"
mocha = require "mocha"

do chai.should


# load in a coffee script file for the loading
# this handles different exportable variables etc in this scope
{Javascript} = require "../src/modules/javascript"


# describe a basic test
describe 'Javascript instance', ->

	# objects that are being tested here
	javascript_1 = javascript_2 = null

	# make sure that it has a name
	it 'should have a page_id', ->  

        javascript_1 = new Javascript 'homepage'  
        javascript_1.page_id.should.equal 'homepage'  



