class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :stamp_rally
  has_many :participants_stamps
  has_many :stamps, through: :participants_stamps

  validates :user_id, uniqueness: { scope: :stamp_rally_id }
end
