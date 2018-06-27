class Account < ApplicationRecord
  belongs_to :login, foreign_key: 'login_id'
  has_many :transactions, dependent: :destroy
end
