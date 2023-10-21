require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  describe 'associations' do
    it { is_expected.to have_many(:sns_credential).dependent(:destroy) }
    it { is_expected.to have_many(:stamp_rallies).dependent(:destroy) }
    it { is_expected.to have_many(:participants).dependent(:destroy) }
    it { is_expected.to have_many(:participate_stamp_rallies).through(:participants) }
    it { is_expected.to have_many(:get_stamps).through(:participants) }
  end
end
