require 'trello'
require 'habit_client'

class TrelloHabitRPG

  def trello
    @trello ||= Trello::Client.new(
      developer_public_key: ENV['TRELLO_DEVELOPER_PUBLIC_KEY'],
      member_token: ENV['TRELLO_MEMBER_TOKEN']
    )
  end

  def next_cards
    @next_cards ||= trello.find(:lists, ENV['TRELLO_LIST_ID']).cards
  end

  def hrpg
    @hrpg ||= HabitClient.new(ENV['HRPG_USER_ID'], ENV['HRPG_API_TOKEN'])
  end

  def call
    next_cards.each do |card|

      puts "#{card.name}: #{card.desc}"

      hrpg.user.tasks.create(
        text: card.name,
        notes: card.desc,
        type: 'todo'
      )

      card.close!

    end
  end

end
