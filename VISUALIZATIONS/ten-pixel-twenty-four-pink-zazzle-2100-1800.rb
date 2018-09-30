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
# following palette is from: https://graf1x.com/24-shades-of-pink-color-palette/
palette_24 = [
  'FDAB9F',
  'DF5286',
  'FE5BAC',
  'F987C5',
  'F19CBB',
  'fb607f',
  'fca3b7',
  'de6fa1',
  'de3163',
  'ec5578',
  'e0115f',
  'ff00ff',
  'fe7f9c',
  'f5c3c2',
  'ff69b4',
  'fbaed2',
  'ff66cc',
  'ff0090',
  'ffa6c9',
  'fdb9c8',
  'ff6fff',
  'f64a8a',
  'f81894',
  'fc0fc0'
  ]
palette_24.each do |c|
  components =  c.scan(/.{2}/)
  rgb = [components[0].hex, components[1].hex, components[2].hex]
  palette_rgb.push(rgb)
end
logger.debug palette_rgb.ai

def get_colour(rgb, c)
  return rgb[c % 24]
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

if ARGV.length < 7
  puts "usage: #{$0} yyyy mm dd yyyy mm dd filename" # day you want to open
  exit
end

questionsColl = db[:questions]
MIN_DATE = Time.local(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, 0, 0) # may want Time.utc if you don't want local time
MAX_DATE = Time.local(ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i, 23, 59) # may want Time.utc if you don't want local time
FILENAME = ARGV[6]

column = 0
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
    "title" => 1,
    "tags" => 1
  }).each do |q|
    logger.debug q.ai
    id = q["id"]
    title = q["title"]
    content = q["content"]
    int_array = title.each_char.map(&:ord) + content.each_char.map(&:ord)
    tags = q["tags"]
    tags.each {|t| int_array += t["slug"].each_char.map(&:ord)}
    int_array.each do |c|
      
      logger.debug "ROW:" + row.to_s
      logger.debug "COLUMN:" + column.to_s
      logger.debug "C:" + c.to_s
      colour_rgb = get_colour(palette_rgb, c)
      logger.debug "COLOUR:" + colour_rgb.ai
      for col_offset in 0..9 do
        png[column + col_offset, row] = ChunkyPNG::Color.rgb(colour_rgb[0], colour_rgb[1], colour_rgb[2])
      end
      column += 10
      if column == ZAZZLE_WIDTH
        column = 0
        row += 1
      end 
      if row == ZAZZLE_HEIGHT
        exit_program = true
        break
      end 
    end 
    break if exit_program
end
  
png.save(FILENAME, :interlace => true)
