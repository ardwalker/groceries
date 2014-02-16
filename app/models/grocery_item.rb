
require 'debugger'

class GroceryItem
  include HashConstructed
  attr_accessor :category,:name,:unit_price, :id
  
  @@all_items = [
    GroceryItem.new({ :id => 1, :category => 'Bread', :name => 'Premium Wholewheat', :unit_price => 2.95 }),
    GroceryItem.new({ :id => 2, :category => 'Fish', :name => 'Salmon', :unit_price => 9.95 }),
    GroceryItem.new({ :id => 3, :category => 'Dairy', :name => 'Whole Milk', :unit_price => 3.45 }),
    GroceryItem.new({ :id => 4, :category => 'Meat', :name => 'Chicken', :unit_price => 6.95 }),
    GroceryItem.new({ :id => 5, :category => 'Bakery', :name => 'Bagels', :unit_price => 1.95 }),
    GroceryItem.new({ :id => 6, :category => 'Household', :name => 'Detergent', :unit_price => 10.79 })
  ]
  
  def self.all
    @@all_items
  end

  def self.from_id(item_id)
    @@all_items.find {|item| item.id == item_id}
  end

end

