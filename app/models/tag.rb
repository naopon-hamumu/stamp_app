class Tag < ApplicationRecord
  has_many :stamp_rally_tags, dependent: :destroy
  has_many :stamp_rallies, through: :stamp_rally_tags

  before_validation :downcase_name
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  private

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
