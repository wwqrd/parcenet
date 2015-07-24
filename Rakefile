root = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << root

require 'dotenv'
Dotenv.load

require 'trello_habit_rpg'

task default: 'test'

task :trello_to_habitrpg do
  TrelloHabitRPG.new.call
end

task :test do
  puts 'UH OH! NO TESTS!'
end
