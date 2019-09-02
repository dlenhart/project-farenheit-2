# frozen_string_literal: true

module Parser_helper
  def self.fix_date(date)
    d = date.split('-')
    "#{d[2]}-#{d[0]}-#{d[1]}"
  end

  def self.time_parse(line)
    line.gsub(/\s+/m, ' ').strip.split(' ')
  end

  def self.split_time(time)
    time[1].split(':')[1]
  end

  def self.convert_to_json(data)
    hash = { data: [] }
    hash.merge!(data: data)
    hash.to_json
  end
end
