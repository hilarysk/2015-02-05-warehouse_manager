# require 'pry'
require 'sqlite3' 
require_relative 'module.rb'
require_relative 'class_module' 
require_relative 'product_class.rb' 
require_relative 'location_class.rb' 
require_relative 'category_class.rb'


class Driver
  
  def launch
    
    #-----This is our script----#
    puts "Hello, What would you like to do today?"
    puts "Press 1 for: Add or delete a product, or update its information (including category and location)"
    puts "Press 2 for: Retrieve product information"
    puts "Press 3 for: Add / update / delete a location"
    puts "Press 4 for: Retrieve all products in a given category"
    puts "Press 5 for: Retrieve all products in a given location"
    puts "Press 6 for: View monetary value of set group of products"



    answer = gets.chomp.to_i 

    until answer >= 1 && answer <= 6
      puts "Sorry, that's not an option, please try again."
      puts "Press 1 for: Add or delete a product, or update its information (including category and location)"
      puts "Press 2 for: Retrieve product information"
      puts "Press 3 for: Add / update / delete locations"
      puts "Press 4 for: Retrieve all products in a given category"
      puts "Press 5 for: Retrieve all products in a given location"

      answer = gets.chomp.to_i.ceil
    end

    if answer == 1
  
      puts "Press 1 to ADD a product"
      puts "Press 2 to UPDATE a product"
      puts "Press 3 to DELETE a product"
      answer2 = gets.chomp.to_i.ceil
      until answer2 >= 1 && answer2 <= 3
        puts "Sorry that's not an option, please try again."
        puts "Press 1 to ADD a product"
        puts "Press 2 to UPDATE a product"
        puts "Press 3 to DELETE a product"
        answer2 = gets.chomp.to_i.ceil
      end
       
        if answer2 == 1
            puts "Let's add a product!"
            puts "Please enter name of product:"
            name = gets.chomp
            puts "How many do you want to add to inventory?"
            quantity = gets.chomp.to_i
            puts "Please enter a description of the product (no more than 1 or 2 short sentences):"
            description = gets.chomp
            puts "Please enter a serial number:"
            serial_num = gets.chomp.to_i
            puts "Please enter the product\'s price (without any currency symbols (numbers only!)):"
            cost = (gets.chomp.to_i * 100)
            puts "Which category should this go under?"
            puts "Please 1 for board games or 2 for toys"
            category_id = gets.chomp.to_i.ceil
            until category_id == 1 || category_id == 2
              puts "Sorry, that's not an option, please try again."
              puts "Please 1 for board games or 2 for toys"
              category_id = gets.chomp.to_i.ceil
            end
            puts "Please enter the location name (i.e. Room 1, Room 2)"
            location = gets.chomp
            location_id = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{location}"})
    
            a = Product.new({"name"=>"#{name}", "quantity"=>quantity, 
                "description"=>"#{description}", "serial_num"=>serial_num, "cost"=>cost, 
                "category_id"=>category_id, "location_id"=>location_id}) 
            a.insert   
            puts "Product has been added! Goodbye!"

          elsif answer2 == 2
            puts "What is the serial number of the product you would like to update?"
            serial_num1 = gets.chomp.to_i
            b = Product.find_record_id({"table"=>"products", "field"=>"serial_num", "value"=>serial_num1})
            puts "What do you want to change the name to?"
            name1 = gets.chomp
            puts "What do you want to change the description to?"
            description1 = gets.chomp
            puts "What do you want to change the quantity to?"
            quantity1 = gets.chomp.to_i
            puts "What do you want to change the cost to?"
            cost1 = gets.chomp.to_i
            puts "What category name do you want to change it to?"
            category_name = gets.chomp
            category_id1 = Category.find_record_id({"table"=>"categories", "field"=>"name", "value"=>"#{category_name}"})
            puts "What location do you want to change it to?"
            location_name = gets.chomp
            location_id1 = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{location_name}"})
            c = Product.new({"name"=>"#{name1}", "quantity"=>quantity1, 
                "description"=>"#{description1}", "serial_num"=>serial_num1, "cost"=>cost1, 
                "category_id"=>category_id1, "location_id"=>location_id1}) 
            c.save({"table"=>"products", "item_id"=>b})  
            puts "Product has been updated! Goodbye!"
    
          elsif answer2 == 3
            puts "What is the serial number of the product you would like to delete?"
            serial_num2 = gets.chomp.to_i
            d = Product.find_record_id({"table"=>"products", "field"=>"serial_num", "value"=>serial_num2})
            Product.delete_record({"table"=>"products", "record_id"=>d})
            puts "In the words of the Daleks, your product has been EXTERMINATED. Goodbye!"    
          end

    elsif answer == 2
      puts "Let's find product information:"
      puts "What is the serial number of the product you would like to find?"
      serial_num3 = gets.chomp.to_i
      d = Product.find_record_id({"table"=>"products", "field"=>"serial_num", "value"=>serial_num3})
      g = Category.return_category_id(d)
      h = Category.return_category_name(g)
      i = Location.return_location_id(d)
      j = Location.return_location_name(i)
      puts Product.find({"table"=>"products", "record_id"=>d}) + " Category: #{h}" + " Location: #{j}"

    elsif answer == 3
      puts "What do you want to do with your location?"
      puts "Press 1 to ADD a location"
      puts "Press 2 to UPDATE a location"
      puts "Press 3 to DELETE a location"
      location1 = gets.chomp.to_i
      until location1 >= 1  && location1 <= 3
        puts "Sorry, that's not an option, try again."
        puts "Press 1 to ADD a location"
        puts "Press 2 to UPDATE a location"
        puts "Press 3 to DELETE a location"
      end
      if location1 == 1
        puts "Let's add a location!"
        puts "Please enter name of location:"
        name2 = gets.chomp
        puts "Please enter a description of the location (no more than 1 or 2 short sentences):"
        description2 = gets.chomp    
        k = Location.new({"name"=>"#{name2}", "description"=>"#{description2}"}) 
        k.insert   
        puts "Location has been added! Goodbye!"
     
      elsif location1 == 2
        puts "Let's update a location!"
        puts Location.return_all_location_names
        puts "What is the name of the location you would like to update?"
        location3 = gets.chomp
        l = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{location3}"})
        puts "What do you want to change the name to?"
        name4 = gets.chomp
        puts "What do you want to change the description to?"
        description4 = gets.chomp
        m = Location.new({"name"=>"#{name4}", "description"=>"#{description4}"}) 
        m.save({"table"=>"locations", "item_id"=>l})  
        puts "Location has been updated! Goodbye!"
     
      elsif location1 == 3
        puts Location.return_all_location_names
        puts "What is the name of the location you would like to remove?"
        location5 = gets.chomp
        n = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>"#{location5}"})
        Location.delete_record({"table"=>"locations", "record_id"=>n})
        puts "In the words of the Daleks, #{location5} has been EXTERMINATED. Goodbye!" 
      end
  
    elsif answer == 4
      puts "Let's find some products!"
      puts "What is the category name for which you would like to view all products?"
      category_name3 = gets.chomp
      e = Category.find_record_id({"table"=>"categories", "field"=>"name", "value"=>category_name3})
      puts "#{category_name3} includes: " + Product.select_products_for_category(e)
      puts "Goodbye!"

    elsif answer == 5
      puts "Let's find some products!"
      puts "What is the location name for which you would like to view all products?"
      location_name3 = gets.chomp
      f = Location.find_record_id({"table"=>"locations", "field"=>"name", "value"=>location_name3})
      puts "#{location_name3} contains: " + Product.select_products_for_location(f) 
      puts "Goodbye!"
  
    elsif answer == 6
      puts "For which grouping of products would you like to view the value?"
      puts "Press 1 for ALL products"
      puts "Press 2 for products from a specific LOCATION"
      puts "Press 3 for products from a specific CATEGORY"
      product_option = gets.chomp.to_i
      until product_option >= 1  && product_option <= 3
        puts "Sorry, that's not an option, try again."
        puts "Press 1 for ALL products"
        puts "Press 2 for products from a specific LOCATION"
        puts "Press 3 for products from a specific CATEGORY"
      end
  
        if product_option == 1
          puts Product.select_all_value_products
        
        elsif product_option == 2
    
        elsif product_option == 3
        
        end
    end
  end
end




















# binding.pry
