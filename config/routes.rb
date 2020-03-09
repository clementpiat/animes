Rails.application.routes.draw do
  root to: 'playlists#index'

  resources :playlists, only: [:index, :show, :new, :create, :destroy] do
    member do
      post 'remove_anime'
      post 'add_custom_music'
      post 'remove_music'
    end
  end

  resources :animes, only: :index do
    collection do
      post 'search'
      get 'search'
    end
    member do
      post 'add_to_playlist'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create] do
    member do
      get :confirm_email
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
end
