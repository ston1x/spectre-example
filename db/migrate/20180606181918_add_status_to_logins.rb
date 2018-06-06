class AddStatusToLogins < ActiveRecord::Migration[5.2]
  def change
    add_column :logins, :status, :string
  end
end
