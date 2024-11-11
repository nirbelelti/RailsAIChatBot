Rails.application.routes.draw do

  devise_for :users

  resources :chats do
    member do
      post :set_current_chat
    end
  end

  root 'chats#index'
end
