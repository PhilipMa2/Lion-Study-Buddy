require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views
  let(:student) { create(:student) }
  let(:sample_post) { create(:post, creator_name: student.name, creator_id: student.id) }
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
            post :create, params: { post: valid_post_params.merge(creator_name: student.name, creator_id: student.id) }
          }.to change(Post, :count).by(1)
        end

        it 'redirects to root path' do
          post :create, params: { post: valid_post_params.merge(creator_name: student.name, creator_id: student.id) }
          expect(response).to redirect_to root_path
        end
      end

      # context 'with invalid attributes' do
      #   it 'does not save the new post' do
      #     expect {
      #       post :create, params: { post: invalid_post_params }
      #     }.not_to change(Post, :count)
      #   end

      #   it 're-renders the :new template' do
      #     post :create, params: { post: invalid_post_params }
      #     expect(response).to render_template :new
      #   end
      # end
    end

    context 'when student is not logged in' do
      it 'redirects to login path' do
        post :create, params: { post: valid_post_params }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #attend' do
    context 'when student is logged in' do
      before { session[:student_id] = student.id }

      it 'creates a new StudentAttendPost record' do
        expect {
          post :attend, params: { id: sample_post.id }
        }.to change(StudentAttendPost, :count).by(1)
      end

      it 'redirects to post path' do
        post :attend, params: { id: sample_post.id }
        expect(response).to redirect_to post_path(sample_post)
      end
    end

    context 'when student is not logged in' do
      it 'redirects to login path' do
        post :attend, params: { id: sample_post.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #confirm' do
    it 'updates the post status to confirmed' do
      post :confirm, params: { id: sample_post.id }
      sample_post.reload
      expect(sample_post.status).to eq('confirmed')
    end

    it 'redirects to post path' do
      post :confirm, params: { id: sample_post.id }
      expect(response).to redirect_to post_path(sample_post)
    end
  end

  describe 'POST #cancel' do
    it 'updates the post status to cancelled' do
      post :cancel, params: { id: sample_post.id }
      sample_post.reload
      expect(sample_post.status).to eq('cancelled')
    end

    it 'redirects to post path' do
      post :cancel, params: { id: sample_post.id }
      expect(response).to redirect_to post_path(sample_post)
    end
  end
end
