#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'mongo'
require 'logger'
require 'launchy'

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
  puts "usage: #{$0} yyyy mm dd" # day you want to open
  exit
end

questionsColl = db[:questions]
MIN_DATE = Time.utc(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
MAX_DATE = Time.utc(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 23, 59) # may want Time.utc if you don't want local time

number_of_tabs_for_this_day = 0
questionsColl.find(:created =>
  {
    :$gte => MIN_DATE,
    :$lte => MAX_DATE },
  ).sort(
  {"id"=> 1}
  ).projection(
  {
    "id" => 1
  }).each do |q|
  id = q["id"]

  number_of_tabs_for_this_day += 1
  logger.debug "QUESTION id:" + id.to_s
  Launchy.open("http://support.mozilla.org/questions/" + id.to_s)
  sleep(0.5)
end
  logger.debug "number of tabs for this day:" + number_of_tabs_for_this_day.to_s

  

