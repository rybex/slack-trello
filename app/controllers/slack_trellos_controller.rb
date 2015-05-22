class SlackTrellosController < ApplicationController

  def create_card
    respond_to do |format|
      format.json { render text: 'Successfully Done!' }
    end
  end
end