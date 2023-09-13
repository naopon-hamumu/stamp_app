class Stamp < ApplicationRecord
  mount_uploader :sticker, StampStickerUploader
  belongs_to :stamp_rally, inverse_of: :stamps

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :name, length: { maximum: 25 }, presence: true
  validates :sticker, presence: true
end
