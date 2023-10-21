require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'associations' do
    it { is_expected.to have_many(:stamp_rally_tags).dependent(:destroy) }
    it { is_expected.to have_many(:stamp_rallies).through(:stamp_rally_tags)}
  end
end
