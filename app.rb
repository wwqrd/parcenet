root = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << root

require 'sinatra'
require 'trello_habit_rpg'
require 'habit_rpg_trello'

get '/' do
  "Parcenet."
end

get '/trello_to_habitrpg' do
  TrelloHabitRPG.new.call
  "Done."
end

get '/habitrpg_to_trello' do
  HabitRPGTrello.new.call
  "Done."
end
