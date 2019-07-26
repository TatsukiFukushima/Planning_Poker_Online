Rails.application.routes.draw do
  resources :users
  resources :rooms
  resources :microposts, only: [:create, :destroy]
  get '/issues/import' => 'issues#import' # ここに置かないと、showアクションのidが"github_import"という扱いになってしまう。
  post '/issues/import' => 'issues#import_create'
  resources :issues

  # ログインしている時のパス
  constraints ->  request { request.session[:user_id].present? } do
    root to: 'users#show'
  end
  # してない時
  root to: 'home#index'

  get 'sessions/new'
  get '/contact' => 'home#contact'
  get '/help' => 'home#help'
  get '/about' => 'home#about'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/rooms/:id/room_issues/edit' => 'room_issues#edit'
  post '/room_issues/create' => 'room_issues#create'
  post '/room_issues/destroy' => 'room_issues#destroy'

end
