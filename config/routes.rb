Rails.application.routes.draw do
  resource :slack_trello do
    member do
      post    :create_card
    end
  end
end
