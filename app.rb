root = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << root

require 'sinatra'
require 'trello_habitica'
require 'habitica_trello'

get '/' do
  "Parcenet."
end

get '/trello_to_habitica' do
  TrelloHabitica.new.call
  "Moved Trello tasks to Habitica."
end

get '/habitica_to_trello' do
  HabiticaTrello.new.call
  "Moved Habitica tasks to Trello"
end
