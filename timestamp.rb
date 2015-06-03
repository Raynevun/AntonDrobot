require 'net/http'
require 'open-uri'
require 'Nokogiri'

uri = URI('https://beacon.nist.gov/rest/record/1433169120')
params = { :limit => 10, :page => 3 }
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)
doc = Nokogiri::XML(res.body)

record = doc.at_xpath('//record')

version = "Version: " + record.at_xpath('//version').content
frequency = "Frequency: " + record.at_xpath('//frequency').content
timeStamp = "TimeStamp: " + record.at_xpath('//timeStamp').content
seedValue = "\n" + "SeedValue: " + record.at_xpath('//seedValue').content
previousOutputValue = "\n" + "PreviousOutputValue: " + record.at_xpath('//previousOutputValue').content
signatureValue = "\n" + "SignatureValue: " + record.at_xpath('//signatureValue').content
outputValue = "\n" + "OutputValue: " + record.at_xpath('//outputValue').content
statusCode = "StatusCode: " + record.at_xpath('//statusCode').content

puts version
puts frequency
puts timeStamp
puts statusCode
puts seedValue
puts previousOutputValue
puts signatureValue
puts outputValue