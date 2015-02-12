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
#   @location_names_ids = Location.return_all_location_names_ids

  @all_category_info_array = Category.return_array_of_cat_record_hashes
  @all_location_info_array = Location.return_array_of_loc_record_hashes

  erb :add_prod
end # works

before "/add_prod_success" do
  product_names = Product.return_all_product_names_unformatted
  product_names.each do |x|
   if x == params["name"]
     redirect to ("/add_prod_fail_name")
   end
 end
 
 product_serial_nums = Product.return_all_product_serial_nums_unformatted
 product_serial_nums.each do |x|
  if x == params["serial_num"]
    redirect to ("/add_prod_fail_serial_num")
  end
 end
end # works

get "/add_prod_success" do
  prod_name = params["name"].delete("'")
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
end #works

get "/add_prod_fail_serial_num" do
  erb :add_prod_fail_serial_num
end 

get "/add_prod_fail_name" do
  erb :add_prod_fail_name
end

get "/delete_prod" do
  @all_products_info_array = Product.return_array_of_prod_record_hashes
  erb :delete_prod
end # works 

get "/delete_prod_success" do
  prod_id = params["product_id"]
  
  location_id = Product.return_location_id(prod_id)
  category_id = Product.return_category_id(prod_id)

  loc_name = Location.return_location_name(location_id)  #"location_id"=>
  cat_name = Category.return_category_name(category_id)

  deleted_prod_info = Product.find({"table"=>"products", "record_id"=>prod_id})

  @all_deleted_prod_info = "#{deleted_prod_info}, Location: #{loc_name}, Category: #{cat_name}"
  
  Product.delete_record({"table"=>"products", "record_id"=>prod_id})
  
  @all_product_info_array = Product.return_array_of_prod_record_hashes
  
  erb :delete_prod_success
end # works 

get "/update_prod" do
  @all_products_info_array = Product.return_array_of_prod_record_hashes
  erb :update_prod
end

get "/update_prod_choice" do
  prod_id = params["product_id"]
  
  @all_category_info_array = Category.return_array_of_cat_record_hashes
  @all_location_info_array = Location.return_array_of_loc_record_hashes
  
  prod = Product.find({"table"=>"products", "record_id"=>prod_id})
  @prod = "#{prod}"
  
  prod_attribute_hash = Product.get_product_info_hash(prod_id)
  
  prod_object = Product.new(prod_attribute_hash)
  
  @name = prod.name
  @description = prod.description
  @quantity = prod.quantity
  @serial_num = prod.serial_num
  @cost = prod.cost
  @id = prod.id
  
  erb :update_prod_choice
end

get "/update_prod_changes" do
  prod_name = params["name"].to_s
  prod_description = params["description"].to_s
  prod_serial_num = params["serial_num"].to_i
  prod_id = params["id"].to_i
  prod_cost = params["cost"].to_i
  prod_quantity = params["quantity"].to_i
  prod_location_id = params["location_id"].to_i
  prod_category_id = params["category_id"].to_i
  
  a = Product.new({"name"=>"#{prod_name}", "description"=>"#{prod_description}", "serial_num"=>prod_serial_num,
                  "cost"=>prod_cost, "quantity"=>prod_quantity, "category_id"=>prod_category_id, "location_id"=>prod_location_id})
  a.save({"table"=>"products", "item_id"=>prod_id})
  
  updated_prod = Product.find({"table"=>"products", "record_id"=>prod_id}) 
  @updated_prod = "#{updated_prod}"
  erb :update_prod_changes     
end     

get "/retrieve_prods_cat" do # not done
  erb :retrieve_prods_cat
end

get "/retrieve_prods_loc" do # not done
  erb :retrieve_prods_loc
end

get "/mon_val_prods" do
  erb :mon_val_prods
end

get "/mon_val_cat" do
  @all_category_info_array = Category.return_array_of_cat_record_hashes
  erb :mon_val_cat
end

get "/mon_val_cat_success" do
  val_cat = params["category_id"]
  value = Product.select_value_products_table("category_id", val_cat)
  category_name = Category.return_category_name(val_cat)
  @category_name = "#{category_name}"
  @value = "#{value}"
  erb :mon_val_cat_success
end

get "/mon_val_loc" do
  @all_location_info_array = Location.return_array_of_loc_record_hashes
  erb :mon_val_loc
end # works

get "/mon_val_loc_success" do
  val_loc = params["location_id"]
  
  value = Product.select_value_products_table("location_id", val_loc)
  location_name = Location.return_category_name(val_loc)
  @location_name = "#{location_name}"
  @value = "#{value}"
  erb :mon_val_loc_success
end #works

get "/mon_val_all" do
  value = Product.select_all_value_products
  @value = "#{value}"
  erb :mon_val_all
end #works

before "/new_loc_success" do
  location_names = Location.return_all_location_names_unformatted
  location_names.each do |x|
   if x == params["name"]
     redirect to ("/new_loc_fail")
   end
 end
end

get "/new_loc_success" do
  
  loc_name = params["name"].delete("'")
  loc_description = params["description"].delete("'")
  
  new_loc = Location.new({"name"=>"#{loc_name}", "description"=>"#{loc_description}"})
  new_loc.insert({"table"=>"locations", "name"=>"#{loc_name}", "description"=>"#{loc_description}"})

  new_loc_id = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{loc_name}"})

  new_loc_info = Location.find_cat_or_loc({"table"=>"locations", "record_id"=>"#{new_loc_id}"})

  @all_new_loc_info = "#{new_loc_info}"

  erb :new_loc_success
end

get "/new_loc" do
  @location_names = Location.return_all_location_names
  erb :new_loc
end

get "/new_loc_fail" do
  erb :new_loc_fail
end

get "/delete_loc" do
  @all_location_info_array = Location.return_array_of_loc_record_hashes
  erb :delete_loc
end

get "/delete_loc_success" do
  loc_id = params["location_id"]
  deleted_loc_info = Location.find_cat_or_loc({"table"=>"locations", "record_id"=>loc_id})
  
  @all_deleted_loc_info = "#{deleted_loc_info}"
  
  Location.delete_record({"table"=>"locations", "record_id"=>loc_id})
  
  @all_location_info_array = Location.return_array_of_loc_record_hashes
  
  erb :delete_loc_success
end

get "/update_loc" do #not done
  erb :update_loc
end

get "/new_cat" do
  @category_names = Category.return_all_category_names
  erb :new_cat
end

before "/new_cat_success" do
  category_names = Category.return_all_category_names_unformatted
  category_names.each do |x|
   if x == params["name"]
     redirect to ("/new_cat_fail")
   end
 end
end

get "/new_cat_success" do
  cat_name = params["name"].delete("'")
  cat_description = params["description"].delete("'")
  
  new_cat = Category.new({"name"=>"#{cat_name}", "description"=>"#{cat_description}"})
  new_cat.insert({"table"=>"categories", "name"=>"#{cat_name}", "description"=>"#{cat_description}"})

  new_cat_id = Category.find_record_id({"table"=>"categories", "field"=>"name", "value"=>"#{cat_name}"})

  new_cat_info = Category.find_cat_or_loc({"table"=>"categories", "record_id"=>"#{new_cat_id}"})

  @all_new_cat_info = "#{new_cat_info}"
  
  erb :new_cat_success
end

get "/new_cat_fail" do
  erb :new_cat_fail
end

get "/delete_cat" do
  @all_category_info_array = Category.return_array_of_cat_record_hashes
  erb :delete_cat
end

get "/delete_cat_success" do
  cat_id = params["category_id"]
  deleted_cat_info = Category.find_cat_or_loc({"table"=>"categories", "record_id"=>cat_id})
  
  @all_deleted_cat_info = "#{deleted_cat_info}"
  
  
  Category.delete_record({"table"=>"categories", "record_id"=>cat_id})
  
  @all_category_info_array = Category.return_array_of_cat_record_hashes
  
  erb :delete_cat_success
end

get "/update_cat" do # not done
  erb :update_cat
end



#
# binding.pry
