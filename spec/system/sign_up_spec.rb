require 'rails_helper'

RSpec.describe "SignUp", type: :system do
  include ActiveJob::TestHelper

  scenario 'user successfully signs up' do
    visit root_path
    click_link '登録'

    perform_enqueued_jobs do
      expect {
        fill_in 'ユーザー名', with: '松島聡'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
      }.to change(User, :count).by(1)

      aggregate_failures do
        expect(current_path).to eq stamp_rallies_path
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
  end
end
