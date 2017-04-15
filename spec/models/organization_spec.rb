require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:organizations_users) }
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
end