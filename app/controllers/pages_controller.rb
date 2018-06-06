require 'tasks/create_customer'
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

    def accounts
      user_accounts = Tasks::Account.new.fetch(current_user.id)
      render json: user_accounts
    end

    def transactions
      user_transactions = Tasks::Transaction.new.fetch(current_user.id)
      render json: user_transactions
    end
end
