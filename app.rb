require './config/environment'
require 'sinatra'
require 'sinatra/namespace'
require 'digest'
require 'trello_habitica'
require 'habitica_trello'


def check_token(token)
  halt(401) unless token && valid_token?(token)
end

def valid_token?(token)
  ENV['TOKEN'] == Digest::SHA256.hexdigest(ENV['SALT'] + token)
end

get '/' do
  "Parcenet. Human augmentation software."
end

namespace '/do' do

  before '/*' do
    check_token(params[:token])
  end

  get '/trello_to_habitica' do
    TrelloHabitica.new.run
    "Moved Trello tasks to Habitica."
  end

  get '/habitica_to_trello' do
    HabiticaTrello.new.run
    "Moved Habitica tasks to Trello"
  end

end
