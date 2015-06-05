class User < ActiveRecord::Base
  has_many :roles
  has_many :permissions, through: :roles

  has_secure_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def has_permission?(permission)
    self.permissions.find_by(name: permission).nil?
  end

end
