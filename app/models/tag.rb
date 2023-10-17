class Tag < ApplicationRecord
  has_many :stamp_rally_tags, dependent: :destroy
  has_many :stamp_rallies, through: :stamp_rally_tags

  before_validation :downcase_name
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
