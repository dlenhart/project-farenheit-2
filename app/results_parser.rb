# frozen_string_literal: true

# This script will parse the datafile to a readable json file for the D3 js chart.
# Parsing Ferenheit from file. Since temperature is polled every minute - extract
# the hourly runs.

require 'pry'

puts 'parsing file....'
f = 'temperatures.log'

line_num = 0
text = File.open(f).read
text.gsub!(/\r\n?/, "\n")

text.each_line do |line|
  time = line.gsub(/\s+/m, ' ').strip.split(' ')
  split = time[1].split(':')[1]

  if split.to_s.casecmp("00").zero?
    puts line
    extracted = "hi" # left off here....
    #merge into hash
  end
end
