require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:organizations_users) }
  it { should have_many(:organizations) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
