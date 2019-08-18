# frozen_string_literal: true

require 'sqlite3'

# Database - execute sql statement - create DB & tables if does not exist.
class Database
  attr_accessor :database, :stmt

  def initialize(args)
    @database = args[:database]
    @stmt = args[:stmt]
  end

  def db_exec
    db = SQLite3::Database.open database
    Create.new.tables.each { |t| db.execute t.strip }
    db.execute stmt
  rescue SQLite3::Exception => e
    warn "Unable to write to database, exception: #{e}"
  ensure
    db&.close
  end

  def self.execute(database:, stmt:, method: :db_exec)
    Database.new(database: database, stmt: stmt).send(method)
  end
end

# Keep create table statements here for now..(array)
class Create
  def tables
    table_s = [
      "CREATE TABLE IF NOT EXISTS temperature(
      ID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATETIME,
      Celcius INT, Ferenheit INT)",
      "CREATE TABLE IF NOT EXISTS test(
      ID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATETIME)"
    ]
    table_s
  end
end
