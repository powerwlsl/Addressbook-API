require 'rails_helper'

RSpec.describe 'Organizations API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:headers) { valid_headers.except('Authorization') }

  # Test for GET /organizations
  describe 'GET /organizations' do
    it 'returns organizations' do
      create_list(:organization, 3)

      get '/organizations'

      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
      expect(response).to have_http_status(200)
    end
  end

  # Test for POST /organizations
  describe 'POST /organizations' do
    it "doesn't allow a non-admin user to create" do
      post "/organizations", params: {name: "Org"}.to_json, headers: valid_headers

      expect(response.status).to eq(401)
      expect(response.body).to eq("Unauthorized request")
    end

    it "allows a admin user to create" do
      user = create :user, :admin

      post "/organizations", params: {name: "Org"}.to_json,
       headers: valid_headers(user)

      expect(response.status).to eq(201)
      json = JSON.parse(response.body)
      expect(json['name']).to eq("Org")

      expect(Organization.find_by_name("Org")).to be_present
    end
  end

  # Test for DELETE /organizations
  describe 'DELETE /organizations' do
    it "doesn't allow a non-admin user to delete" do
      org = create :organization
      delete "/organizations/#{org.id}", headers: valid_headers

      expect(response.status).to eq(401)
      expect(response.body).to eq("Unauthorized request")

      expect(org.reload).to be_present
    end

    it "allows an admin user to delete" do
      org = create :organization
      user = create :user, :admin
      delete "/organizations/#{org.id}", headers: valid_headers(user)

      expect(response.status).to eq(204)
      expect{ org.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PUT /organizations/:id' do
    it "doesn't allow a non-admin user to update" do
      org = create :organization
      put "/organizations/#{org.id}", params: {name: "New Company"}.to_json, headers: valid_headers
      expect(response.status).to eq(401)
      expect(response.body).to eq("Unauthorized request")
    end
    it "allows an admin user to update" do
      org = create :organization
      user = create :user, :admin

      put "/organizations/#{org.id}", params: {name: "New Company"}.to_json, headers: valid_headers(user)

      expect(response.status).to eq(204)
      expect(Organization.find_by_name("New Company")).to be_present
    end
  end
end
