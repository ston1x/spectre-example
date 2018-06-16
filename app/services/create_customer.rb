require 'rest-client'
require 'json'
require 'pry'

class CreateCustomer
  def initialize(params)
    @user = User.find(params)
  end

  def perform
    create_customer
  end

  def create_customer
    begin
      response = API.request(:post, 'https://www.saltedge.com/api/v4/customers/', {'data' => {'identifier' => @user.email}})
      customer_id = JSON.parse(response)['data']['id']
      @user.customer_id = customer_id
      @user.save
    rescue
      false
    end
  end
end