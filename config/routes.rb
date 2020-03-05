Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  #投稿用ルーティング
  resources :posts
  #
  root to: 'posts#index'
end
