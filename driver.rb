require 'pry'
require 'sqlite3'
require_relative 'module.rb'
require_relative 'product_class.rb'
require_relative 'location_class.rb'
require_relative 'category_class.rb'




DATABASE = SQLite3::Database.new("warehouse_manager.db")

DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
                                                       quantity INTEGER, cost INTEGER, description TEXT,
                                                       serial_num INTEGER, category_id INTEGER, location_id INTEGER, FOREIGN KEY(category_id) REFERENCES categories(id),
                                                       FOREIGN KEY(location_id) REFERENCES locations(id))")
                                                       
# ----------------------------------------------------------------------------------------------

# ^ ALL THIS WORKS BEAUTIFULLY. HERE'S STUFF WE'D LIKE TO ADD ONCE WE HAVE EVERYTHING REQUIRED WORKING PROPERLY:

# 1. CREATE ACTIVE/INACTIVE AS A FIELD IN PRODUCTS, LOCATIONS, CATEGORIES? WOULD HAVE TO UPDATE SELF.ALL METHODS TO ONLY SHOW ACTIVE 
# (AND ONLY SHOW INACTIVE) AS WELL AS INSERT AND SAVE. 
               
# 
# 2.           --------Maybe something like this can replace the one above?-----------------
#
# DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
# quantity INTEGER CHECK(quantity >= 0), description TEXT DEFAULT(null),
# serial_num INTEGER CHECK(serial_num >= 0), category_id INTEGER, location_id INTEGER,
# FOREIGN KEY(category_id) REFERENCES categories(id), FOREIGN KEY(location_id) REFERENCES locations(id))")


# ----------------------------------------------------------------------------------------------


# Be able to view the entire value of my product inventory, perhaps broken down by location or by category if the user so desires.

# Be able to look at my products, ordered from most numerous to least numerous. This could also be further broken down by category or by location, if the user so desired.

# ---> Add a "Shopping Cart" feature where you add products to a shopping cart and where it adds up the total cost. Upon purchasing the cart, update each of the relevant product quantities accordingly. (new table?)

# Depending on the category, products might have different relevant information (for example: a book might have an author, but a death ray would not). Given the categories you've created so far, create templates for this relevant information. Use the templates to track additional information. Don't worry about letting the user create templates from scratch; you can hard-code those.

# Add in the ability to search for products whose description contains the search word (in this case, your search query should be a single word long).


# Come up with your own extension and make it happen.





binding.pry