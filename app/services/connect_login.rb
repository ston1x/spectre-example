require 'rest-client'
require 'json'
require 'pry'

class ConnectLogin
  def initialize(params)
    @user = User.find(params)
  end

  def perform
    @return_url = ENV['RETURN_URL']
    connect
  end

  def connect
    begin
      return false if @user.customer_id.nil?
      token = API.request(:post, 'https://www.saltedge.com/api/v4/tokens/create/', {'data' => {'customer_id' => @user.customer_id, 'return_to' => @return_url, 'fetch_scopes' => ['accounts', 'transactions']}})
      token_body = JSON.parse(token.body)
      connect_url = token_body['data']['connect_url']
    rescue
      false
    end
  end
end