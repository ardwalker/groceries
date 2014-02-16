require 'yaml'
require 'securerandom'
require 'bigdecimal'

class ShoppingListItem
  include HashConstructed
  attr_accessor :grocery_item, :quantity, :id
  
  def self.create(options = {})
    item = ShoppingListItem.new(options)
    item.id = SecureRandom.uuid
    item
  end
      
  def self.load_all
    shopping_list = YAML::load(IO.read("current_shopping_list.yaml"))['shopping_list']
    shopping_list
  end
  
  def self.store_all(shopping_list)
    store = YAML::Store.new('current_shopping_list.yaml')
    store.transaction do
      store['shopping_list'] = shopping_list
    end
  end
  
  def total
    (BigDecimal.new(@grocery_item.unit_price.to_s,2) * @quantity).to_s('2F')
    # BigDecimal.new("0")
  end
  
end
