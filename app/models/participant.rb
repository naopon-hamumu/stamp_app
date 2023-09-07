class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :stamp_rally

  validates :user_id, uniqueness: { scope: :stamp_rally_id }
end
