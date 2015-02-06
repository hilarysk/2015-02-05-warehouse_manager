require_relative "module.rb"

# Class: Product
#
# Creates different products and gets information about them.
#
# Attributes:
# @name          - String: Name of product
# @id            - Integer: Product ID, primary key for products table
# @quantity      - Integer: Number of products in inventory
# @description   - String: Description of product (duh)
# @serial_number - Integer: Unique identifier for particular product
#
# attr_reader :id
# attr_accessor :serial_num, :description, :quantity, :name
#
# Public Methods:
# #move_self_between_locations -- instance method
# #select_all_products_for_location
# #delete_product
# #return_category
# #return_location
# 
# Private Methods:
# #initialize

class Product
  include WarehouseManager

  
  attr_reader :id
  attr_accessor :serial_num, :description, :quantity, :name

  # Private: initialize
  # Starts and then plays the game with the provided players.
  #
  # Parameters:
  # options - Hash
  #           - @name        - Instance variable representing the product name
  #           - @quantity    - Instance variable representing the product amount
  #           - @description - Instance variable representing the product info 
  #           - @serial_num  - Instance variable representing the product serial number
  #           - @id          - Instance variable representing the product ID within the table (primary key)
  #
  # Returns:
  # Nil
  #
  # State Changes:
  # Sets instance variables @name, @quantity, @description, @serial_num, @id     
                               
  def initialize(options)
    @name = options["name"]
    @quantity = options["quantity"]
    @description = options["description"]
    @serial_num = options["serial_num"]
    @id = options["id"]
  end
  

    
end