#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'mongo'
require 'logger'
require 'chunky_png'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG
Mongo::Logger.logger.level = Logger::FATAL
ZAZZLE_WIDTH = 2100
ZAZZLE_HEIGHT = 1800
png = ChunkyPNG::Image.new(
  ZAZZLE_WIDTH,
  ZAZZLE_HEIGHT,
  ChunkyPNG::Color::TRANSPARENT
)

palette_rgb = []
palette_9 = ['a6cee3','1f78b4','b2df8a','33a02c','fb9a99','e31a1c','fdbf6f','ff7f00','cab2d6']
palette_9.each do |c|
  components =  c.scan(/.{2}/)
  rgb = [components[0].hex, components[1].hex, components[2].hex]
  palette_rgb.push(rgb)
end
logger.debug palette_rgb.ai

def get_pink(rgb, c)
  return rgb[c % 9]
end
  
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

num_pixels = 0
column = -1
row = 0
exit_program = false
questionsColl.find(:created =>
  {
    :$gte => MIN_DATE,
    :$lte => MAX_DATE },
  ).sort(
  {"id"=> 1}
  ).projection(
  {
    "id" => 1,
    "content" => 1,
    "title" => 1
  }).each do |q|
    id = q["id"]
    title = q["title"]
    content = q["content"]

    int_array = title.each_char.map(&:ord) + content.each_char.map(&:ord)
    int_array.each do |c|
      column += 1
      if column == ZAZZLE_WIDTH
        column = 1
        row += 1
      end
      if row == ZAZZLE_HEIGHT
        exit_program = true
        break
      end
      logger.debug "ROW:" + row.to_s
      logger.debug "COLUMN:" + column.to_s
      logger.debug "C:" + c.to_s
      logger.debug "PINK:" + get_pink(c)
      png[column,row] = ChunkyPNG::Color(get_pink(palette_rgb, c))
    end
    break if exit_program
end
  
png.save('pink.png', :interlace => true)
