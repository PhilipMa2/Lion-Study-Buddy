require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('creator_id') }
    it { should have_many(:student_attend_posts) }
    it { should have_many(:attended_posts).through(:student_attend_posts).source(:post) }
  end

  describe '.authenticate' do
    let!(:student) { FactoryBot.create(:student, email: 'test@example.com', passcode: 'securepass') }

    context 'with valid credentials' do
      it 'returns the student' do
        expect(Student.authenticate('test@example.com', 'securepass')).to eq(student)
      end
    end

    context 'with invalid email' do
      it 'returns nil' do
        expect(Student.authenticate('wrong@example.com', 'securepass')).to be_nil
      end
    end

    context 'with invalid passcode' do
      it 'returns nil' do
        expect(Student.authenticate('test@example.com', 'wrongpass')).to be_nil
      end
    end
  end
end