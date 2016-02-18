require 'trello'
require 'habitica_client'

class HabiticaTrello

  def trello
    @trello ||= Trello::Client.new(
      developer_public_key: ENV['TRELLO_DEVELOPER_PUBLIC_KEY'],
      member_token: ENV['TRELLO_MEMBER_TOKEN']
    )
  end

  def habitica
    @habitica ||= HabiticaClient.new(ENV['HRPG_USER_ID'], ENV['HRPG_API_TOKEN'])
  end

  def todos
    habitica.user.tasks.todos.reject(&:completed?)
  end

  def task_in_progress?(todo)
    return false if todo.checklist.empty?

    todo.checklist.any? { |task| task['completed'] }
  end

  def run
    todos.each do |todo|
      puts "#{todo.text}"

      next if task_in_progress?(todo)

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

      todo.delete
    end
  end

end
