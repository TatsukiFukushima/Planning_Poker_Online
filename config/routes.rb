Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  resources :microposts, only: [:create, :destroy]

  # ログインしている時のパス
  constraints ->  request { request.session[:user_id].present? } do
    root to: 'users#show'
  end
  # してない時
  root to: 'home#index'
  get '/contact' => 'home#contact'
  get '/help' => 'home#help'
  get '/about' => 'home#about'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

end
