class Role < ApplicationRecord
  validates :name, presence: true
  has_many :users, dependent: :destroy
end
