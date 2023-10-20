require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe 'GET /top' do
    it 'renders the top template' do
      get root_path
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:top)
      end
    end
  end

  describe 'GET /site_policy' do
    it 'renders the site_policy template' do
      get site_policy_path
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:site_policy)
      end
    end
  end

  describe 'GET /privacy_policy' do
    it 'renders the privacy_policy template' do
      get privacy_policy_path
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:privacy_policy)
      end
    end
  end
end
