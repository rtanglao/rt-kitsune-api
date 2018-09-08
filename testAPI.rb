#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'typhoeus'
require 'awesome_print'

def getKitsuneResponse(url, params)
  result = Typhoeus::Request.get(url,
    :params => params )
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
      :format => "json",
      :product => "firefox", # source: http://code.flickr.net/2008/09/04/whos-on-first/
      :created_date => "09/05/2018",
   #   :created => 2,
    #  :sortby => 2
} 

url = "https://support.mozilla.org/api/2/question/"
questions  = getKitsuneResponse(url, url_params)
ap questions.length
ap questions
