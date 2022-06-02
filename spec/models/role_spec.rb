require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'factory' do
    context 'when using standard student factory' do
      it { expect(build(:student_role)).to be_valid }
    end

    context 'when using standard teacher factory' do
      it { expect(build(:teacher_role)).to be_valid }
    end

    context 'when using standard admin factory' do
      it { expect(build(:admin_role)).to be_valid }
    end
  end
end
