require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  # let(:valid_attributes) do
    # attributes_for(:user, password_confirmation: user.password, organizations_users: 1)
  # end
  # User signup test suite
  describe 'POST /signup' do

    context 'when valid request' do
      it 'creates a new user' do 
        org = create :organization

        post '/signup', params: {email: user.email, password: user.password, password_confirmation:user.password, organization_ids: org.id}.to_json, headers: headers
        expect(response).to have_http_status(201)
        json = JSON.parse(response.body)
        expect(json['message']).to match(/Account created successfully/)
        expect(json['auth_token']).not_to be_nil
        expect(User.last.organization_ids).to eq([org.id])
      end
    end


    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }
      it 'does not create a new user' do
        expect(response).to have_http_status(422)
        expect(response.body)
          .to match(/Validation failed: Password can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end