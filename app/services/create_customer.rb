require 'rest-client'
require 'json'
require 'pry'

class CreateCustomer
  def perform(params)
    @user = User.find(params)
    create_customer
  end

  def create_customer
    response = API.request(:post, 'https://www.saltedge.com/api/v4/customers/', { 'data' => { 'identifier' => @user.email } })
    customer_id = JSON.parse(response)['data']['id']
    @user.customer_id = customer_id
    @user.save
  end
end
