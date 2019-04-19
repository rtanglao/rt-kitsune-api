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
MIN_DATE = Time.local(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
MAX_DATE = Time.local(ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i, 23, 59) # may want Time.utc if you don't want local time

count = questionsColl.find(
  :created =>
  {
    :$gte => MIN_DATE,
    :$lte => MAX_DATE
  }
  ).count
logger.debug count.ai

id_array = []
questionsColl.find(:created =>
  {
    :$gte => MIN_DATE,
    :$lte => MAX_DATE }).sort(
    {"id"=> 1}
    ).projection(
    {
      "_id" => 0,
      "id" => 1,
      "created" => 1,
      "title" => 1,
      "content" => 1,
      "tags" => 1
  }).each do |q|
    logger.debug q.ai
    push_id = false
    content = Nokogiri::HTML(q["content"]).text
    tags = q["tags"]
    tags_str = tags.map { |tag| "#{tag['slug']}" }.join(' ')
    text = tags_str + " " + q["title"] + " " + content
    text = text.downcase
    logger.debug text.ai
    if text =~ /(2fa|two-factor-authentication|two factor authentication|recovery code)/ ||
      text =~
      /(two factor|two-factor|dual factor|dual-factor|authy|2-factor|2 factor|google authenticator)/
      logger.debug "SETTING PUSH_ID to TRUE"
      push_id = true
    end
    id_array.push(q["id"]) if push_id
  end
puts id_array