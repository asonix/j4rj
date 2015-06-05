class User < ActiveRecord::Base
  has_many :roles
  has_many :permissions, through: :roles
  accepts_nested_attributes_for :permissions

  has_secure_password

  validates :password, confirmation: true, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  def has_permission?(permission)
    !self.permissions.find_by(name: permission).nil?
  end

end
