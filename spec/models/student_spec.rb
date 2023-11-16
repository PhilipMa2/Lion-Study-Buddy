require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many(:posts).with_foreign_key('creator_id') }
  it { should have_many(:student_attend_posts) }
  it { should have_many(:applied_posts).through(:student_attend_posts).source(:post) }

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

  describe '#applied_posts_with_status' do
    let(:student) { create(:student) }
    let!(:post) { create(:post) }
    let!(:student_attend_post) { create(:student_attend_post, student: student, post: post) }

    it 'returns posts student has applied to' do
      expect(student.applied_posts_with_status).to include(student_attend_post)
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
