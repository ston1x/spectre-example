require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class Transaction
    def fetch(user_id)
      begin
        puts "user_id: #{user_id}"
        user = User.find(user_id)
        user_transactions = API.request(:get, "https://www.saltedge.com/api/v4/transactions?login_id=#{user.login_id}")
        user_transactions.body
      
      rescue StandardError => e
        puts 'An error has occured'
      end
    end
  end
end
