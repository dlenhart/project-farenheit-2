# frozen_string_literal: true

# FileReader - Read one wire file by given path
class FileReader
  attr_reader :file

  def initialize(file:)
    @file = file
  end

  def read_file
    File.open(file).to_a
  end

  def last_line
    read_file.last.strip
  rescue Errno::ENOENT => e
    warn "Unable to read file, exception: #{e}"
    exit(1)
  end

  def first_line
    read_file.first.strip
  end

  def split_last
    last_line.to_s.gsub(/\s+/m, ' ').strip.split(' ')
  end

  def check
    first_line.chars.last(3).join
  end

  def die(tries)
    puts "Unable to gather a temperature with #{tries} tries!"
    exit(1)
  end

  def raw_temp
    i = 0
    while check != 'YES'
      check
      i += 1
      puts "Having trouble reading w1 file .. #{i} - tries"
      sleep(0.4)
      break if i == 20
    end

    check != 'YES' ? die(i) : split_last.last.strip.split('=').last.to_i
  end

  def self.read(file:, method: :raw_temp)
    FileReader.new(file: file).send(method)
  end
end
