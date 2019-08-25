# frozen_string_literal: true

puts 'Reading file'
f = 'temperatures.log'

line_num = 0
text = File.open(f).read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  puts "#{line_num += 1} #{line}"
end
