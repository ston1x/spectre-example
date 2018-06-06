class AddTransactionsAssociationToAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id
      t.belongs_to :account, foreign_key: "account_id"
      t.timestamps
    end
  end
end
