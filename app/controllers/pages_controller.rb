require 'tasks/create_customer'
require 'tasks/login'
require 'tasks/account'
require 'tasks/transaction'

class PagesController < ApplicationController
    def index
    end

    def dashboard
    end

    def callback_success
    end

    def create_customer
      Tasks::Customer.new.perform(current_user.id)
    end

    def create_login
      connect_url = Tasks::Login.new.perform(current_user.id)
      redirect_to connect_url
    end

    def save_login
      Tasks::Login.new.save(current_user.id)
      redirect_to dashboard_path
    end

    def list_logins
      user_logins = Tasks::Login.new.list_logins(current_user.id)
      render json: user_logins
    end

    def reconnect_login
      credentials = {
        'login' => params[:login], 
        'password' => params[:password]}
      
      response = Tasks::Login.new.reconnect(current_user.id, credentials)
      render json: response
    end

    def login_credentials
    end

    def refresh_login
      response = Tasks::Login.new.refresh(current_user.id)
      render json: response
    end

    def accounts
      user_accounts = Tasks::Account.new.fetch(current_user.id)
      render json: user_accounts
    end

    def transactions
      user_transactions = Tasks::Transaction.new.fetch(current_user.id)
      render json: user_transactions
    end
end
