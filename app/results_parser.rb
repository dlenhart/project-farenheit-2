# frozen_string_literal: true

# This script will parse the datafile to a readable json file for the
# D3 JS chart.
# Parsing Ferenheit from file. Since temperature is polled every minute
# - extract the hourly runs. http://bl.ocks.org/oyyd/859fafc8122977a3afd6

# usage: ruby results_parser.rb "temperatures.log" "/Users/drewlenhart/Desktop/"

require 'pry'
require './file_writer'

puts 'Beginning file parsing....'

if ARGV.length != 2
  puts 'Expecting TWO arguments (file location, and save location)!!'
  exit
end

file = ARGV[0]
save_location = ARGV[1]
data = []

text = File.open(file).read
text.gsub!(/\r\n?/, "\n")

text.each_line do |line|
  time = line.gsub(/\s+/m, ' ').strip.split(' ')
  split = time[1].split(':')[1]
  next unless split.to_s.casecmp('00').zero?

  timestamp = "#{time[0]}T#{time[1]}:00"
  data << { "timestamp": timestamp, "value": { "PM2.5": time[5] } }
end

n = { data: [] }
n.merge!(data: data)
json = n.to_json

puts 'Writing to file...'
saved = "#{save_location}/#{Time.new.strftime('%m-%d-%Y')}.json"
FileWriter.write(file: saved, msg: json)
puts 'Complete!'
