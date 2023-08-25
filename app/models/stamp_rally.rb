class StampRally < ApplicationRecord
  mount_uploader :image, StampRallyImageUploader

  belongs_to :user
  has_many :stamps, inverse_of: :stamp_rally, dependent: :destroy
  accepts_nested_attributes_for :stamps, allow_destroy: true

  enum visibility: { public_open: 0, private_open: 1 }

  validates :title, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 500 }
end
