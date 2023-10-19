require 'rails_helper'

RSpec.describe StampRalliesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:stamp_rally_params) { FactoryBot.attributes_for(:stamp_rally) }

  describe '#index' do
    before { get :index }
    
    it { expect(response).to have_http_status '200' }
  end

  describe '#show' do
    let(:stamp_rally) { FactoryBot.create(:stamp_rally) }

    before { get :show, params: { id: stamp_rally.id } }

    it { expect(response).to be_successful }
  end

  shared_examples_for 'adds a stamp rally' do
    it 'adds a stamp rally' do
      expect {
        post :create, params: { stamp_rally: stamp_rally_params }
      }.to change(user.stamp_rallies, :count).by(1)
    end
  end

  shared_examples_for 'does not create a stamp rally' do
    it 'does not create a stamp rally' do
      expect {
        post :create, params: { stamp_rally: stamp_rally_params }
      }.not_to change(StampRally, :count)
    end
  end

  describe '#create' do
    context 'as an authenticated user' do
      before { sign_in user }

      context 'with valid attributes' do
        it 'adds a stamp rally' do
          expect {
            post :create, params: { stamp_rally: stamp_rally_params }
          }.to change(user.stamp_rallies, :count).by(1)
        end

        %i[public_open with_image with_tag].each do |trait|
          context "when #{trait}" do
            let(:stamp_rally_params) { FactoryBot.attributes_for(:stamp_rally, trait) }
            it_behaves_like 'adds a stamp rally'
          end
        end
      end

      context 'with invalid attributes' do
        %i[without_title without_stamp_name without_stamp_sticker without_stamp_location].each do |trait|
          context "when #{trait}" do
            let(:stamp_rally_params) { FactoryBot.attributes_for(:stamp_rally, trait) }
            it_behaves_like 'does not create a stamp rally'
          end
        end
      end
    end

    context 'as a guest' do
      before { post :create, params: { stamp_rally: stamp_rally_params } }

      it { expect(response).to have_http_status '302' }
      it { expect(response).to redirect_to '/users/sign_in' }
    end
  end

  describe '#update' do
    let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: user) }

    context 'as an authorized user' do
      before do
        sign_in user
        patch :update, params: { id: stamp_rally.id, stamp_rally: stamp_rally_params.merge(title: 'New Stamp Rally') }
      end

      it { expect(stamp_rally.reload.title).to eq 'New Stamp Rally' }
    end

    context 'as an unauthorized user' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: other_user, title: 'Same Stamp Rally') }

      before { sign_in user }

      it 'does not update the stamp rally' do
        expect {
          patch :update, params: { id: stamp_rally.id, stamp_rally: stamp_rally_params }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'as a guest' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally) }

      before { patch :update, params: { id: stamp_rally.id, stamp_rally: stamp_rally_params } }

      it { expect(response).to have_http_status '302' }
      it { expect(response).to redirect_to '/users/sign_in' }
    end
  end

  describe '#destroy' do
    context 'as an authorized user' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: user) }

      before { sign_in user }

      it 'deletes the stamp rally' do
        expect {
          delete :destroy, params: { id: stamp_rally.id }
        }.to change(user.stamp_rallies, :count).by(-1)
      end
    end

    context 'as an unauthorized user' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: other_user) }

      before { sign_in user }

      it 'does not delete the stamp rally' do
        expect {
          delete :destroy, params: { id: stamp_rally.id }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'as a guest' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally) }

      before { delete :destroy, params: { id: stamp_rally.id } }

      it { expect(response).to have_http_status '302' }
      it { expect(response).to redirect_to '/users/sign_in' }
      it 'does not delete the stamp rally' do
        expect(StampRally.count).to eq 1
      end
    end
  end
end
