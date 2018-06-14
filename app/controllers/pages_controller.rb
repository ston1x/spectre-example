require 'tasks/create_customer'
require 'tasks/transaction_tasks'

class PagesController < ApplicationController
    def index
    end

    def dashboard
    end

    def create_customer
      Tasks::Customer.new.perform(current_user.id)
    end
end
