class AddColumnsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :made_on, :string
    add_column :transactions, :status, :string
    add_column :transactions, :category, :string
    add_column :transactions, :description, :string
    add_column :transactions, :amount, :float
    add_column :transactions, :currency_code, :string
  end
end
