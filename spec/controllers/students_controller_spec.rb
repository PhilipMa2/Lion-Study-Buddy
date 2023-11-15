require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  render_views
  let(:student) { create(:student) }
  let(:other_student) { create(:student) }

  describe 'GET #show' do
    it 'assigns the requested student to @student' do
      get :show, params: { id: other_student.id }
      expect(assigns(:student)).to eq(other_student)
    end

    context 'when the current student cannot view full profile' do
      it 'sets @can_view_full_profile to false' do
        get :show, params: { id: other_student.id }
        expect(assigns(:can_view_full_profile)).to be false
      end
    end
  end

  describe 'GET #profile' do
    context 'when student is logged in' do
      let!(:created_posts) { create_list(:post, 3, creator: student) }
      let!(:attended_posts) { create_list(:post, 2) }
      let!(:attendances) { attended_posts.map { |post| create(:student_attend_post, student: student, post: post) } }

      before do
        session[:student_id] = student.id
        get :profile
      end

      it 'assigns @student' do
        expect(assigns(:student)).to eq(student)
      end

      it 'assigns @created_posts' do
        expect(assigns(:created_posts)).to match_array(created_posts)
      end

      it 'assigns @applied_posts' do
        expect(assigns(:applied_posts)).to match_array(attendances)
      end

      it 'renders the profile template' do
        expect(response).to render_template(:profile)
      end
    end

    context 'when student is not logged in' do
      it 'redirects to login path with a notice' do
        get :profile
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq("Please log in.")
      end
    end
  end
end