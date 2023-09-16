class ParticipantsStamp < ApplicationRecord
  belongs_to :participant
  belongs_to :stamp

  validates :participant, presence: true
  validates :stamp, presence: true
end
