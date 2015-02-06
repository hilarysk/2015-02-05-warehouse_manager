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
  
  def initialize(options)
    @name = options[:name]
    @description = options[:description]
    save_to_database
  end
  
  def select_all_locations
    DATABASE.execute("SELECT * FROM locations")
  end
  
  
  private
  
  def save_to_database
    DATABASE.execute("INSERT INTO locations (name, description) VALUES ('#{@name}', '#{@description}')")
  end
  
  
  
end