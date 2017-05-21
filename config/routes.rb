Rails.application.routes.draw do
  resources :responses
  resources :authors
  resources :articles, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'home#dashboard', as: :dashboard

end
