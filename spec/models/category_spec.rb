# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'factory' do 
    context 'when using standard factory' do
      it {expect(build(:category)).to be_valid}
    end
  end

  describe 'validations' do 
    context 'when it doesnt have a name' do
      it {expect(build(:category, name: '')).to be_invalid}
    end

    context 'when it doesnt have a description' do
      it {expect(build(:category, description: '')).to be_invalid}
    end

    context 'when the name is not unique' do
      it do
        create(:category)
        expect(build(:category)).not_to be_valid
      end
    end

    context 'when the name is unique' do
      it do
        create(:category, name: "Unico 1")
        expect(build(:category, name: "Unico 2")).not_to be_invalid
      end
    end
  end
end
