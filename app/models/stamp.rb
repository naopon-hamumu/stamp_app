class Stamp < ApplicationRecord
  mount_uploader :sticker, StampStickerUploader
  belongs_to :stamp_rally, inverse_of: :stamps
end
