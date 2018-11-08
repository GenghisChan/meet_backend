Rails.application.routes.draw do
  # post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :relationships
  resources :users
  post '/login', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  # post "/login" => "sessions#create"
  # delete "/logout" => "sessions#destroy"
  post '/sign_up', to: 'users#create'
  get '/find_matches', to: 'users#found_match'
  get '/profile' => 'users#profile'
  get '/matches' => 'users#find_matches'

end
