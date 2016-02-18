require 'trello'
require 'habitica_client'

class TrelloHabitica

  def trello
    @trello ||= Trello::Client.new(
      developer_public_key: ENV['TRELLO_DEVELOPER_PUBLIC_KEY'],
      member_token: ENV['TRELLO_MEMBER_TOKEN']
    )
  end

  def next_cards
    @next_cards ||= trello.find(:lists, ENV['TRELLO_LIST_ID']).cards
  end

  def habitica
    @habitica ||= HabiticaClient.new(ENV['HRPG_USER_ID'], ENV['HRPG_API_TOKEN'])
  end

  def checklist_from_card(card)
    card.checklists.flat_map do |checklist|
      checklist.check_items.map do |task|
        {text: task["name"]}
      end
    end
  end

  def task_from_card(card)
    {text: card.name,
     notes: card.desc,
     type: 'todo',
     checklist: checklist_from_card(card)}
  end

  def run
    next_cards.each do |card|
      puts "#{card.name}"

      task = task_from_card(card)
      card.close! if habitica.user.tasks.create(task)
    end
  end

end
