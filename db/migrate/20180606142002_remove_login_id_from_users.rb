class RemoveLoginIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :login_id
  end
end
