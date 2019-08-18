# frozen_string_literal: true

# FileWriter - write data to data file
class FileWriter
  attr_reader :file, :msg

  def initialize(file:, msg:)
    @file = file
    @msg = msg
  end

  def record
    File.write(file, msg, mode: 'a')
  rescue Errno::ENOENT => e
    warn "Unable to write file, exception: #{e}"
    exit(1)
  end

  def self.write(file:, msg:, method: :record)
    FileWriter.new(file: file, msg: msg).send(method)
  end
end
