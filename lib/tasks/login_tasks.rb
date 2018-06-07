require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class LoginTasks
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

    def save(user_id)
      begin
        user = User.find(user_id)
        
        user_logins = list_logins(user_id)
        'list_logins succeeded'
        puts user_logins

        login = Login.new
        puts 'Login new'
        login.user_id = user_id
        puts login.user_id
        login.login_id = user_logins['data'].last['id']
        puts login.login_id
        login.country_code = user_logins['data'].last['country_code']
        puts login.country_code
        login.created_time = user_logins['data'].last['created_at']
        puts login.created_time
        login.status = user_logins['data'].last['status']
        
        puts login
        login.save
        puts 'Saved'
      rescue StandardError => e
        puts 'An error has occured'
      end
    end

    def list_logins(user_id)
      begin
        user = User.find(user_id)
        user_logins = API.request(:get, 'https://www.saltedge.com/api/v4/logins/', {'data' => {'customer_id' => user.customer_id}})
        user_logins = JSON.parse user_logins.body
      rescue StandardError => e
        puts 'An error has occured'
        puts "customer_id: #{user.customer_id}"
      end
    end

    def reconnect(login_id, credentials)
      begin
        reconnect = API.request(:put, "https://www.saltedge.com/api/v4/logins/#{login_id}/reconnect", {'data' => {'credentials' => credentials, 'override_credentials' => 'true'}})
      rescue StandardError => e
        puts 'An error has occured'
      end
    end

    def refresh(login_id)
      begin
        refresh = API.request(:put, "https://www.saltedge.com/api/v4/logins/#{login_id}/refresh")
      rescue StandardError => e
        puts 'An error has occured'
      end
    end

    def remove(login_id)
      begin
        API.request(:delete, "https://www.saltedge.com/api/v4/logins/#{login_id}")
      rescue StandardError => e
        puts 'An error has occured'
      end
    end
  end
end