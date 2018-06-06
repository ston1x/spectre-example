class AddColumnsToLogins < ActiveRecord::Migration[5.2]
  def change
    add_column :logins, :country_code, :string
    add_column :logins, :created_time, :string
  end
end
