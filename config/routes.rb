Rails.application.routes.draw do
  resources :users
  root 'home#index'
  get '/contact' => 'home#contact'
  get '/help' => 'home#help'
  get '/about' => 'home#about'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

end
