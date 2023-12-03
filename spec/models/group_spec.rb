require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should belong_to(:creator).class_name('Student').with_foreign_key('creator_id') }
  it { should have_many(:applications) }
  it { should have_many(:students).through(:applications) }

  it { should validate_presence_of(:course) }
  it { should validate_presence_of(:focus) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:capacity) }
end
