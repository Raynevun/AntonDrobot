load 'timestamp.rb'
require 'test/unit'
require 'net/http'
require 'open-uri'
require 'Nokogiri'

class TimeStampTests < Test::Unit::TestCase
	def test_defaultRec
		time_var = Time.now.to_i
		doc = timeStampReq('' ,time_var)
		assert_equal(doc[0], 'Version 1.0')
		assert_equal(doc[1], '60')
		#assert_equal(doc[2], time_var.to_s)
		#assert_equal(doc[3], '0')
	end

	def test_nextRec
		time_var = Time.now.to_i
		doc = timeStampReq('next/' ,time_var)
		assert_equal(doc[0], 'Version 1.0')
		assert_equal(doc[1], '60')
		assert_equal(doc[2], time_var.to_s)
		assert_equal(doc[3], '0')
	end
end