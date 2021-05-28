class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :code, use: :slugged

  belongs_to :instructor
  has_many :lessons
  has_many :enrollments

  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true
end
