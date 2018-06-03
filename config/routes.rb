Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root 'pages#index'
  authenticated :user do
    get 'dashboard' => 'pages#dashboard'
    get 'success' => 'pages#callback_success'
    post 'create_customer', to: 'pages#create_customer', as: 'create_customer'
    post 'create_login', to: 'pages#create_login', as: 'create_login'
    post 'save_login', to: 'pages#save_login', as: 'save_login'
    get 'accounts', to: 'pages#accounts', as: 'accounts'
    get 'transactions', to: 'pages#transactions', as: 'transactions'
  end
end
