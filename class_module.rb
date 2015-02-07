# Module: WarehouseManagerCM
#
# Toolbox for use in our Warehouse Manager program; contains class methods that could work for Product, Category, or Location classes.
#
# Public Methods:
# #find_record_id
# #find
# #exterminate


module WarehouseManagerCM  

  def select_all(options)
    table = options["table"]
    DATABASE.execute("SELECT * FROM #{table}")
  end
  
  
  def delete_second_version_of_key_value_pairs_in_returned_hash
    hashes.delete_if do |key, value|
      key.is_a?(Integer)
    end
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
      @id_array.each do |hashes|
        hashes.delete_if do |key, value|
          key.is_a?(Integer) 
        end
        hashes.each do |key, value|
          value_array << value
          @record_id = value_array
        end
      end
    else
      @record_id = @id_array[0][0].to_s
    end

    return @record_id
  end 

  # Public: #find
  # Pulls a specific row or rows given the row's ID (primary key) pulled from #find_record_id or provided by argument
  #
  # Parameters:
  # options - Hash
  #           - @record_id - id: the id/s for the item/s in question
  #           - table      - table: The specific database table we're searching
  #           - class_name - class_name: The class on which the method is being called to create a new instantiation
  #             
  #             
  #
  # Returns:
  # An array of the object/objects asked for
 
  #need to update in case of multiple IDs
    
  def find(options)
    table = options["table"]
    class_name = options["class_name"]
    record_id = options["record_id"] 
    
    if record_id == nil# if no option is included for record_id in hash 
    
      if @record_id.is_a?(Array)
        record_id = @record_id.join(" OR id = ")
        @results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      else
        record_id = @record_id
        @results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
      end
      
      @results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    
    else
      @results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id}")
    end
    @better_results = @results.each do |hashes|
                      hashes.delete_if do |key, value|
                        key.is_a?(Integer) 
                      end
                    end
    return @better_results #returns an array
  end




  def transform_results_from_find_method_into_objects(class_name)

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
  
  




  
  def delete_record
    #--delete an entire row from a table - just pull in id from find_record_id and then run the delete command on it
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