root = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << root

require 'dotenv'
Dotenv.load

require 'habitica_trello'
require 'trello_habitica'

task default: 'test'

desc 'Move \'next\' tasks to habitica todo list'
task :trello_to_habitica do
  TrelloHabitica.new.call
end

desc 'Move uncompleted habitica tasks back to \'inbox\''
task :habitica_to_trello do
  HabiticaTrello.new.call
end

task :test do
  puts 'UH OH! NO TESTS!'
end
