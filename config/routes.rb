Rails.application.routes.draw do
  resources :authors
  resources :categories
  resources :books
  get 'home/index'
  get '/books/:id/checkout', to: 'books#checkout', as: :checkout_book
  post '/books/:id/confirm_payment', to: 'stripe_checkouts#create', as: :confirm_payment_book

  # post 'stripe_checkout/:book_id', to: 'stripe_checkouts#create', as: :stripe_checkout
  get 'stripe/success', to: 'stripe_checkouts#success', as: :stripe_success


  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'home#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
 
  # Defines the root path route ("/")
  # root "posts#index"
end
