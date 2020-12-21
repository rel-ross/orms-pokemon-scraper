
require_relative "../bin/environment.rb"
require_relative "../bin/sql_runner.rb"
require_relative "scraper.rb"
require 'pry'
class Pokemon
    attr_accessor :name, :type, :db, :id
    
    
    def initialize id: nil, name:, type:, db: 
        @id=id
        @name=name
        @type=type
        @db=db

    end
    def self.save name, type, db
        sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES
        (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find id, db
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL

        db.execute(sql, id).map do |row|
            Pokemon.new(id: row[0], name: row[1], type: row[2], db: row[3])
        end.first
    end

end
