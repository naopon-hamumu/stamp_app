require 'rails_helper'

RSpec.describe "Stamps", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    it 'renders the index template' do
      sign_in user
      get '/stamps'
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end
  end
end
