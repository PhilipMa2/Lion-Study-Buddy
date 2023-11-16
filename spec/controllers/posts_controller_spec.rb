require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views
  let(:student) { create(:student) }
  let(:sample_post) { create(:post, creator_id: student.id) }
  let(:valid_post_params) { attributes_for(:post) }
  let(:invalid_post_params) { attributes_for(:post, course: nil) }

  describe 'GET #show' do
    it 'assigns the requested post to @post' do
      get :show, params: { id: sample_post.id }
      expect(assigns(:post)).to eq(sample_post)
    end

    it 'renders the :show template' do
      get :show, params: { id: sample_post.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'when student is logged in' do
      before { session[:student_id] = student.id }

      it 'assigns a new Post to @post' do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    context 'when student is not logged in' do
      it 'redirects to login path' do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #create' do
    context 'when student is logged in' do
      before { session[:student_id] = student.id }

      context 'with valid attributes' do
        it 'creates a new post' do
          expect {
            post :create, params: { post: valid_post_params.merge(creator_id: student.id) }
          }.to change(Post, :count).by(1)
        end

        it 'redirects to root path' do
          post :create, params: { post: valid_post_params.merge(creator_id: student.id) }
          expect(response).to redirect_to root_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new post' do
          expect {
            post :create, params: { post: invalid_post_params }
          }.not_to change(Post, :count)
        end

        it 're-renders the :new template' do
          post :create, params: { post: invalid_post_params }
          expect(response).to render_template :new
        end
      end
    end

    context 'when student is not logged in' do
      it 'redirects to login path' do
        post :create, params: { post: valid_post_params }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #apply' do
    let(:sample_post2) { create(:post, creator_id: student.id, capacity: 2) }
    let(:other_student) { create(:student) }

    context 'when student is not the creator' do
      before {session[:student_id] = other_student.id}
      it 'creates an application' do
        expect {
          post :apply, params: { id: sample_post2.id }
        }.to change(StudentAttendPost, :count).by(1)
      end

      it 'redirects to the post path with a notice' do
        post :apply, params: { id: sample_post2.id }
        expect(response).to redirect_to(post_path(sample_post2))
        expect(flash[:notice]).to be_present
      end
    end

    context 'when student is the creator' do
      before { session[:student_id] = student.id }

      it 'does not create an application' do
        expect {
          post :apply, params: { id: sample_post2.id }
        }.not_to change(StudentAttendPost, :count)
      end

      it 'redirects to the post path with an alert' do
        post :apply, params: { id: sample_post2.id }
        expect(response).to redirect_to(post_path(sample_post2))
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "POST #accept_application" do
  before { session[:student_id] = student.id }
    let(:application) { create(:student_attend_post, post: sample_post, student: student) }

    it "accepts an application" do
      post :accept_application, params: { id: application.id }
      expect(application.reload.apply_status).to eq('accepted')
      expect(response).to redirect_to(post_path(application.post))
    end
  end

  describe "POST #reject_application" do
  before { session[:student_id] = student.id }
    let(:application) { create(:student_attend_post, post: sample_post, student: student) }

    it "rejects an application" do
      post :reject_application, params: { id: application.id }
      expect(application.reload.apply_status).to eq('rejected')
      expect(response).to redirect_to(post_path(application.post))
    end
  end

  describe 'POST #close' do
    before { session[:student_id] = student.id }
    it 'updates the post status to close' do
      post :close, params: { id: sample_post.id }
      sample_post.reload
      expect(sample_post.post_status).to eq('close')
    end

    it 'redirects to post path' do
      post :close, params: { id: sample_post.id }
      expect(response).to redirect_to post_path(sample_post)
    end
  end
end