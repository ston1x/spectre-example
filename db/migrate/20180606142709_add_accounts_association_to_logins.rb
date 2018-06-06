class AddAccountsAssociationToLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :account_id
      t.belongs_to :login, foreign_key: "login_id"
      t.timestamps
    end
  end
end
