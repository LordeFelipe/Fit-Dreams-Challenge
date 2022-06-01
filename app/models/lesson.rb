class Lesson < ApplicationRecord
  validates :name, :description, :start_time, :duration, presence: true
  validates :name, uniqueness: true
  belongs_to :category
end
