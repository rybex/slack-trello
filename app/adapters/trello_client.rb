require 'trello'

class TrelloClient

  def initialize(member_name)
    @member = Trello::Member.find(member_name)
  end

  def find_board(board_name)
    member.boards.detect { |board| board.name == board_name}
  end

  def find_list(board, list_name)
    board.lists.detect { |list| list.name == list_name}
  end

  def create_card(properties)
    Trello::Card.create(name: properties[:name], list_id: properties[:list], desc: properties[:desc])
  end

  private
  attr_reader :member
end