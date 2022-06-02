class Lesson < ApplicationRecord
  validates :name, :description, :start_time, :duration, presence: true
  validates :name, uniqueness: true
  belongs_to :category

  has_many :user_lessons, dependent: :destroy
  has_many :users, through: :user_lessons
end
