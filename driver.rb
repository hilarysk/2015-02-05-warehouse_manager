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
                                                       quantity INTEGER, description TEXT,
                                                       serial_num INTEGER, category_id INTEGER, location_id INTEGER, FOREIGN KEY(category_id) REFERENCES categories(id),
                                                       FOREIGN KEY(location_id) REFERENCES locations(id))")
                                                       
              
              
                                                       # DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
#                                                                                                               quantity INTEGER CHECK(quantity >= 0), description TEXT DEFAULT(null),
#                                                                                                               serial_num INTEGER CHECK(serial_num >= 0), category_id INTEGER, location_id INTEGER, FOREIGN KEY(category_id) REFERENCES categories(id),
#                                                                                                               FOREIGN KEY(location_id) REFERENCES locations(id))")
#
                                      

# lollipop = Product.new({name: "Lollipop", quantity: 532, description: "You can suck it.", serial_num: 145})
# your_moms_basement = Location.new({name: "Your Moms Basement", description: "Full of rats"})
# new_category = Category.new({name: "breakfast", description: "food to rot your stomach lining"})


binding.pry