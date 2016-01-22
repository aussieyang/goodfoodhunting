class User < ActiveRecord::Base
  has_secure_password # gives 2 new methods for user object
  # 1. password
  # 2. authenticate
  has_many :likes
end
