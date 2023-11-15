require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  describe 'associations' do
    it { should belong_to(:student).class_name('Student') }
  end
end
