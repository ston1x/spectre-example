class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: "account_id"
end
