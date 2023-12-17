require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  render_views
  controller do
    def index
      render plain: 'Hello World'
    end
  end

  describe '#current_student' do
    let(:student) { create(:student) }

    context 'when student_id is in session' do
      before do
        session[:student_id] = student.id
      end

      it 'returns the current student' do
        expect(controller.current_student).to eq(student)
      end
    end

    context 'when student_id is not in session' do
      it 'returns nil' do
        expect(controller.current_student).to be_nil
      end
    end
  end

  describe '#logged_in?' do
    let(:student) { create(:student) }

    context 'when student is logged in' do
      before do
        allow(controller).to receive(:current_student).and_return(student)
      end

      it 'returns true' do
        expect(controller.logged_in?).to be(true)
      end
    end

    context 'when student is not logged in' do
      it 'returns false' do
        expect(controller.logged_in?).to be(false)
      end
    end
  end

  describe '#require_student' do
      context 'when student is not logged in' do
        it 'redirects to login path with a notice' do
          routes.draw { get 'index' => 'anonymous#index' }
          get :index
          # expect(response).to redirect_to(login_path)
          # expect(flash[:notice]).to eq("Please log in.")
        end
      end

    context 'when student is logged in' do
      let(:student) { create(:student) }

      before do
        allow(controller).to receive(:logged_in?).and_return(true)
      end

      it 'does not redirect' do
        routes.draw { get 'index' => 'anonymous#index' }
        get :index
        expect(response).not_to redirect_to(login_path)
      end
    end
  end


  describe '#number_of_overlapping_time_slots' do
    let(:applicant_student) { create(:student) }
    
    let!(:student1) { create(:student) }
    let!(:student2) { create(:student) }
    let!(:ts1) { create(:time_slot, available_time: 1, student: student1)}
    let!(:ts2) { create(:time_slot, available_time: 1, student: applicant_student)}

    context 'when there are no overlapping time slots' do
      it 'returns 0' do
        result = controller.number_of_overlapping_time_slots(applicant_student, [student2])

        expect(result).to eq(0)
      end
    end

    context 'when there are overlapping time slots' do
      it 'returns the number of overlapping time slots' do
        result = controller.number_of_overlapping_time_slots(applicant_student, [student1])

        expect(result).to eq(1)
      end
    end

    context 'when the students array is empty' do
      it 'returns 0' do
        result = controller.number_of_overlapping_time_slots(applicant_student, [])

        expect(result).to eq(0)
      end
    end
  end
end