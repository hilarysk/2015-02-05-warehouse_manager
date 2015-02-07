# Module: WarehouseManagerCM
#
# Toolbox for use in our Warehouse Manager program; contains class methods that could work for Product, Category, or Location classes.
#
# Public Methods:
# #find_record_id
# #find
# #exterminate
# #select_all
# #delete_secondary_kvpairs
# #delete_record


module WarehouseManagerCM  
  
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


  #--------------------------------WORKING ON THESE; THE THEORY IS SOUND, BUT FOR SOME REASON OUR #SAVE AND #INSERT METHODS AREN'T WORKING ANYMORE. THINKING WE SHOULD DO THE ANDREW METHOD OF REMOVING THE NEW STUFF WE ADDED TO THE METHODS AND THEN ADDING THEM BACK IN ONE AT A TIME.
  
  def return_category(record_id=nil)
    
    if record_id == nil# if no option is included for record_id in hash 
      record_id = @record_id
    end
    
    category_id = DATABASE.execute("SELECT category_id FROM products WHERE id = #{record_id}")
    category_name = DATABASE.execute("SELECT name FROM categories WHERE id = #{category_id}")
    
    return category_name
  end
  
  #----------------------THIS ONE TOO-------------------------------------------------
  
  def return_location(record_id=nil)
    
    if record_id == nil# if no option is included for record_id in hash 
      record_id = @record_id
    end
    
    location_id = DATABASE.execute("SELECT location_id FROM products WHERE id = #{record_id}")
    location_name = DATABASE.execute("SELECT name FROM locations WHERE id = #{location_id}")
    
    return location_name
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