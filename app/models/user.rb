class User < ApplicationRecord
  has_secure_password

  has_many :organizations_users
  has_many :organizations, :through => :organizations_users
  validates_presence_of :email, :password_digest
end
