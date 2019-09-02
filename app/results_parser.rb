# frozen_string_literal: true

# This script will parse the datafile to a readable json file for the
# D3 JS chart.
# Parsing Ferenheit from file. Since temperature is polled every minute
# - extract the hourly runs. http://bl.ocks.org/oyyd/859fafc8122977a3afd6

# usage: ruby results_parser.rb "temperatures.log" "/Users/drewlenhart/Desktop/"

require 'pry'
require './helpers/file_writer'
require './helpers/json_validator'

def fix_date(date)
  d = date.split('-')
  new = "#{d[2]}-#{d[0]}-#{d[1]}"
  new
end

def time_parse(line)
  line.gsub(/\s+/m, ' ').strip.split(' ')
end

def split_time(time)
  time[1].split(':')[1]
end

def convert_to_json(data)
  n = { data: [] }
  n.merge!(data: data)
  n.to_json
end

puts '---STARTING------------------------------------'

if ARGV.length != 2
  puts 'Expecting TWO arguments (file location, and save location)!!'
  exit
end

data = []

text = File.open(ARGV[0]).read
text.gsub!(/\r\n?/, "\n")

text.each_line do |line|
  time = time_parse(line)
  split = split_time(time)
  next unless split.to_s.casecmp('00').zero?

  data << { "timestamp": "#{fix_date(time[0])}T#{time[1]}:00",
    "value": { "PM2.5": time[5] } }
end

json = convert_to_json(data)

if JSONValidator.valid_json?(json)
  saved = "#{ARGV[1]}/#{ARGV[0].split('/').last.split('.')[0]}.json"
  puts "JSON is valid, saving to file...#{saved}"
  FileWriter.write(file: saved, msg: json)
else
  puts 'JSON is not valid!'
end

puts '---COMPLETE------------------------------------'
