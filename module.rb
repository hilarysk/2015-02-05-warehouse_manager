module WarehouseManager

  def where_value_for_field_in_table_is(options)
    field = options["field"]
    table_name = options["table_name"]
    value = options["value"]
    class_name = options["class_name"]
    
    if value.is_a? Integer
       results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{field} = #{value}")
     else
       results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{field} = '#{value}'")
     end
    
    results_as_objects = []
    
    results.each do |record| 
      results_as_objects << class_name.new(record)
    end
  end
  
  
  
  
end