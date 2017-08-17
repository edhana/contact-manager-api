require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  let(:valid_contact){
    {:firstname => Faker::Name.first_name,
     :lastname => Faker::Name.last_name,
     :email => Faker::Internet.email
    }
  }

  before(:each) do
    @contact = Contact.create(valid_contact)
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, :params => {:contact => Contact.new(valid_contact).as_json}
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "returns http success" do
      put :update, :params => {:id=> @contact.id, :contact => @contact.as_json}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      delete :destroy, :params => {:id=> @contact.id}
      expect(response).to have_http_status(:success)
    end
  end
end
