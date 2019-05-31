#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'mongo'
require 'logger'
require 'nokogiri'

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

if ARGV.length < 6
  puts "usage: #{$0} yyyy mm dd yyyy mm dd"
  exit
end

questionsColl = db[:questions]
MIN_DATE = Time.utc(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0)
MAX_DATE = Time.utc(ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i, 23, 59) 

count = questionsColl.find(
  :created =>
  {
    :$gte => MIN_DATE,
    :$lte => MAX_DATE
  },
  :num_answers =>
  {
    :$eq => 0
  }
  ).count
logger.debug count.ai

id_array = []
questionsColl.find(
  :created =>
  {
    :$gte => MIN_DATE,
    :$lte => MAX_DATE
  },
  :num_answers =>
  {
    :$eq => 0
  }  
).sort(
    {"id"=> 1}
    ).projection(
    {
      "_id" => 0,
      "id" => 1,
      "created" => 1,
      "num_answers" => 1
  }).each do |q|
  logger.debug q.ai

  puts "https://support.mozilla.org/questions/" + q["id"].to_s
end

