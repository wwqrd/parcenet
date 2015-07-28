require 'trello'
require 'habit_client'

class HabitRPGTrello

  def trello
    @trello ||= Trello::Client.new(
      developer_public_key: ENV['TRELLO_DEVELOPER_PUBLIC_KEY'],
      member_token: ENV['TRELLO_MEMBER_TOKEN']
    )
  end

  def hrpg
    @hrpg ||= HabitClient.new(ENV['HRPG_USER_ID'], ENV['HRPG_API_TOKEN'])
  end

  def todos
    hrpg.user.tasks.todos.reject(&:completed?)
  end

  def call
    todos.each do |todo|

      puts "#{todo.text}"

      card = trello.create(:card,
                           'name' => todo.text,
                           'idList' => ENV['TRELLO_INBOX_LIST_ID'])

      unless todo.checklist.empty?
        checklist = trello.create(:checklist,
                                  'name' => 'Checklist',
                                  'idBoard' => ENV['TRELLO_BOARD_ID'])
        todo.checklist.each do |checklist_task|
          puts "\t#{checklist_task}"
          checklist.add_item(checklist_task['text'])
        end
        card.add_checklist(checklist)
      end
    end
  end

end
