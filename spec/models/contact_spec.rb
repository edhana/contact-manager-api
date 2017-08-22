require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:valid_contact){
    {:firstname => Faker::Name.first_name,
    :lastname => Faker::Name.last_name,
    :email => Faker::Internet.email}
  }

  it "with valid_attributes is saved" do
    expect{
      Contact.create(valid_contact)
    }.to change(Contact, :count).by(1)
  end

  it "with invalid attributes is not saved" do
    expect{Contact.create(invalid_contact).not_to change(Contact, :count).by(1)}
  end

  it "use token as search parameter"
end
