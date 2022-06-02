require 'rails_helper'

RSpec.describe User, type: :model do
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

  describe 'validations' do
    context 'when it doesnt have a name' do
      it { expect(build(:student, name: '')).to be_invalid }
    end

    context 'when it doesnt have a birthdate' do
      it { expect(build(:student, birthdate: '')).to be_invalid }
    end

    context 'when it doesnt have a email' do
      it { expect(build(:student, email: '')).to be_invalid }
    end

    context 'when it doesnt have a role' do
      it { expect(build(:student, role_id: '')).to be_invalid }
    end

    context 'when the role does not exist' do
      it { expect(build(:student, role_id: -1)).to be_invalid }
    end

    context 'when the password does not exist' do
      it { expect(build(:student, password: '')).to be_invalid }
    end

    context 'when the password is to short' do
      it { expect(build(:student, password: '123')).to be_invalid }
    end

    context 'when the email is not unique' do
      it do
        create(:student, email: 'email@email.com')
        expect(build(:student, email: 'email@email.com')).to be_invalid
      end
    end

    context 'when the email is unique' do
      it do
        create(:student, email: 'email@email.com')
        expect(build(:student, email: 'felipe@vaz.com')).to be_valid
      end
    end
  end
end
