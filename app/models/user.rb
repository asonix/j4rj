class User < ActiveRecord::Base
  has_many :roles
  has_many :permissions, through: :roles

  has_secure_password

  validates_confirmation_of :password

end
