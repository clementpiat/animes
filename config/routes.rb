Rails.application.routes.draw do
  root to: 'animes#index'

  resources :playlists
  resources :animes, only: [:index, :show] do
    collection do
      post 'search'
      get 'search'
    end
    member do
      post 'add_to_playlist'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
