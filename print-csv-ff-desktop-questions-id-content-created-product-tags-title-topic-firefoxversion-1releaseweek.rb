#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'mongo'
require 'logger'
require 'csv'
require 'tzinfo'
tzinfo = TZInfo::Timezone.get("America/Vancouver") # hardcode to Vancouver time zone

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

if ARGV.length < 5
  puts "usage: #{$0} yyyy mm dd firefoxversion releaseweek"
  exit
end

questionsColl = db[:questions]
min_date = tzinfo.local_time(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
FIREFOXVERSION = ARGV[3]
RELEASEWEEK = ARGV[4]

FILENAME = sprintf("firefox-%s-week-%s-id-created-title-content-tags-product-topic.csv",
  FIREFOXVERSION, RELEASEWEEK)

headers = ['id', 'created', 'title', 'content', 'tags', 'product', 'topic', 'firefoxversion',
  'releaseweek', 'day']

CSV.open(FILENAME, 'w', write_headers: true, headers: headers) do |csv|
  (1..7).each do |day|
    max_date = min_date + 24 * 3600 - 1
    questionsColl.find(:created =>
    {
      :$gte => min_date,
      :$lte => max_date },
    ).sort(
    {"id"=> 1}
    ).projection(
    {
      "id" => 1,
      "tags" => 1,
      "created" => 1,
     "content" => 1,
      "title" =>1,
      "product" => 1,
      "topic" => 1
    }).each do |q|
      id = q["id"]
      logger.debug "QUESTION id:" + id.to_s
      tags = q["tags"]
      tag_str = ""
      tags.each { |t| tag_str = tag_str + t["slug"] + ";"   }
      csv << [id,
        q["created"].to_i.to_s, q["title"], q["content"], tag_str, q["product"], q["topic"],
        FIREFOXVERSION.to_i.to_s, RELEASEWEEK.to_i.to_s, day.to_i.to_s]
    end
    min_date += 24 * 3600
  end
end
