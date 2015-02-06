require_relative 'module.rb'


# Class: Location
#
# Creates different locations and gets information about them.
#
# Attributes:
# @name          - 
# @id            - 
# @description   - 
#
# attr_reader :id
#
# Public Methods:
# #insert
# #self.select_all_locations
# #
# #update_location
# #update_name
# #update_description
# #delete_location
# #
# #
# Private Methods:
# #save
# #initialize

class Location
  
  attr_reader :id
  attr_accessor :description, :name
  
  def initialize(options)
    @name = options["name"]
    @description = options["description"]
    @id = options["id"]
  end
  
  def self.select_all_locations
    DATABASE.execute("SELECT * FROM locations")
  end
  
  #SAVES CHANGES TO ROW -- can use some of save method to more fully automate insert method
  def save
  end
  
  #CREATES NEW ROW
  def insert
    DATABASE.execute("INSERT INTO locations (name, description) VALUES ('#{@name}', '#{@description}')")
    @id = DATABASE.last_insert_row_id
  end
  
  
  
end