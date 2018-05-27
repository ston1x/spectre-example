require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class Customer
    def perform(user_id)
      begin
        user = User.find(user_id)
        if ENV['APP_ID'].present? && ENV['SECRET'].present?
          puts '[OK] APP_ID and SECRET variables are set'
        else
          puts 'Error: Either APP_ID or SECRET variables are not set'
        end
        
        puts 'Starting POST request'
        response = API.request(:post, 'https://www.saltedge.com/api/v4/customers/', 
          {'data' => {'identifier' => user.email}})
        puts 'Success'

        customer_id = JSON.parse(response)['data']['id']
        puts "customer_id: #{customer_id}"
        
        user.customer_id = customer_id
        user.save
        
        puts 'user saved'
      rescue StandardError => e
        'rescue'
      end
    end
  end
end