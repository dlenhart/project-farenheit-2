# frozen_string_literal: true

require './file_reader'
require './file_writer'
require './database/database'
require './temperature/temperature'

# update file locations here
file = '../w1-slave-test-file'
data = '../data/temperatures.log'
db = '../data/temperature_db.sqlite'

time = Time.new.strftime('%m-%d-%Y %k:%M')

puts ' '
puts '---STARTING--------------------------------------'
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
