class SnsCredential < ApplicationRecord
  belongs_to :user

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true, uniqueness: { scope: :user_id }
end
