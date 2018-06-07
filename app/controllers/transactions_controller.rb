class TransactionsController < ApplicationController
  def fetch
    account = Account.find(params[:id])    
    transactions = Tasks::TransactionTasks.new.fetch(params[:id])
    redirect_to account
  end
end
