require 'rails_helper'

RSpec.describe TimeSlotsController, type: :controller do
    render_views
    let(:student) { create(:student) }
    let(:session) { }
    before do
        allow(controller).to receive(:current_student).and_return(student)
    end
    describe 'POST #create' do 
        it 'destroys existing time slots and creates new ones' do
            existing_time_slots = create_list(:time_slot, 3, student: student)
            selected_time_slots = ['1', '2', '3']
            post :create, params: {selected_time_slots: selected_time_slots}
            expect(response).to redirect_to(:profile)

            expect(flash[:notice]).to eq('Schedule saved successfully')
            selected_time_slots.each do |slot|
                expect(TimeSlot.exists?(available_time: slot.to_i, student: student)).to be_truthy
            end
        end
    end
end