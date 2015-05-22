class SlackTrellosController < ApplicationController

  def create_card
    logger.debug "Hello world!" + params[:todo_list_id]
  end
end