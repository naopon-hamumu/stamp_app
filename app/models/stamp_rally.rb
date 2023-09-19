class StampRally < ApplicationRecord
  mount_uploader :image, StampRallyImageUploader

  belongs_to :user
  has_many :stamps, inverse_of: :stamp_rally, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :participants_stamps, through: :participants, dependent: :destroy
  accepts_nested_attributes_for :stamps, allow_destroy: true

  enum visibility: { public_open: 0, unopen: 1 }

  validates :title, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 500 }

  def self.ransackable_associations(auth_object = nil)
    %w[participations stamps user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at description id image title updated_at user_id visibility]
  end
end
