# frozen_string_literal: true

require './helpers/file_reader'
require './helpers/file_writer'
require './database/database'
require './temperature/temperature'

# e.x. '/sys/bus/w1/devices/28-0000075c0552/w1_slave'
file = '../w1-slave-test-file' # Update here
db = '../data/temperature_db.sqlite'

# each day gets its own file
time = Time.new.strftime('%m-%d-%Y %k:%M')
data = "../data/#{time.gsub(/\s+/m, ' ').strip.split(' ').first}.log"

puts ' '
puts '---STARTING-------------------------------------'
temp = FileReader.read(file: file)
f = Temperature.new.ferenheit(temp)
puts "Determining degree in Ferenheit...\n#{f}"

c = Temperature.new.celcius(temp)
puts "Determining degree in Celcius...\n#{c}"

puts 'recording to datafile'
msg = "#{time} : #{c} : #{f}\n"
FileWriter.write(file: data, msg: msg)

puts 'recording to database'
sql = "INSERT INTO temperature (Date, Celcius, Ferenheit) VALUES(
  '#{time}', '#{c}', '#{f}')"
Database.execute(database: db, stmt: sql)
puts "time: #{time}"
puts '---COMPLETE-------------------------------------'
