require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  render_views
  let(:student) { create(:student) }
  let(:sample_group) { create(:group, creator_id: student.id) }
  let(:valid_group_params) { attributes_for(:group) }
  let(:invalid_group_params) { attributes_for(:group, course: nil) }

  describe 'GET #show' do
    it 'assigns the requested group to @group' do
      get :show, params: { id: sample_group.id }
      expect(assigns(:group)).to eq(sample_group)
    end

    it 'renders the :show template' do
      get :show, params: { id: sample_group.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'when student is logged in' do
      before { session[:student_id] = student.id }

      it 'assigns a new Group to @group' do
        get :new
        expect(assigns(:group)).to be_a_new(Group)
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
        it 'creates a new group' do
          expect {
            post :create, params: { group: valid_group_params.merge(creator_id: student.id) }
          }.to change(Group, :count).by(1)
        end

        it 'redirects to root path' do
          post :create, params: { group: valid_group_params.merge(creator_id: student.id) }
          expect(response).to redirect_to root_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new post' do
          expect {
            post :create, params: { group: invalid_group_params }
          }.not_to change(Group, :count)
        end

        it 're-renders the :new template' do
          post :create, params: { group: invalid_group_params }
          expect(response).to render_template :new
        end
      end
    end

    context 'when student is not logged in' do
      it 'redirects to login path' do
        post :create, params: { group: valid_group_params }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #apply' do
    let(:sample_group2) { create(:group, creator_id: student.id, capacity: 2) }
    let(:other_student) { create(:student) }

    context 'when student is not the creator' do
      before {session[:student_id] = other_student.id}
      it 'creates an application' do
        expect {
          post :apply, params: { id: sample_group2.id }
        }.to change(Application, :count).by(1)
      end

      it 'redirects to the group path with a notice' do
        post :apply, params: { id: sample_group2.id }
        expect(response).to redirect_to(group_path(sample_group2))
        expect(flash[:notice]).to be_present
      end
    end

    context 'when student is the creator' do
      before { session[:student_id] = student.id }

      it 'does not create an application' do
        expect {
          post :apply, params: { id: sample_group2.id }
        }.not_to change(Application, :count)
      end

      it 'redirects to the group path with an alert' do
        post :apply, params: { id: sample_group2.id }
        expect(response).to redirect_to(group_path(sample_group2))
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "POST #accept_application" do
  before { session[:student_id] = student.id }
    let(:application) { create(:application, group: sample_group, student: student) }

    it "accepts an application" do
      post :accept_application, params: { id: application.id }
      expect(application.reload.application_status).to eq('accepted')
      expect(response).to redirect_to(group_path(application.group))
    end
  end

  describe "POST #reject_application" do
  before { session[:student_id] = student.id }
    let(:application) { create(:application, group: sample_group, student: student) }

    it "rejects an application" do
      post :reject_application, params: { id: application.id }
      expect(application.reload.application_status).to eq('rejected')
      expect(response).to redirect_to(group_path(application.group))
    end
  end

  describe 'POST #close' do
    it 'deletes the group from the database' do
      expect {
        delete :close, params: { id: sample_group.id }
      }.to change(Group, :count).by(1)
    end
  end

end