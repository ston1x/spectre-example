require 'tasks/create_customer'
require 'tasks/create_login'
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

end
