# Module: WarehouseManagerCM
#
# Toolbox for use in our Warehouse Manager program; contains class methods that could work for Product, Category, or Location classes.
#
# Public Methods:
# #find_record_id
# #find
# #find_results_to_objects
# #exterminate
# #select_all
# #delete_secondary_kvpairs
# #delete_record
# #select_all_names_table
# #select_products_for_location
# #select_products_for_category
# #return_category
# #delete_secondary_kvpairs


module WarehouseManagerCM
  

  
  # Public: #select_all_names_table
  # Allows a person to find the names of all the items listed for a specific table.
  #
  # Parameters:
  # table - name of table being searched           
  #       
  #
  # Returns:
  # The products from the table that were requested
  #
  # State changes:
  # Sets the @name_array
  
  def select_all_names_table(table) 
    array = DATABASE.execute("SELECT name FROM #{table}")
    @name_array = []
    array.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.each do |key, value|
        @name_array << value
      end
    end
    
    return @name_array.join(", ")
  end
  
  
  
  # Public: #find_record_id
  # Allows a person to find the id for a specific row/rows
  #
  # Parameters:
  # options - Hash
  #           - field      - field: The column where the value in question resides
  #           - table      - table: The specific database table we're searching
  #           - value      - value: The value that identified the specific record/s             
  #       
  #
  # Returns:
  # The requested id/s
  #
  # State changes:
  # Sets @id_array and @record_id

  def find_record_id(options)
    table = options["table"]
    field = options["field"]
    value = options["value"]
    
    if value.is_a?(Integer)
      @id_array = DATABASE.execute("SELECT id FROM #{table} WHERE #{field} = #{value}")
    else
      @id_array = DATABASE.execute("SELECT id FROM #{table} WHERE #{field} = '#{value}'")
    end
    
    value_array = []
        
    if @id_array.length > 1
      delete_secondary_kvpairs(@id_array, :hashes)
        :hashes.each do |key, value|
          value_array << value
          @record_id = value_array
        end
    else
      @record_id = @id_array[0][0].to_s
    end

    return @record_id
  end 
  
  # Public: #select_products_for_location
  # Allows a person to find the products in a given location
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # A list of the products from that location
  #
  # State changes:
  # Sets @location_value_array
  
  def select_products_for_location(record_id)
    
    # if record_id == nil# if no option is included for record_id in hash
    #   record_id = @record_id
    # end
    array = DATABASE.execute("SELECT * FROM products WHERE location_id = #{record_id}")
    
    @location_value_array = []
    array.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.delete_if do |key, value|
        key.include?("i") || key.include?("t")
      end
      hash.each do |key, value|
        @location_value_array << value
      end
    end
    
    return @location_value_array.join(", ")
  end


  # Public: #select_products_for_category
  # Allows a person to find the products in a given category
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # A list of the products from that category
  #
  # State changes:
  # Sets @category_value_array

  def select_products_for_category(record_id)
    
    # if record_id == nil# if no option is included for record_id in hash
    #   record_id = @record_id
    # end
    array = DATABASE.execute("SELECT * FROM products WHERE category_id = #{record_id}")
    
    @category_value_array = []
    array.each do |hash|
      hash.delete_if do |key, value|
        key.is_a?(Integer)
      end
      hash.delete_if do |key, value|
        key.include?("i") || key.include?("t")
      end
      hash.each do |key, value|
        @category_value_array << value
      end
    end
    
    return @category_value_array.join(", ")
  end
  
  
  # Public: #locate_all_product_info
  # Pulls the name, description, cost, location and category for all products. 
  #
  # Parameters:
  # None            
  #       
  # Returns:
  # Formatted text containing the information.
  #
  # State changes:
  # Sets info1_array2
  
  def locate_all_product_info_location

    info1_array = DATABASE.execute("SELECT products.name, products.description, products.cost, locations.name FROM products 
                                    JOIN locations
                                    ON products.location_id = locations.id")
                      

    @info1_array2 = []

    info1_array.each do |hash|
        hash.delete_if do |key, value|
        key.is_a?(String)
      end
      hash.each do |key, value|
        case
        when key == 0
          @info1_array2 << ("ITEM: Name: " + value.to_s)
        when key == 1
          @info1_array2 << ("Description: " + value.to_s)
        when key == 2
          @info1_array2 << ("Cost: $" + sprintf("%.02f", (value * 0.01)).to_s)
        when key == 3
          @info1_array2 << ("Location: " + value.to_s)
        end
      end

    end

    return @info1_array2.join("; ")


    # info2_array = DATABASE.execute("SELECT categories.name FROM products JOIN categories
 #                                        ON products.category_id = categories.id")
 #
 #
 #
 #    @cat_values_array = []
 #
 #    info2_array.each do |hash|
 #      hash.delete_if do |key, value|
 #        key.is_a?(String)
 #      end
 #      hash.each do |key, value|
 #        @cat_values_array << value  # ==> ["board games", "90s-00s toys"]
 #      end
 #    end
 #
 #    # Category: #{@cat_value}"
  end
  

  #-----------------------------------------------------------------------------------------------------
  # Public: #return_category
  # Returns the category name for a specific product.
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # The category name
  #
  # State changes:
  # Sets @temp_cateory_id name and category_id

  def return_category(record_id=nil)
    
    if record_id == nil# if no option is included for record_id in hash 
      record_id = @record_id
    end
  
    category_id_array = DATABASE.execute("SELECT category_id FROM products WHERE id = #{record_id}") #==> [{"category_id"=>1, 0=>1}]

    delete_secondary_kvpairs(category_id_array, :placeholder)

    category_id_hash = category_id_array[0]

    category_id_hash.each do |x, y|
      @temp_category_id = y
    end

    category_name_array = DATABASE.execute("SELECT name FROM categories WHERE id = #{@temp_category_id}") #==> [{"name"=>"board games", 0=>"board games"}]
    delete_secondary_kvpairs(category_name_array, :placeholder)
    category_name_hash = category_name_array[0]

    category_name_hash.each do |x, y|
      @temp_category_name = y
      return @temp_category_name
    end
    

    return @temp_category_name
    
  end
  

  # Public: #return_location
  # Returns the location name for a specific product.
  #
  # Parameters:
  # record_id            
  #       
  #
  # Returns:
  # The category name
  #
  # State changes:
  # Sets @temp_location_id name and category_id
  
  def return_location(record_id=nil)
    
    if record_id == nil# if no option is included for record_id in hash 
      record_id = @record_id
    end
  
    location_id_array = DATABASE.execute("SELECT location_id FROM products WHERE id = #{record_id}") #==> [{"category_id"=>1, 0=>1}]

    delete_secondary_kvpairs(location_id_array, :placeholder)

    location_id_hash = location_id_array[0]

    location_id_hash.each do |x, y|
      @temp_location_id = y
    end

    location_name_array = DATABASE.execute("SELECT name FROM locations WHERE id = #{@temp_location_id}") #==> [{"name"=>"board games", 0=>"board games"}]
    delete_secondary_kvpairs(location_name_array, :placeholder)
    location_name_hash = location_name_array[0]

    location_name_hash.each do |x, y|
      @temp_location_name = y
      return @temp_location_name
    end

    return @temp_location_name
    
  end
  
  
  
  # Public: #select_all
  # Selects all data from specified table 
  #
  # Parameters:
  # options - hash
  #           - table - table you want information for (wouldn't work unless in options hash)
  #
  # Returns:
  # Array containing table information

  def select_all(options)
    table = options["table"]
    results = DATABASE.execute("SELECT * FROM #{table}")
    return delete_secondary_kvpairs(results, :placeholder) # delete_secondary_kvpairs(results)
  end
  
  # Public: #delete_secondary_kvpairs
  # Gets rid of the safeguard key-value pairs that SQLite auto includes where the key is an integer 
  #
  # Parameters:
  # array_name  - Name of array on which method is being run
  # placeholder - Placeholder text for loop             
  #
  # Returns:
  # The updated array (minus gratuitous key-value pairs)
  
  
  def delete_secondary_kvpairs(array_name, placeholder)    
    array_name.each do |placeholder|
      placeholder.delete_if do |key, value|
        key.is_a?(Integer)
      end
    end
    
    return array_name
    
  end

  # Public: #find
  # Pulls a specific row or rows given the row's ID (primary key) pulled from #find_record_id or provided by argument
  #
  # Parameters:
  # options - Hash
  #           - record_id - id: the id/s for the item/s in question
  #           - table      - table: The specific database table we're searching             
  #
  # Returns:
  # An array of hashes representing the records asked for
  # 
  # State changes:
  # Sets @better_results
 
  #need to update in case of multiple IDs
    
  def find(options)
    table = options["table"]
    record_id = options["record_id"] 
    
    if record_id == nil# if no option is included for record_id in hash 
    
      if @record_id.is_a?(Array)
        record_id = @record_id.join(" OR id = ")
        results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      else
        record_id = @record_id
        results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      end
      
      results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    
    else
      results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    end
    @better_results = delete_secondary_kvpairs(results, :hashes)
    
    return @better_results #returns an array
  end

  # Public: #find_results_to_objects
  # Transforms #find results into array of objects
  #
  # Parameters:
  # class_name - Name of class with which to instantiate new object/s     
  #
  # Returns:
  # Array of the object/s
  #
  # State changes:
  # Sets @object


  def find_results_to_objects(class_name)

     object_array = []

    if @better_results.length >= 2  # if [{"name"=>"fish", "cost"=>10000}, {"name"=>"dog", "cost"=>10000}]
      @better_results.each do |hash|
        object_array.push(class_name.new(hash))
        @object = object_array
      end
    else
      record_details = @better_results[0] # Hash of the row's details.
      @object = class_name.new(record_details) # Makes object
    end
    
    return @object
  end

  # Public: #delete_record
  # Deletes record (row) from specific table given specificed id number. We're making them enter id number so that they don't accidentally run it with value stored in @record_id
  #
  # Parameters:
  # options - hash
  #           - table: table where record resides   
  #           - record_id: id number for specific record
  #
  # Returns:
  # Empty array
  
  def delete_record(options)
    table = options["table"]
    record_id = options["record_id"] 
    
    DATABASE.execute("DELETE FROM #{table} WHERE id = #{record_id}")
  end
  
  # Public: #exterminate
  # Permanently deletes a table
  #
  # Parameters:
  # table - name of table to be deleted
  #             
  # Returns:
  # Nil
  
  def exterminate(table)
    DATABASE.execute("DROP TABLE #{table}") 
  end






end