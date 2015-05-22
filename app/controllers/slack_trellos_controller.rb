class SlackTrellosController < ApplicationController

  def create_card
    form = validate_request
    create_trello_card(form)
  rescue RequestForm::RequestInvalid
    respond_to do |format|
      format.json do
        render json: {text: 'Wrong request params. Something is missing'}
      end
    end
  rescue CreateTrelloCard::BoardNotFound
    respond_to do |format|
      format.json do
        render json: {text: 'Board not exist'}
      end
    end
  rescue CreateTrelloCard::BoardListNotFound
    respond_to do |format|
      format.json do
        render json: {text: 'Boards list not exist'}
      end
    end
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