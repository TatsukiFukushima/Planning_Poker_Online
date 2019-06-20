Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  root 'home#index'
  get '/contact' => 'home#contact'
  get '/help' => 'home#help'
  get '/about' => 'home#about'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

end
