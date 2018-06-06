class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.integer :login_id
      t.belongs_to :user, foreign_key: "user_id"
      t.timestamps
    end
  end
end
