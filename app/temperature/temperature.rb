# frozen_string_literal: true

# Temperature - Calculate celcius, ferenheit, or kelvin
class Temperature
  attr_reader :temp

  def initialize(temp)
    @temp = temp
  end

  def celcius
    c = temp / 1000.0
    c.to_f
  end

  def ferenheit
    f = celcius * 9.0 / 5.0 + 32.0
    f.to_f
  end

  def kelvin
    k = celcius + 273.15
    k.to_f
  end

  def newton
    n = celcius * 33.0 / 100
    n.to_f
  end
end
