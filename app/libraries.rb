RACK_ENV  = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

# bundled gems
require 'sinatra/base'
require 'erubis'

require 'app/lib/hash_constructed'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
# $LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + "models")

