class User < ApplicationRecord
  has_many :organizations_users
  has_many :organizations, :through => :organizations_users
  validates_presence_of :email
  validates_presence_of :password_digest
end
