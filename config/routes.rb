Rails.application.routes.draw do
  # post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :relationships
  resources :users
  post '/login', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  # post "/login" => "sessions#create"
  # delete "/logout" => "sessions#destroy"
  get '/profile' => 'users#profile'

end
