Rails.application.routes.draw do

  devise_for :users
  resources :tags do
    # Nested route for related posts of a specific tag
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end

  resources :topics do
    resources :posts do
      post "read_unread", on: :member
      resources :comments do
        resources :comment_ratings,only: [:create, :update]
      end
      resources :ratings, only: [:create]
    end
  end

  resources :posts, only: [:index]

  # get 'toggle_theme', to: 'application#toggle_theme'

  # get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'topics#index'
end
