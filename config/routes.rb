Rails.application.routes.draw do
  resources :users
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Login
  post 'login', to: "authentication#login"

end