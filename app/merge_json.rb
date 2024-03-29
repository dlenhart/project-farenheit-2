# frozen_string_literal: true

# This script will merge multiple JSON files into one
# e.x.  ruby merge_json.rb "folder location" "output location"

require 'find'
require './helpers/file_writer'
require './helpers/json_validator'
require './helpers/parsing'

puts '---STARTING------------------------------------'

if ARGV.length != 2
  puts 'Expecting TWO arguments (folder, and save location)!!'
  exit
end

data = []

Find.find(ARGV[0]) do |f|
  next if File.extname(f) != '.json'

  file = File.read(f)
  (data << JSON.parse(file)['data']).flatten!
end

json = Parser_helper.convert_to_json(data)

if JSONValidator.valid_json?(json)
  saved = "#{ARGV[1]}/latest-merged.json"
  puts "json is valid, writing to file...#{saved}"
  FileWriter.write(file: saved, msg: json)
else
  puts 'There appears to be an issue with the json!'
end

puts '---COMPLETE------------------------------------'
