Rails.application.routes.draw do

  root 'pins#index'
  get '/pins/name-:slug' => 'pins#show_by_name', as: 'pin_by_name'
  get '/pins/name-:slug/edit' => 'pins#edit', as: :edit_pin_by_name

  resources :pins

  get '/library' => 'pins#index'
  get 'signup' => 'users#new', as: :signup
  resources :users, except: [:index]
  get '/login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout
end
