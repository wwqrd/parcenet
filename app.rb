root = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << root

require 'sinatra'
require 'trello_habit_rpg'

get '/' do
  "Parcenet."
end

get '/trello_to_habitrpg' do
  TrelloHabitRPG.new.call
end
