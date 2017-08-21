class Contact < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true

  def Contact.find_by_token(token_id)
    return Contact.find(token_id)
  end
end
