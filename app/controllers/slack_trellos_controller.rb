class SlackTrellosController < ApplicationController

  def create_card
    form = validate_request
    create_trello_card(form)
    render json: {text: 'Ticket created'}
  rescue RequestForm::RequestInvalid
    render json: {text: 'Wrong request params. Something is missing'}
  rescue CreateTrelloCard::BoardNotFound
    render json: {text: 'Board not exist'}
  rescue CreateTrelloCard::BoardListNotFound
    render json: {text: 'Boards list not exist'}
  end

  private

  def validate_request
    form = RequestForm.new(params)
    form.validate!
    form
  end

  def create_trello_card(form)
    CreateTrelloCard.new(form, trello_client).call
  end

  def trello_client
    TrelloClient.new(ENV['MEMBER'])
  end
end