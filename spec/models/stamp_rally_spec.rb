require 'rails_helper'

RSpec.describe StampRally, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_length_of(:title).is_at_most(50) }
    it { is_expected.to validate_length_of(:description).is_at_most(500)}
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:stamps).inverse_of(:stamp_rally).dependent(:destroy) }
    it { is_expected.to have_many(:stamp_rally_tags).dependent(:destroy) }
    it { is_expected.to have_many(:tags).through(:stamp_rally_tags) }
  end
end
