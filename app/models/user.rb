class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :birthdate, presence: true
  validates :email, uniqueness: true

  belongs_to :role

  has_many :user_lessons, dependent: :destroy
  has_many :lessons, through: :user_lessons
end
