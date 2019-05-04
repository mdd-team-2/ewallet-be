Rails.application.routes.draw do
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
