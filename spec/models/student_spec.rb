require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many(:groups).with_foreign_key('creator_id') }
  it { should have_many(:applications) }
  it { should have_many(:applied_groups).through(:applications).source(:group) }

  describe '.authenticate' do
    let!(:student) { create(:student, email: 'test@example.com', passcode: 'secret') }

    it 'authenticates with correct email and passcode' do
      expect(Student.authenticate('test@example.com', 'secret')).to eq(student)
    end

    it 'returns nil with incorrect passcode' do
      expect(Student.authenticate('test@example.com', 'wrong')).to be_nil
    end

    it 'returns nil with unknown email' do
      expect(Student.authenticate('unknown@example.com', 'secret')).to be_nil
    end
  end

  describe '#applied_groups_with_status' do
    let(:student) { create(:student) }
    let!(:group) { create(:group) }
    let!(:application) { create(:application, student: student, group: group) }

    it 'returns groups student has applied to' do
      expect(student.applications).to include(application)
    end
  end

  describe 'selected_time_slots' do
    let!(:student) { create(:student) }
    let!(:timeslot) { create(:time_slot, student: student, available_time: 1) }

    it 'returns an array of available times' do
      expect(student.selected_time_slots).to match_array([1])
    end
  end
end
