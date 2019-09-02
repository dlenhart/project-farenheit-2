# frozen_string_literal: true

module Parser_helper
  def Parser_helper.fix_date(date)
    d = date.split('-')
    d = "#{d[2]}-#{d[0]}-#{d[1]}"
    d
  end

  def Parser_helper.time_parse(line)
    line.gsub(/\s+/m, ' ').strip.split(' ')
  end

  def Parser_helper.split_time(time)
    time[1].split(':')[1]
  end

  def Parser_helper.convert_to_json(data)
    hash = { data: [] }
    hash.merge!(data: data)
    hash.to_json
  end
end
