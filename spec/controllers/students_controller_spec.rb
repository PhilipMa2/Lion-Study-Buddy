require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  render_views
  let(:student) { create(:student) }
  let(:other_student) { create(:student) }
  let(:another_student) { create(:student) }

  describe 'GET #show' do
    before do
      @current_student = student
      allow(controller).to receive(:current_student).and_return(@current_student)
    end
    it 'assigns the requested student to @student' do
      get :show, params: { id: other_student.id }
      expect(assigns(:student)).to eq(other_student)
        expect(assigns(:can_view_full_profile)).to be false
    end

    it 'returns true if there is an accepted application from current student or to the current student' do 
      post_student = create(:group, creator_id: student.id)
      create(:application, student: other_student, group: post_student, application_status: 'accepted')
      result = controller.can_view_full_profile?(other_student)
      expect(result).to be_truthy
    end

    it 'returns true if there is an accepted application from a third student' do
      post_student = create(:group, creator_id: other_student.id)
      create(:application, student: student, group: post_student, application_status: 'accepted')
      create(:application, student: another_student, group: post_student, application_status: 'accepted')
      result = controller.can_view_full_profile?(another_student)
      expect(result).to be_truthy
    end
  end

  describe 'GET #profile' do
    context 'when student is logged in' do
      let!(:created_posts) { create_list(:group, 3, creator_id: student.id) }
      let!(:attended_posts) { create_list(:group, 2) }
      let!(:attendances) { attended_posts.map { |post| create(:application, student: student, group: post) } }
      let!(:time_slots) { create_list(:time_slot, 1, student: student)}
      
      before do
        session[:student_id] = student.id
        # attended_posts.each { |post| create(:student_attend_post, student: student, post: post) }
        get :profile
      end

      it 'assigns @student' do
        expect(assigns(:student)).to eq(student)
      end

    #   it 'assigns @created_posts' do
    #     expect(assigns(:created_posts)).to match_array(created_posts)
    #   end

    #   it 'assigns @applied_posts' do
    #     expect(assigns(:applied_posts)).to match_array(attendances)
    #   end

      it 'assigns @time_slots' do
        expect(assigns(:time_slots)).to match_array(time_slots)
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

    describe 'PATCH #edit' do 
        before do
            session[:student_id] = student.id
            # attended_posts.each { |post| create(:student_attend_post, student: student, post: post) }
            get :profile
        end
        context 'with valid params' do
            it 'updates the student and redirects to the profile path' do
                patch :update, params: {id: student.id, student: { name: 'New Name', age: 20}}
                student.reload
                expect(student.name).to eq('New Name')
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(profile_path(student))
                expect(flash[:notice]).to eq('Profile updated successfully.')
            end
        end
    end

    describe 'POST #create_account' do
        context 'with valid params' do 
            it 'creates a new student account and redirects to login' do
                post :create_account, params: {
                    email: 'new@example.com',
                    password: '123456',
                    password_confirmation: '123456',
                    name: 'John Adams'
                }

                expect(response).to redirect_to(login_path)
                expect(response).to have_http_status(:found)

                new_student = Student.find_by(email: 'new@example.com')
                expect(new_student).to be_present 
            end
        end

        context 'with password mismatch' do
            it 'renders the create_account template' do
              post :create_account, params: {
                email: 'new@example.com',
                password: 'password123',
                password_confirmation: 'mismatchedpassword',
                name: 'John Doe'
              }
      
              expect(response).to render_template('sessions/create_account')
              expect(assigns(:student)).to be_nil
              expect(flash[:notice]).to match(/Please make sure your password entries match/)
            end
        end
    end
end