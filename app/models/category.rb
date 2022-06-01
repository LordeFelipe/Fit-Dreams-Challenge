# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, :description, presence: true
  validates :name, uniqueness: true
  has_many :lessons, dependent: :destroy
end
