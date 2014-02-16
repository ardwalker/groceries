require 'app/libraries'
require 'app/models/shopping_list_item'
require 'app/models/grocery_item'
require 'yaml'
require 'yaml/store'

module Groceries

  class App < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))
    
    set :public_dir, "#{dir}/public"
    set :root, RACK_ROOT
    set :app_file, __FILE__
    set :static, true
    set :views, "#{dir}/views"
    
    enable :sessions
    
    use Rack::MethodOverride

    # register ::Sinatra::Auth::Github

    def initialize(*args)
      super
      @debug = ENV['DEBUG']
      @shopping_list = YAML::load(IO.read("app/shopping_list.yaml"))
    end
  
    get '/' do
      # @shopping_list = YAML::load(IO.read("current_shopping_list.yaml"))['shopping_list']
      @shopping_list = ShoppingListItem.load_all
      erb :index
    end

    get '/new' do
      @grocery_items = GroceryItem.all
      erb :new
    end
    
    post '/shopping' do
      @shopping_list = ShoppingListItem.load_all  #YAML::load(IO.read("current_shopping_list.yaml"))['shopping_list']
      grocery_item_id = params[:grocery_item].to_i
      grocery = GroceryItem.from_id(grocery_item_id)
      quantity = params[:quantity].to_i
      
      sli = ShoppingListItem.create({:grocery_item => grocery, :quantity => quantity})
      @shopping_list << sli
      ShoppingListItem.store_all(@shopping_list)
      erb :index
    end
    
    delete '/shopping/:id' do
      @shopping_list = ShoppingListItem.load_all  #YAML::load(IO.read("current_shopping_list.yaml"))['shopping_list']
      @shopping_list.reject! do |obj| 
        puts "OBJ #{obj.id}, #{params[:id]}"
        obj.id == params[:id]
      end

      store = YAML::Store.new('current_shopping_list.yaml')
      store.transaction do
        store['shopping_list'] = @shopping_list
      end

      erb :index
    end
    
  end
  
end





