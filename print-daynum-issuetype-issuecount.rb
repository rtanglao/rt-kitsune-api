#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'mongo'
require 'logger'

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

if ARGV.length < 4
  puts "usage: #{$0} yyyy mm dd number_of_days" # 
  exit
end

questionsColl = db[:questions]
min_date = Time.local(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
NUMBER_OF_DAYS = ARGV[3].to_i
print "daynumber,issue.type,issue.count\n"
num_days = 0
day_number = 1
while (num_days < NUMBER_OF_DAYS) do
  number_of_bookmarks = 0
  number_of_antivirus = 0
  max_date = Time.at(min_date.to_i + (60 * 60 * 24) - 1)
  logger.debug "MIN:" + min_date.to_i.to_s + " MAX:" + max_date.to_i.to_s
  questionsColl.find(:created => 
  {
    :$gte => min_date,  
    :$lte => max_date },
    ).sort(
    {"id"=> 1}
    ).projection(
    {
      "id" => 1,
      "content" => 1,
      "title" => 1
  }).each do |q|
  
    logger.debug q.ai    
    id = q["id"]
    text = q["title"] + " " + q["content"]

    logger.debug "QUESTION id:" + id.to_s
    logger.debug "TEXT:" + text
    case text
      when /bookmark/i
        number_of_bookmarks += 1
      when /kaspersky/i, /sophos/i, /avast/i, /avg/i, /bitdefender/i, /norton/i, /eset/i, /mcafee/i, /nod32/i,
        /secureanywhere/i, /trendmicro/i, /trend micro/i, /anti virus/i, /antivirus/i
        number_of_antivirus += 1
    end
 
    print day_number.to_s + "," + "bookmarks," + number_of_bookmarks.to_s + "\n"
    print day_number.to_s + "," + "antivirus," + number_of_antivirus.to_s + "\n"
  end
  
  day_number += 1
  num_days += 1
  
  min_date = Time.at(min_date.to_i + 60 * 60 * 24)
end
