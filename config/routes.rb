Rails.application.routes.draw do
  resources :articles, only: [:index] do
    member do
      patch :like
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
