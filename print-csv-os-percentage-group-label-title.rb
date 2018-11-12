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

if ARGV.length < 6
  puts "usage: #{$0} yyyy mm dd yyyy mm dd" # day you want to open
  exit
end

questionsColl = db[:questions]
MIN_DATE = Time.local(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
MAX_DATE = Time.local(ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i, 23, 59) # may want Time.utc if you don't want local time

print "os,percentage,group,label,title\n"
num_questions = 0
os_count_array=[]
questionsColl.find(:created => {
  :$gte => MIN_DATE,  
  :$lte => MAX_DATE },
  ).sort(
  {"id"=> 1}
  ).projection(
  {
    "id" => 1,
    "metadata" => 1,
    "created" => 1
}).each do |q|
  
  num_questions += 1
  id = q["id"]

  logger.debug "QUESTION id:" + id.to_s
  metadata = q["metadata"]
  m =  metadata.detect { |mnv| mnv["name"] == "os"}
  if m.nil?
    logger.debug "NO operating system tag"
    os = "other"
  else
    os = m["value"]
    logger.debug "operating system tag:" + os
  end
  case os
  when /^Windows 7/i
    os = "Windows 7"
  when /^Windows 10/i
    os = "Windows 10"
  when /^Windows 8/i
    os = "Windows 8"
  when /^Windows XP/i
    os = "Windows XP"
  when /^Mac OS/i, /^macos/i
    os = "Mac OS"
  when /^Linux/i, /^ubuntu/i, /^centos/i, /^arch/i, /^lfs/i, /^fedora/i 
    os = "Linux"
  else 
    logger.debug "SETTING os:" + os + " to other"
    os = "other"
  end

  os_index = os_count_array.detect { |o| o["os"] == os}
  if os_index.nil?
    os_count_array.push({'count' => 1, 'os' => os})
  else
    os_index['count'] += 1
  end
end
logger.debug os_count_array.ai
variable = "operating system"
group = "orange"
os_count_array.each do |o|
  percentage = (o["count"]/num_questions).round(2)
  label = sprintf("%2.2d%%", percentage * 100)
  title = o["os"]
  printf ("%s,%f,%s,%s,%s\n" variable, percentage, label, title)
end
