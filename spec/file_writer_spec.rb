# frozen_string_literal: true

require 'rspec'
require_relative '../app/helpers/file_writer'

RSpec.describe FileWriter do
  it 'Successfuly writes to a file' do
    file = 'temp_file.log'
    msg = 'success'
    FileWriter.write(file: file, msg: msg)
    sleep(1)
    read = File.open(file).first.strip
    expect(read).to eq(msg)
    File.delete(file) if File.exist?(file) # clean up
  end
end
