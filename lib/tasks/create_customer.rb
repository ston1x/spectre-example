require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class Customer
    def perform(user_id)
      begin
        user = User.find(user_id)
        create(user)     
        puts 'user saved'

      rescue StandardError => e
        puts 'An error has occured'
      end
    end

    def create(user)
      if ENV['APP_ID'].nil? || ENV['SECRET'].nil?
        puts 'Error: APP_ID and/or SECRET variables are not set.'
      end

      puts 'Starting POST request'
      response = API.request(:post, 'https://www.saltedge.com/api/v4/customers/', 
        {'data' => {'identifier' => user.email}})
      customer_id = JSON.parse(response)['data']['id']
      user.customer_id = customer_id
      user.save
    end
  end
end