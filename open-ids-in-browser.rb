#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'logger'
require 'launchy'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

ARGF.each_line do |id|
  Launchy.open("http://support.mozilla.org/questions/" + id.to_s)
  sleep(0.5)
end



