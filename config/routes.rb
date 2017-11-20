Rails.application.routes.draw do
  get 'game', to: 'number#game'

  get 'score', to: 'number#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
