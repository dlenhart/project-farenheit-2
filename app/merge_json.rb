# frozen_string_literal: true

# This script will merge multiple JSON files into one
# e.x.  ruby merge_json.rb "folder location" "output location"

require 'pry'
require 'Find'
require './helpers/file_writer'
require './helpers/json_validator'

puts '---STARTING------------------------------------'

if ARGV.length != 2
  puts 'Expecting TWO arguments (folder, and save location)!!'
  exit
end

data = []

Find.find(ARGV[0]) do |f|
   next if File.extname(f) != ".json"
   file = File.read(f)
   (data << JSON.parse(file)['data']).flatten!
end

n = { data: [] }
n.merge!(data: data)
json = n.to_json

if JSONValidator.valid_json?(json)
  saved = "yest2.json"
  puts "json is valid, writing to file...#{saved}"
  FileWriter.write(file: saved, msg: json)
else
  puts 'There appears to be an issue with the json!'
end

puts '---COMPLETE------------------------------------'
