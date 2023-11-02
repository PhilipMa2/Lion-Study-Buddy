require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views
  describe 'GET #index' do
    let!(:posts) { create_list(:post, 5) }

    before do
      get :index
    end

    it 'assigns @posts' do
      expect(assigns(:posts)).to eq(posts)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status(200)
    end
  end
end