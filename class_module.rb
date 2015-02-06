# Module: WarehouseManagerCM
#
# Toolbox for use in our Warehouse Manager program; contains class methods that could work for Product, Category, or Location classes.
#
# Public Methods:
# #find_record_id
# #find


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

  def find_record_id(options)
    table = options["table"]
    field = options["field"]
    value = options["value"]
    
    @id_array = DATABASE.execute("SELECT id FROM #{table} WHERE #{field} = #{value}")
    
    if @id_array.length > 1
      @record_id = @id_array.join(" OR id = ")
    else
      @record_id = @id_array[0].to_s
    end
    
    return @id_array.join(", ")
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
 
  #need to update in cast of multiple IDs
  
  def find(options)
    table = options["table"]
    class_name = options["class_name"]
    @record_id = options["record_id"] 
    
    results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{@record_id}")
    
    object_array = []
    
    if @id_array.length > 1
      results.each do |row_hash| # ---> row_hash = {"name"="bop it", "description" => "cat", "id"=>4}
        object_array << class_name.new(row_hash)
        return object_array
      end
    
    else
      record_details = results[0] # Hash of the row's details.
      return class_name.new(record_details) # Makes object
    end
    
  end






end