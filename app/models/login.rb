class Login < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :accounts, dependent: :destroy
end
