class TransactionsController < ApplicationController
  def fetch
    account = Account.find(params[:id])    
    fetch_transactions_service = FetchTransactions.new
    fetch_transactions_service.perform(params[:id])
    redirect_to account
  end
end
