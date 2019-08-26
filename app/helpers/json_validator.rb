# frozen_string_literal: true

# Validates JSON
class JSONValidator
  def self.valid_json?(json)
    JSON.parse(json)
    true
  rescue JSON::ParserError, TypeError
    false
  end
end
