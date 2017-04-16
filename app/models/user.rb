class User < ApplicationRecord
  ADMIN_EMAILS = ["admin@admin.com"]
  
  has_secure_password

  has_many :organizations_users
  has_many :organizations, :through => :organizations_users
  validates_presence_of :email, :password_digest
  
  def admin?
    ADMIN_EMAILS.include? email
  end
end
