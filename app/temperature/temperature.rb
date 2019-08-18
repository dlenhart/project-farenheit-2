# frozen_string_literal: true

# Temperature - Calculate celcius or ferenheit
class Temperature
  def celcius(temp)
    c = temp / 1000.0
    c.to_f
  end

  def ferenheit(temp = nil)
    f = celcius(temp) * 9.0 / 5.0 + 32.0
    f.to_f
  end
end
