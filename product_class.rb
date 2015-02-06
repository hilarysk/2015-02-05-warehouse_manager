require_relative "module.rb"

# Class: Product
#
# Creates different products and gets information about them.
#
# Attributes:
# @name          - 
# @id            - 
# @quantity      - 
# @description   - 
# @serial_number - 
#
# attr_reader :id
#
# Public Methods:
# #insert
# #self.select_all_products
# #
# #update_product_name
# #update_quantity
# #move_self_between_locations -- instance method
# #select_all_products_for_location
# #update_serial_number
# #update_description
# #select_product
# #select_all_products
# #delete_product
# #return_category
# #return_location
# #
# Private Methods:
# #initialize

class Product
  include WarehouseManager
  # CREATE ACTIVE/INACTIVE AS A FIELD IN PRODUCTS, LOCATIONS, CATEGORIES? WOULD HAVE TO UPDATE SELF.ALL METHODS TO ONLY SHOW ACTIVE (AND ONLY SHOW INACTIVE) AS WELL AS INSERT AND SAVE. 
  
  attr_reader :id
  attr_writer :serial_num, :description, :quantity, :name
  
  def initialize(options)
    @name = options["name"]
    @quantity = options["quantity"]
    @description = options["description"]
    @serial_num = options["serial_num"]
    @id = options["id"]
  end
  
  
  # Public: .where_value_for_field_in_table_is ---> add to module (because mostly automated for different tables?)
  # Get a list of details from specific field with specific value for specific table
  # 
  # Parameters:
  # product-name - String: Name searching for
  #
  # Returns:
  # An array of Product objects
  
  
  
  
  
  def self.find(record_id)
  end
  
  def self.select_all_products
    DATABASE.execute("SELECT * FROM products")
  end
  
  #SAVES CHANGES TO ROW -- can use some of save method to more fully automate insert method
  def save
    attributes = []
  
    # Example  [:@name, :@age, :@hometown]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@") # "name"
    end
  
    query_components_array = []
  
    attributes.each do |a|
      value = self.send(a)
    
      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end
  end
  
  #CREATES NEW ROW
  def insert
    DATABASE.execute("INSERT INTO products (name, description, quantity, serial_num) VALUES ('#{@name}', '#{@description}', #{@quantity}, #{@serial_num})")
    @id = DATABASE.last_insert_row_id
  end
    
end