#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'typhoeus'
require 'awesome_print'
require 'time'

# This script tests: https://github.com/mozilla/kitsune/issues/3946

def getKitsuneResponse(url, params)
  result = Typhoeus::Request.get(url)
  try_count = 0
  begin
    x = JSON.parse(result.body)
  rescue JSON::ParserError => e
    try_count += 1
    if try_count < 4
      $stderr.printf("JSON::ParserError exception, retry:%d\n",\
                     try_count)
      sleep(10)
      retry
    else
      $stderr.printf("JSON::ParserError exception, retrying FAILED\n")
      # raise e
      x = nil
    end
  end
  return x
end

 url_params = {
} 

url = "https://support.mozilla.org/api/2/question/?format=json&ordering=-updated&is_spam=False"
url += "&created__gt=2019-05-13%2007:53:39"
url += "&created__lt=2019-05-13%2007:53:41"

questions  = getKitsuneResponse(url, url_params)
ap questions
question = questions["results"][0]
ap question["created"]
api_time_in_seconds = Time.parse(question["created"]).to_i
puts "created__gt=2019-05-13 07:53:39 presumably UTC"
Time.parse("2019-05-13 07:53:40Z")
puts  "integer time in API result:"+api_time_in_seconds.to_s
api_url_time_in_seconds =
Time.parse("2019-05-13T07:53:40Z").to_i
difference = api_url_time_in_seconds - api_time_in_seconds
if difference == 0
  puts("TEST PASSED")
else
  puts("TEST FAILED! Difference in seconds url time - api time:" + 
    (api_url_time_in_seconds - api_time_in_seconds).to_s)
    puts("TEST FAILED! Difference in hours:" + 
      ((api_url_time_in_seconds - api_time_in_seconds)/3600).to_s)   
end