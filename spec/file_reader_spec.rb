# frozen_string_literal: true

require 'rspec'
require_relative '../app/file_reader'

RSpec.describe FileReader do
  it 'Opens the file into an array' do
    file = 'w1-slave-test-file'
    expect(FileReader.new(file: file).read_file.is_a?(Array)).to be true
  end

  it 'Reads the last line as a string' do
    expect = 'w1-slave-test-file'
    desired = 'a2 01 4b 46 7f ff 0e 10 d8 t=023345'
    expect(FileReader.new(file: expect).last_line).to eq(desired)
  end

  it 'Splits the last line in the file into an array' do
    file = 'w1-slave-test-file'
    expect(FileReader.new(file: file).split_last.is_a?(Array)).to be true
  end

  it 'Extracts the raw un-calculated temperature from the file' do
    expect = 'w1-slave-test-file'
    desired = '023345'.to_i
    expect(FileReader.new(file: expect).raw_temp).to eq(desired)
    expect(FileReader.read(file: expect)).to eq(desired)
  end
end
