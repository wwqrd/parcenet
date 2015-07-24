require 'sinatra'

get '/' do
  "Parcenet."
end

get '/trello_to_habitrpg' do
  TrelloHabitRPG.new.call
end
