require 'tasks/create_customer'
require 'tasks/create_login'
require 'tasks/save_login'
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

    def accounts
      user_accounts = Tasks::Account.new.fetch(current_user.id)
      render json: user_accounts
    end

    def transactions
      user_transactions = Tasks::Transaction.new.fetch(current_user.id)
      render json: user_transactions
    end

end
