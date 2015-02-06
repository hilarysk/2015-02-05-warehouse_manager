# Class: Category
#
# Creates different categories and gets information about them.
#
# Attributes:
# @name          - 
# @id            - 
# @description   - 
#
# attr_reader :id
#
# Public Methods:
# #update_category
# #select_products_for_category
# #update_description
# #add_product_to_category
# #delete_category
# #
# #
# Private Methods:
# #save
# #initialize

class Category

  attr_reader :id

  def initialize(options)
    @name = options[:name]
    @description = options[:description]
    save_to_database
  end
  
  def select_all_categories
    DATABASE.execute("SELECT * FROM categories")
  end
  
  
  private
  
  def save_to_database
    DATABASE.execute("INSERT INTO categories (name, description) VALUES ('#{@name}', '#{@description}')")
  end
  
end