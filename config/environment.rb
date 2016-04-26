root = File.expand_path('../lib', File.dirname(__FILE__))
$LOAD_PATH << root

environment = ENV['RACK_ENV'] || 'development'

if environment != 'production'
  require 'dotenv'
  Dotenv.load
end
