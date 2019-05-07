Rails.application.routes.draw do

  resources :services


  #login
  post 'login', to: "authentication#login"
  #SignUp
  post 'signup', to: "users#signup"
  #consult-wallet
  post 'consult-wallet', to: "users#consult_wallet"
  #transfer
  post 'user/transfer', to: "transfers#transfer"
  #transfer_admin
  post 'admin/transfer', to: "transfers#transferadmin"
  #payment
  post 'user/payment', to: "payments#payment"
  #current-money
  get 'user/current-money', to: "wallets#currentmoney"
  #current-money
  get 'shopkeeper/current-money', to: "wallets#currentmoneyadmin"
  #service
  get 'service/list', to: "service#index"
  #report
  get 'user/report', to: "reports#report"

end
