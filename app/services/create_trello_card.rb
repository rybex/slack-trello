class CreateTrelloCard
  BoardNotFound     = Class.new(StandardError)
  BoardListNotFound = Class.new(StandardError)

  def initialize(form, trello)
    @form = form
    @trello = trello
  end

  def call
    board  = find_board
    list   = find_board_list(board)
    trello.create_card(card_params(list))
  end

  private
  attr_reader :form, :trello

  def find_board
    board = trello.find_board(form.text[:board_name])
    raise BoardNotFound if board.nil?
    board
  end

  def find_board_list(board)
    list = trello.find_list(board, form.text[:list_name])
    raise BoardListNotFound if list.nil?
    list
  end

  def card_params(list)
    {name: form.text[:card_title], list: list.id, desc: form.text[:card_desc]}
  end

end