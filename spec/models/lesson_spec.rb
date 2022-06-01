require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:lesson)).to be_valid }
    end
  end

  describe 'validations' do
    context 'when it doesnt have a name' do
      it { expect(build(:lesson, name: '')).to be_invalid }
    end

    context 'when it doesnt have a description' do
      it { expect(build(:lesson, description: '')).to be_invalid }
    end

    context 'when it doesnt have a start_time' do
      it { expect(build(:lesson, start_time: '')).to be_invalid }
    end

    context 'when it doesnt have a duration' do
      it { expect(build(:lesson, duration: '')).to be_invalid }
    end

    context 'when it doesnt have a category' do
      it { expect(build(:lesson, category_id: '')).to be_invalid }
    end

    context 'when the category does not exist' do
      it { expect(build(:lesson, category_id: -1)).to be_invalid }
    end

    context 'when the name is not unique' do
      it do
        create(:lesson, name: 'Unico')
        expect(build(:lesson, name: 'Unico')).not_to be_valid
      end
    end

    context 'when the name is unique' do
      it do
        create(:lesson, name: 'Unico 1')
        expect(build(:lesson, name: 'Unico 2')).not_to be_invalid
      end
    end
  end
end
