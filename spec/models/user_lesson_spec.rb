require 'rails_helper'

RSpec.describe UserLesson, type: :model do
  context 'when using standard use lesson factory' do
    it { expect(build(:user_lesson)).to be_valid }
  end
end
