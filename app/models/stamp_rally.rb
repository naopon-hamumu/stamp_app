class StampRally < ApplicationRecord
  belongs_to :user
  mount_uploader :image, StampRallyImageUploader

  enum visibility: { public_open: 0, private_open: 1 }

  validates :title, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 500 }
end
