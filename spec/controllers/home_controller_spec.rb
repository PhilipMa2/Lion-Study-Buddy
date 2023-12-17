require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views
  describe 'GET #index' do
    let!(:group1) { create(:group, capacity: 10, course: 'Math', focus: 'Algebra')}
    let!(:group2) { create(:group, capacity: 15, course: 'Physics', focus: 'Mechanics')}

    before do
      get :index
    end
    context 'without any filters' do
      it 'assigns all groups to @groups' do
        get :index

        expect(assigns(:groups)).to match_array([group1, group2])
        expect(response).to render_template('index')
      end
    end

    context 'with capacity filter' do
      it 'assigns filtered groups to @groups' do
        get :index, params: { capacity: 12 }

        expect(assigns(:groups)).to eq([group1])
        expect(response).to render_template('index')
      end
    end

    context 'with course_search filter' do
      it 'assigns filtered groups to @groups' do
        get :index, params: { course_search: 'math' }

        expect(assigns(:groups)).to eq([group1])
        expect(response).to render_template('index')
      end
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status(200)
    end
  end
end