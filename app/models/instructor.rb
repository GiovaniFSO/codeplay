class Instructor < ApplicationRecord
  has_one_attached :profile_picture, dependent: :destroy  

  validates :name, presence: true
  validates_uniqueness_of :email
end
