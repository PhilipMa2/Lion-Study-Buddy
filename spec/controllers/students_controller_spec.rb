require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  render_views
  let(:student) { create(:student) }

  describe 'GET #profile' do
    context 'when student is logged in' do
      let!(:created_posts) { create_list(:post, 3, creator: student) }
      let!(:attended_posts) { create_list(:post, 2) }
      
      before do
        # Simulate that student is logged in
        session[:student_id] = student.id
        # Simulate that student attended some posts
        attended_posts.each { |post| create(:student_attend_post, student: student, post: post) }

        get :profile
      end

      it 'assigns @student' do
        expect(assigns(:student)).to eq(student)
      end

      it 'assigns @created_posts' do
        expect(assigns(:created_posts)).to match_array(created_posts)
      end

      it 'assigns @applied_posts' do
        expect(assigns(:applied_posts)).to match_array(attended_posts)
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