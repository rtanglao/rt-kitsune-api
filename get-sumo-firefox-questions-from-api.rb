#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'typhoeus'
require 'awesome_print'
require 'json'
require 'time'
require 'date'
require 'mongo'
require 'csv'
require 'logger'
require 'pp'

# based on:# https://github.com/rtanglao/2016-rtgram/blob/master/backupPublicVancouverPhotosByDateTaken.rb

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
logger = Logger.new(STDERR)
logger.level = Logger::DEBUG
Mongo::Logger.logger.level = Logger::FATAL
MONGO_HOST = ENV["MONGO_HOST"]
raise(StandardError,"Set Mongo hostname in ENV: 'MONGO_HOST'") if !MONGO_HOST
MONGO_PORT = ENV["MONGO_PORT"]
raise(StandardError,"Set Mongo port in ENV: 'MONGO_PORT'") if !MONGO_PORT
MONGO_USER = ENV["MONGO_USER"]
# raise(StandardError,"Set Mongo user in ENV: 'MONGO_USER'") if !MONGO_USER
MONGO_PASSWORD = ENV["MONGO_PASSWORD"]
# raise(StandardError,"Set Mongo user in ENV: 'MONGO_PASSWORD'") if !MONGO_PASSWORD
SUMO_QUESTIONS_DB = ENV["SUMO_QUESTIONS_DB"]
raise(StandardError,\
      "Set SUMO questions  database name in ENV: 'SUMO_QUESTIONS_DB'") \
if !SUMO_QUESTIONS_DB

db = Mongo::Client.new([MONGO_HOST], :database => SUMO_QUESTIONS_DB)
if MONGO_USER
  auth = db.authenticate(MONGO_USER, MONGO_PASSWORD)
  if !auth
    raise(StandardError, "Couldn't authenticate, exiting")
    exit
  end
end

if ARGV.length < 3
  puts "usage: #{$0} yyyy mm dd" #start date (since api always goes from latest backwards to the start date)
  exit
end

#questionsColl = db[:questions]
#questionsColl.indexes.create_one({ "id" => -1 }, :unique => true)
MIN_DATE = Time.local(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
      
url_params = {
  :format => "json",
  :product => "firefox", 
  :locale => "en-US",
  :ordering => "+created",
} 

url = "https://support.mozilla.org/api/2/question/"
end_program = false
  
begin
  questions  = getKitsuneResponse(url, url_params)
  url = questions["next"]
  url_params = nil
  questions["results"].each do|question|
      logger.debug "created:" + question["created"]
      created = Date.parse(question["created"]).to_time
      logger.debug "QUESTION created:" + created.to_i.to_s
      question["created"] = created
      #if datetaken < min_taken_date_from_instagram
      #  min_taken_date_from_instagram = datetaken
      exit if created < MIN_DATE
      id = question["id"]
      logger.debug "QUESTION id:" + id.to_s
     #questionsColl.find({ 'id' => id }).update_one(
       #question,:upsert => true )
  end
    
end
