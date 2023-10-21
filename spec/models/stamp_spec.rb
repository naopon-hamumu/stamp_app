require 'rails_helper'

RSpec.describe Stamp, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:name).is_at_most(25) }
    it { is_expected.to validate_presence_of :sticker }

    context 'with geocoding' do
      it 'validates the presence of latitude and logitude' do
        stamp_without_location = build(:stamp, :without_location)
        expect(stamp_without_location).not_to be_valid
        expect(stamp_without_location.errors.messages[:base]).to include('マップを入力してください')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:stamp_rally).inverse_of(:stamps) }
    it { is_expected.to have_many(:participants_stamps).dependent(:destroy) }
    it { is_expected.to have_many(:participants).through(:participants_stamps) }
  end
end
