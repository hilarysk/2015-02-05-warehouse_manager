require_relative 'module.rb'


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
# attr_accessor :description, :name
#
# Public Methods:
# #self.select_all_categories
# #select_products_for_category
# #add_product_to_category
# #delete_category
# 
# Private Methods:
# #initialize

class Category

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
    @name = options["name"]
    @description = options["description"]
  end
  
end