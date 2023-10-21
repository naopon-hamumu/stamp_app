require 'rails_helper'

RSpec.describe "StampRallies", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:stamp_rally) { FactoryBot.create(:stamp_rally) }
  let(:participant) { FactoryBot.create(:participant) }

  before { sign_in user }

  scenario 'user creates a stamp rally' do
    visit stamp_rallies_path
    find('.navbar-toggler').click
    click_link 'スタンプラリー新規作成'

    fill_in 'タイトル', with: 'Test'
    fill_in '説明', with: 'I love So!'
    fill_in 'タグ', with: 'Tag1, Tag2'
    attach_file('イメージ画像', "#{Rails.root}/spec/files/fuma.jpeg")
    select '非公開', from: '公開範囲設定'
    fill_in 'スタンプの名前', with: 'stamp'
    attach_file('スタンプの画像', "#{Rails.root}/spec/files/fuma.jpeg")
    find('.address').set('Test Store')
    find('input[name="stamp_rally[stamps_attributes][0][latitude]"]', visible: false).set('35.6895')
    find('input[name="stamp_rally[stamps_attributes][0][longitude]"]', visible: false).set('139.6917')
    latitude_input = find('input[name="stamp_rally[stamps_attributes][0][latitude]"]', visible: false)
    longitude_input = find('input[name="stamp_rally[stamps_attributes][0][longitude]"]', visible: false)
    expect(latitude_input.value).to eq '35.6895'
    expect(longitude_input.value).to eq '139.6917'

    expect { click_button '登録する' }.to change(user.stamp_rallies, :count).by(1)
  end

  scenario 'user can participate & unparticipate a stamp rally' do
    visit stamp_rally_path(stamp_rally)
    expect(page).to_not have_link('参加をやめる')
    expect(page).to_not have_button('スタンプゲット')

    expect{
      click_link '参加する'
    }.to change(user.participate_stamp_rallies, :count).by(1)
    expect(page).to have_link('参加をやめる')
    expect(page).to have_button('スタンプゲット')

    expect{
      click_link '参加をやめる'
    }.to change(user.participate_stamp_rallies, :count).by(-1)
    expect(page).to have_link('参加する')
    expect(page).to_not have_button('スタンプゲット')
  end
end
