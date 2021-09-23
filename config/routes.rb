Rails.application.routes.draw do
  devise_for :users
  root 'homes#about'
  get 'top' => 'homes#top'
  get '/search' => 'search#search' #検索

  get 'chat/:id', to: 'chats#show', as: 'chat' #DM
  resources :chats, only: [:create]

  resources :users, only: [:show, :edit, :update, :index, :unsubscribe, :withdraw] do
    collection do
      get 'user/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
      patch 'user/withdraw' => 'users#withdraw', as: 'withdraw_user'
      put 'user/withdraw' => 'users#withdraw'
    end
    resource :relationships, only: [:create, :destroy] #Follow
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'favorites' => 'favorites#favorites', as: 'favorites'
  end

  resources :photos, only: [:show, :edit, :update, :index, :destroy, :new, :create] do
    resource :likes, only: [:create, :destroy] #いいね
    resources :comments, only: [:create, :destroy] #コメント
    resource :favorites, only: [:create, :destroy] #お気に入り
  end
end
