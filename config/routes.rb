Rails.application.routes.draw do
  resources :guests
  resources :rooms
  resources :room_guests
  resources :chats
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
