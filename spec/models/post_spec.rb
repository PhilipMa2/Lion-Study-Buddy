require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:creator).class_name('Student') }
    it { should have_many(:student_attend_posts) }
    it { should have_many(:students).through(:student_attend_posts) }
  end

  describe 'status enum' do
    it 'defines a status enum with valid values' do
      is_expected.to define_enum_for(:status).with_values(
        pending: 'pending',
        confirmed: 'confirmed',
        cancelled: 'cancelled'
      ).backed_by_column_of_type(:string)
    end
  end
end