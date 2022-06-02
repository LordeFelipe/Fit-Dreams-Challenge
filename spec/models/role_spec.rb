require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'factory' do
    context 'when using standard student factory' do
      it { expect(build(:student)).to be_valid }
    end

    context 'when using standard teacher factory' do
      it { expect(build(:teacher)).to be_valid }
    end

    context 'when using standard admin factory' do
      it { expect(build(:admin)).to be_valid }
    end
  end
end
