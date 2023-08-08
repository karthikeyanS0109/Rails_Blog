Rails.application.routes.draw do

  resources :tags do
    # Nested route for related posts of a specific tag
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end

  resources :topics do
    resources :posts do
      resources :comments
      resources :ratings, only: [:create]
    end
  end

  # gets '/posts',to => "posts#index"

  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
