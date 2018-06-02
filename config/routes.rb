Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root 'pages#index'
  authenticated :user do
    get 'dashboard' => 'pages#dashboard'
    get 'success' => 'pages#callback_success'
    post 'create_customer/:user_id', to: 'pages#create_customer', as: 'create_customer'
    post 'create_login/:user_id', to: 'pages#create_login', as: 'create_login'
  end
end
