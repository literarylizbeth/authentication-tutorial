AuthenticationTutorial::Application.routes.draw do

  root "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  match "/sign_out", to: "sessions#destroy", via: "delete"
  resources :users, except: :index

end
