require 'rails_helper'

RSpec.describe 'Organizations API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:headers) { valid_headers.except('Authorization') }
 
  describe 'GET /organizations/:id/organizations_users' do
    context "when the user is not a member of the organization" do 
      it "doesn't show other members of the organization" do
        org = create_list(:organization, 3).first
        create :user, :member1
        create :user, :member2
        user = create :user, :member3
    
        get "/organizations/#{org.id}/organizations_users", headers: valid_headers(user)

        expect(response.status).to eq(401)
        expect(response.body).to eq("Unauthorized request")
      end
    end

    context "when the user is a member of the organization" do 
      it "shows all members of the organization" do
        org = create_list(:organization, 3).first
        user = create :user, :member1
        create :user, :member2
        create :user, :member3
        get "/organizations/#{org.id}/organizations_users", headers: valid_headers(user)

        expect(response.status).to eq(200)
        expect(Organization.find(org.id).users.count).to eq(2)
      end
    end
  end

  describe 'POST /organizations/:id/organizations_users' do
    it "doesn't create association with current user and the organization when user not logged in" do
      org = create_list(:organization, 3).first
      user = create :user, :member1
  
      post "/organizations/#{org.id}/organizations_users"

      expect(response.status).to eq(422)
      expect(response.body).to eq("Missing token")
    end

    it "creates association with current user and the organization when user logged in" do
      org = create_list(:organization, 3).first
      user = create :user, :member1

      post "/organizations/#{org.id}/organizations_users", headers: valid_headers(user)
      
      json = JSON.parse(response.body)
      expect(json['organization_id']).to eq(org.id)
      expect(json['user_id']).to eq(user.id)
      expect(response.status).to eq(201)
    end
  end
end