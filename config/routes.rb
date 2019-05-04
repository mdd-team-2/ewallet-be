Rails.application.routes.draw do
  resources :payments
  resources :transactions
  resources :wallets
  resources :transaction_types
  resources :services
  resources :users
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #login
  post 'login', to: "authentication#login"
  #SignUp
  post 'signup', to: "users#signup"
  #test
  post 'test', to: "users#test"

end
