require 'rails_helper'

RSpec.describe "SignIn", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  scenario 'user signs in' do
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    aggregate_failures do
      expect(current_path).to eq stamp_rallies_path
      expect(page).to have_content 'ログインしました。'
    end
  end
end
