# frozen_string_literal: true

require 'rspec'
require_relative '../../app/temperature/temperature'

RSpec.describe Temperature do
  it 'Calculate celcius' do
    raw_temp = '023345'.to_i
    desired = 23.345
    expect(Temperature.new(raw_temp).celcius).to eq(desired)
  end

  it 'Calculate ferenheit' do
    raw_temp = '023345'.to_i
    desired = 74.021
    expect(Temperature.new(raw_temp).ferenheit).to eq(desired)
  end
end
