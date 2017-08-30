require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  let(:valid_contact) do
    { firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      email: Faker::Internet.email }
  end

  let(:invalid_contact) do
    {
      firstname: '',
      lastname: '',
      email: ''
    }
  end

  before(:each) do
    @contact = Contact.create(valid_contact)
  end

  describe 'POST #create' do
    it 'returns http success' do
      post :create, params: { contact: Contact.new(valid_contact).as_json }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'application/json'
    end

    it 'return unprocessable entity for an invalid contact' do
      post :create, params: { contact: Contact.new(invalid_contact).as_json }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq 'application/json'
    end
  end

  describe 'PUT #update' do
    it 'returns http success' do
      put :update, params: { id: @contact.id, contact: @contact.as_json }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'application/json'
    end

    it 'return unprocessable entity for contact without id' do
      put :update, params: { contact: @contact.as_json }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq 'application/json'
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete :destroy, params: { id: @contact.id }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'application/json'
    end

    it 'return unprocessable entity for request without id' do
      delete :destroy
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq 'application/json'
    end
  end

  describe 'GET #token' do
    it 'returns a contact using token id' do
      get :find_by_token, params: { token_id: @contact.id }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'application/json'
    end

    it 'return unprocessable entity without a token id parameter' do
      expect { get ':find_by_token', params: {} }.to(
        raise_error(ActionController::UrlGenerationError)
      )
    end

    it 'return unprocessable entity with an invalid token id' do
      get :find_by_token, params: { token_id: 10_000_011 }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
