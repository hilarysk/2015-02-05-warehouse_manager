

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
# #save_to_database
# #initialize

class Product
  
  attr_reader :id, :serial_num
  
  def initialize(options)
    @name = options[:name]
    @quantity = options[:quantity]
    @description = options[:description]
    @serial_num = options[:serial_num]
    save_to_database
  end
  

  
  def select_all_products
    DATABASE.execute("SELECT * FROM products")
  end
  
  private
  
  def save_to_database
    DATABASE.execute("INSERT INTO products (name, serial_num, quantity, description) VALUES ('#{@name}', #{@serial_num}, #{@quantity}, '#{@description}')")
  end
    
end