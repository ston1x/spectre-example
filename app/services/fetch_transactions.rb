require 'rest-client'
require 'json'
require 'pry'

class FetchTransactions
  def perform(account_id)
    account = Account.find(account_id)
    
    response = API.request(:get, "https://www.saltedge.com/api/v4/transactions?account_id=#{account.account_id}")
    transactions = JSON.parse response.body
    transactions = transactions['data']
    transactions.each do |transaction|
      t = Transaction.new
      t.transaction_id = transaction['id']
      t.account_id = account.id
      t.made_on = transaction['made_on']
      t.status = transaction['status']
      t.category = transaction['category']
      t.description = transaction['description']
      t.amount = transaction['amount']
      t.currency_code = transaction['currency_code']
      t.save
    end
  end
end