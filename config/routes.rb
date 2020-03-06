Rails.application.routes.draw do
  #トップページをホームに
  root to: 'static_pages#home'
  #投稿用ルーティング
  resources :posts

  #管理者用ユーザールーティング
  namespace :admin do
    resources :users
  end

  #セッション用ルーティング
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


end
