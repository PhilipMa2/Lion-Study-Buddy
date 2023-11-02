require 'rails_helper'

RSpec.describe StudentAttendPost, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:post) }
  end
end