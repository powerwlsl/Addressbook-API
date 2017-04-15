class Organization < ApplicationRecord
  has_many :organizations_users
  has_many :users, :through => :organizations_users
  validates_presence_of :name
end
