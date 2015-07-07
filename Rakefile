root = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << root

require 'trello_habit_rpg'

task default: 'test'

task :trello_habit_rpg do
  TrelloHabitRPG.new.call
end

task :test do
  puts 'UH OH! NO TESTS!'
end
