require 'rest-client'
require 'json'
require 'pry'

class CreateCustomer
  def initialize(params)
    @user = User.find(params)
  end

  def create
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