require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class Login
    def save(user_id)
      begin
        user = User.find(user_id)
        user_logins = API.request(:get, 'https://www.saltedge.com/api/v4/logins/', {'data' => {'customer_id' => user.customer_id}})
        user_logins = JSON.parse user_logins.body
        user.login_id = user_logins['data'].last['id']
        puts "login_id: #{user.login_id}"
        user.save
        puts 'Saved'
      rescue StandardError => e
        puts 'An error has occured'
      end
    end
  end
end