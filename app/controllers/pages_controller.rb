require 'tasks/create_customer'
require 'tasks/transaction_tasks'

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

    def transactions
      user_transactions = Tasks::Transaction.new.fetch(current_user.id)
      render json: user_transactions
    end
end
