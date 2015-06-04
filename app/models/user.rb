class User < ActiveRecord::Base
  has_many :roles
  has_many :permissions, through: :roles

  has_secure_password

  validates_confirmation_of :password
  validates_confirmation_of :new_password

  def has_permission?(permission)
    self.permissions.find_by(name: permission).nil?
  end

end
