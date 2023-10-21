require 'rails_helper'

RSpec.describe StampRallyTag, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:stamp_rally) }
    it { is_expected.to belong_to(:tag) }
  end
end
