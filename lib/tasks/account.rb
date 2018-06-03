require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class Account
    def fetch(user_id)
      begin
        user = User.find(user_id)
        user_accounts = API.request(:get, 'https://www.saltedge.com/api/v4/accounts', {'data' => {'login_id' => user.login_id}})
        user_accounts.body
      
      rescue StandardError => e
        puts 'An error has occured'
      end
    end
  end
end
