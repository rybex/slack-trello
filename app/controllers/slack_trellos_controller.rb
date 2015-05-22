class SlackTrellosController < ApplicationController

  def create_card
    logger.debug "Hello world!" + params[:user_name]
  end
end