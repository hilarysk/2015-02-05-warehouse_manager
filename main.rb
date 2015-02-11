# require "pry"
require "sinatra"
require_relative "driver.rb"
require 'sqlite3' 
require_relative 'module.rb'
require_relative 'class_module' 
require_relative 'product_class.rb' 
require_relative 'location_class.rb' 
require_relative 'category_class.rb'


DATABASE = SQLite3::Database.new("warehouse_manager.db")

DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
                                                     quantity INTEGER, cost INTEGER, description TEXT,
                                                     serial_num INTEGER UNIQUE, category_id INTEGER, location_id INTEGER, FOREIGN KEY(category_id) REFERENCES categories(id),
                                                     FOREIGN KEY(location_id) REFERENCES locations(id))")


get "/question_page" do
  erb :question_page
end

get "/add_prod" do
  # @category_names_ids = Category.return_all_category_names_ids
#   @location_names_ids = Location.return_all_location_names_ids

  @all_category_info_array = Category.return_array_of_cat_record_hashes
  @all_location_info_array = Location.return_array_of_loc_record_hashes

  erb :add_prod
end

get "/add_prod_success" do
  prod_name = params["name"]
  serial_num = params["serial_num"].to_i
  cost = (((params["cost"].delete("$")).to_f) * 100).to_i
  description = params["description"].delete("'")
  quantity = params["quantity"].to_i
  category_id = params["category_id"].to_i
  location_id = params["location_id"].to_i

  new_prod = Product.new({"name"=>"#{prod_name}", "quantity"=>quantity,
                "description"=>"#{description}", "serial_num"=>serial_num, "cost"=>cost,
                "category_id"=>category_id, "location_id"=>location_id})
  new_prod.insert

  new_prod_id = Product.find_record_id({"table"=>"products", "field"=>"name", "value"=>"#{prod_name}"})

  loc_name = Location.return_location_name(location_id)  #"location_id"=>
  cat_name = Category.return_category_name(category_id)

  new_prod_info = Product.find({"table"=>"products", "record_id"=>"#{new_prod_id}"})

  @all_new_prod_info = "#{new_prod_info}, Location: #{loc_name}, Category: #{cat_name}"

  erb :add_prod_success
end

get "/delete_prod" do
  erb :delete_prod
end

get "/update_prod" do
  erb :update_prod
end

get "/retrieve_prods_cat" do
  erb :retrieve_prods_cat
end

get "/retrieve_prods_loc" do
  erb :retrieve_prods_loc
end

get "/mon_val_prods" do
  erb :mon_val_prods
end

get "/new_loc" do
  erb :new_loc
end

get "/delete_loc" do
  erb :delete_loc
end

get "/update_loc" do
  erb :update_loc
end

get "/new_cat" do
  erb :new_cat
end

get "/delete_cat" do
  erb :delete_cat
end

get "/update_cat" do
  erb :update_cat
end



#
# binding.pry
