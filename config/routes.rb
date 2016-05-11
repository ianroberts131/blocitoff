Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root to: "users#show", as: :authenticated_root
    resources :items, only: [:create, :destroy]
    resources :users, only: [:show]
  end

  root 'welcome#home'

end
