Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  get 'home', to: 'pages#index', as: 'home'
  authenticated :user do
    get 'dashboard' => 'pages#dashboard'
    root 'pages#dashboard'
    get 'success' => 'logins#callback_success'

    resources :logins
    resources :accounts
    post 'create_customer', to: 'pages#create_customer', as: 'create_customer'
    post 'create_login', to: 'logins#create_login', as: 'create_login'
    post 'save_login', to: 'logins#save_login', as: 'save_login'
    get 'list_logins', to: 'logins#list_logins', as: 'list_logins'
    post 'reconnect_login', to: 'logins#reconnect_login', as: 'reconnect_login'
    put 'refresh_login', to: 'logins#refresh_login', as: 'refresh_login'
    get 'login_credentials', to: 'pages#login_credentials', as: 'login_credentials'
    delete 'remove_login', to: 'logins#remove_login', as: 'remove_login'
    get 'fetch_accounts', to: 'accounts#fetch', as: 'fetch_accounts'
    get 'fetch_transactions', to: 'transactions#fetch', as: 'fetch_transactions'
  end
  root 'pages#index'
end
