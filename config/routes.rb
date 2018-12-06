Rails.application.routes.draw do
  # post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :relationships
  resources :users

  #action cable
  resources :conversations, only: [:index, :create]
  resources :messages, only: [:create]
  mount ActionCable.server => '/cable'

  #auth routes
  post '/login', to: 'auth#create'
  get '/current_user', to: 'auth#show'

  #user routes
  post '/sign_up', to: 'users#create'
  post  '/followers', to: 'users#followers'
  patch '/relationships', to: 'relationships#update'
  get '/find_matches', to: 'users#found_match'
  get '/profile' => 'users#profile'
  get '/matches' => 'users#found_match'
  get '/show_matches' => 'users#show_matches'
  get '/current_user', to: 'auth#show'
  post '/video', to: 'videos#create'
  post  '/followers', to: 'users#followers'

end
