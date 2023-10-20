require 'rails_helper'

RSpec.describe "StampRallies", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: user) }

  describe 'GET /index' do
    it 'renders the index template' do
      get stamp_rallies_path
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET /show' do
    it 'renders the show template' do
      get stamp_rally_path(stamp_rally)
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET /new' do
    context 'as an authenticated user' do
      it 'renders the new template' do
        sign_in user
        get new_stamp_rally_path
        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'as a guest' do
      it 'redirecs to the sign_in page' do
        get new_stamp_rally_path
        aggregate_failures do
          expect(response).to have_http_status '302'
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'POST /create' do
    context 'as an authenticated user' do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in user }

      shared_examples_for 'adds a stamp rally' do
        it 'adds a stamp rally' do
          expect {
            post stamp_rallies_path, params: { stamp_rally: stamp_rally_params }
          }.to change(user.stamp_rallies, :count).by(1)
        end

        it 'redirects to the created stamp rally' do
          post stamp_rallies_path, params: { stamp_rally: stamp_rally_params }
          expect(response).to redirect_to(StampRally.last)
        end
      end

      shared_examples_for 'does not create a stamp rally' do
        it 'does not create a stamp rally' do
          expect {
            post stamp_rallies_path, params: { stamp_rally: stamp_rally_params }
          }.not_to change(StampRally, :count)
        end

        it 'renders the new template' do
          post stamp_rallies_path, params: { stamp_rally: stamp_rally_params }
          expect(response).to render_template(:new)
        end
      end

      context 'with valid attributes' do
        let(:stamp_rally_params) { FactoryBot.attributes_for(:stamp_rally) }

        it_behaves_like 'adds a stamp rally'

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
  end

  describe 'GET /edit' do
    context 'as an authorized user' do
      before { sign_in user }

      it 'renders the edit template' do
        get edit_stamp_rally_path(stamp_rally)
        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'as an unauthorized user' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: other_user) }

      before { sign_in user }

      it 'raises active record error' do
        expect {
          get edit_stamp_rally_path(stamp_rally)
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'as a guest' do

      before { get edit_stamp_rally_path(stamp_rally) }

      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'PATCH /update' do
    context 'as an authorized user' do
      before do
        sign_in user
        stamp_rally_params = FactoryBot.attributes_for(:stamp_rally, title: 'Updated Stamp Rally')
        patch stamp_rally_path(stamp_rally), params: { id: stamp_rally.id, stamp_rally: stamp_rally_params }
      end

      it { expect(stamp_rally.reload.title).to eq 'Updated Stamp Rally' }
      it { expect(response).to redirect_to stamp_rally_path(stamp_rally) }
    end
  end

  describe 'DELETE /destroy' do
    context 'as an authorized user' do
      before { sign_in user }

      it 'deletes the stamp rally' do
        expect {
          delete stamp_rally_path(stamp_rally), params: { id: stamp_rally.id }
        }.to change(user.stamp_rallies, :count).by(-1)
      end
    end

    context 'as an unauthorized user' do
      let!(:stamp_rally) { FactoryBot.create(:stamp_rally, user: other_user) }
      
      before { sign_in user }

      it 'does not delete the stamp rally' do
        expect {
          delete stamp_rally_path(stamp_rally), params: { id: stamp_rally.id }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'as a guest' do
      it 'does not delete the stamp rally' do
        expect {
          delete stamp_rally_path(stamp_rally), params: { id: stamp_rally.id }
        }.to_not change(StampRally, :count)
      end

      it 'redirects to sign_in page' do
        delete stamp_rally_path(stamp_rally), params: { id: stamp_rally.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
