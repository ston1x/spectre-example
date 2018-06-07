require 'rest-client'
require 'json'
require 'pry'

module Tasks
  class AccountTasks
    def fetch(login_id)
      begin
        login = Login.find_by(login_id: login_id)
        # Destroy all existing accounts in the database to refresh them
        login.accounts.destroy_all if login.accounts.any?
        response = API.request(:get, 'https://www.saltedge.com/api/v4/accounts', {'data' => {'login_id' => login_id}})
        accounts = JSON.parse response.body
        accounts = accounts['data']
        accounts.each do |account|
          
          a = Account.new
          a.account_id = account['id']
          a.login_id = login.id
          a.name = account['name']
          a.balance = account['balance']
          a.currency_code = account['currency_code']
          a.nature = account['nature']
          transactions_posted = account['extra']['transactions_count']['posted'].to_i
          transactions_pending = account['extra']['transactions_count']['pending'].to_i
          a.transactions_count = transactions_posted + transactions_pending
          puts 'Saving account'
          a.save
          Tasks::TransactionTasks.new.fetch(a.id)
        end
      
      rescue StandardError => e
        puts 'An error has occured'
      end
    end
  end
end
