Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :books, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :bookings, only: [:create]
    resources :reviews, only: :create
    collection do
      get :my_books
    end
  end
  resources :bookings, only: [:index] do
    collection do
      get :requested
    end
    member do
      patch :confirm
      patch :decline
    end
  end
end
