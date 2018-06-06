class AddColumnsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :balance, :float
    add_column :accounts, :currency_code, :string
    add_column :accounts, :nature, :string
    add_column :accounts, :transactions_count, :integer
  end
end
