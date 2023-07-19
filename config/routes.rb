Rails.application.routes.draw do
  resources :topics
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'topics#index'
end
