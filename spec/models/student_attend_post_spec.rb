require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:creator).class_name('Student').with_foreign_key('creator_id') }
  it { should have_many(:student_attend_posts) }
  it { should have_many(:students).through(:student_attend_posts) }

  it { should validate_presence_of(:course) }
  it { should validate_presence_of(:tag) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:capacity) }
end
