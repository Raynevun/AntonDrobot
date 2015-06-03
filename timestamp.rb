require 'net/http'
require 'open-uri'
require 'Nokogiri'

def timeStampReq(record, time)
	time_stamp_rec_type = record.to_s + (time - 60).to_s
	uri = URI.join('https://beacon.nist.gov/rest/record/', time_stamp_rec_type)

	params = { :limit => 10, :page => 3 }
	uri.query = URI.encode_www_form(params)

	res = Net::HTTP.get_response(uri)
	doc = Nokogiri::XML(res.body)

	record = doc.at_xpath('//record')

	version = record.at_xpath('//version').content.to_s
	frequency = record.at_xpath('//frequency').content.to_s
	timeStamp = record.at_xpath('//timeStamp').content.to_s
	seedValue = record.at_xpath('//seedValue').content.to_s
	previousOutputValue = record.at_xpath('//previousOutputValue').content.to_s
	signatureValue = record.at_xpath('//signatureValue').content.to_s
	outputValue = record.at_xpath('//outputValue').content.to_s
	statusCode = record.at_xpath('//statusCode').content.to_s

	data = Array.new
	data.push version
	data.push frequency
	data.push timeStamp
	data.push seedValue
	data.push previousOutputValue
	data.push signatureValue
	data.push outputValue
	data.push statusCode
	
return data
end

def PrintData()
	data_arr = timeStampReq('next/' ,Time.now.to_i)

	puts("Version: " + data_arr[0])
	puts("Frequency: " + data_arr[1])
	puts("TimeStamp: " + data_arr[2])
	puts("\n" + "SeedValue: " + data_arr[3])
	puts("\n" + "PreviousOutputValue: " + data_arr[4])
	puts("\n" + "SignatureValue: " + data_arr[5])
	puts("\n" + "OutputValue: " + data_arr[6])
	puts("StatusCode: " + data_arr[7])
end