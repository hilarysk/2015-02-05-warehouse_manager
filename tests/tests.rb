require 'minitest/autorun'
require_relative '/Users/hilarysk/Code/2015-02-05-warehouse-manager/models/module.rb'
require_relative '/Users/hilarysk/Code/2015-02-05-warehouse-manager/models/class_module.rb' 
require_relative '/Users/hilarysk/Code/2015-02-05-warehouse-manager/models/product_class.rb' 
require_relative '/Users/hilarysk/Code/2015-02-05-warehouse-manager/models/location_class.rb' 
require_relative '/Users/hilarysk/Code/2015-02-05-warehouse-manager/models/category_class.rb'
# require_relative '/Users/hilarysk/Code/2015-02-05-warehouse-manager/database/database_setup.rb'
require "pry"

module WarehouseManagerCM < Minitest::Test
  
  # def setup 
    # player = Player.new(arguments
    # game = Game.new(arguments)
  # end

  
  # EXAMPLES OF TESTS HERE: https://www.dropbox.com/sh/1xxbrzehiiufdae/AACVaS1UiC7s74EZadJdaY6Xa/2015-02-02/99-inheritance-and-composition-1-with-sound.mp4?dl=0
  # AT 10:15
  
  def test_return_category_id
    assert_equal(1, Products.return_category_id(1))
  end
  
  
end

binding.pry 


