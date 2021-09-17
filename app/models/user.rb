class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, on: :create
  validates :password, length: { in: 5..10 }
end
