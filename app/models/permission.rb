class Permission < ActiveRecord::Base
  has_many :roles
  has_many :users, through: :roles
end
