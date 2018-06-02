require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class Login
    def perform(user_id)
      begin
        user = User.find(user_id)
        return_url = 'https://spectreapp.herokuapp.com'
        create(user, return_url)

      rescue StandardError => e
        puts 'An error has occured'
      end
    end

    def create(user, return_url)
      if ENV['APP_ID'].nil? || ENV['SECRET'].nil?
        puts 'Error: APP_ID and/or SECRET variables are not set.'
        return false
      end

      if user.customer_id.nil?
        puts 'customer_id is nil. Try to create customer manually.'
        return false
      else
        puts "customer_id: #{user.customer_id}"
      end
      puts 'Starting POST request'
      token = API.request(:post, 'https://www.saltedge.com/api/v4/tokens/create/', {'data' => {'customer_id' => user.customer_id, 'return_to' => return_url, 'fetch_scopes' => ['accounts', 'transactions']}})
      token_body = JSON.parse(token.body)
      connect_url = token_body['data']['connect_url']
    end
  end
end