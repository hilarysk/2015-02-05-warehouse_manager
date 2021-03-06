require_relative 'module.rb'
require_relative 'class_module.rb'


# Class: Category
#
# Creates different categories and gets information about them.
#
# Attributes:
# @name          - String: Name of category  
# @id            - Integer: Product ID, primary key for categories table
# @description   - String: Description of category
#
# attr_reader :id
# attr_accessor :description, :name, :product_id
#
# Public Methods:
# 
# Private Methods:
# #initialize

class Category
  include WarehouseManagerIM
  extend WarehouseManagerCM

  attr_reader :id
  attr_accessor :description, :name
  
  # Private: initialize
  # Starts and then plays the game with the provided players.
  #
  # Parameters:
  # options - Hash
  #           - @name        - Instance variable representing the cateogry name
  #           - @description - Instance variable representing the cateogry info 
  #           - @id          - Instance variable representing the cateogry ID within the table (primary key)
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