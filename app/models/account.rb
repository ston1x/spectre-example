class Account < ApplicationRecord
  belongs_to :login, foreign_key: "login_id"
end
