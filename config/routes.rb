Rails.application.routes.draw do

  resources :tags

  resources :topics do
    resources :posts do
      resources :comments
    end
  end


  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
