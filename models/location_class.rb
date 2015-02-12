require_relative 'module.rb'
require_relative 'class_module.rb'

# Class: Location
#
# Creates different locations and gets information about them.
#
# Attributes:
# @name          - String: Name of location  
# @id            - Integer: Product ID, primary key for locations table
# @description   - String: Description of location
#
# attr_reader :id
# attr_accessor :description, :name, :product_id
#
# Public Methods:
# 
# Private Methods:
# #initialize

class Location
  include WarehouseManagerIM
  extend WarehouseManagerCM
  
  attr_reader :id
  attr_accessor :description, :name
  
  # Private: initialize
  # Starts and then plays the game with the provided players.
  #
  # Parameters:
  # options - Hash
  #           - @name        - Instance variable representing the location name
  #           - @description - Instance variable representing the location info 
  #           - @id          - Instance variable representing the location ID within the table (primary key)
  #
  # Returns:
  # Nil
  #
  # State Changes:
  # Sets instance variables @name, @description, @id     
                               
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @description = options["description"]
  end

  
  
end