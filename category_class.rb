require_relative 'module.rb'


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
# #insert
# #self.select_all_categories
# #
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
  attr_accessor :description, :name

  def initialize(options)
    @name = options["name"]
    @description = options["description"]
  end
  
  def self.select_all_categories
    DATABASE.execute("SELECT * FROM categories")
  end
  
  #SAVES CHANGES TO ROW -- can use some of save method to more fully automate insert method
  def save
  end
  
  #CREATES NEW ROW
  def insert
    DATABASE.execute("INSERT INTO categories (name, description) VALUES ('#{@name}', '#{@description}')")
    @id = DATABASE.last_insert_row_id
  end
  
end