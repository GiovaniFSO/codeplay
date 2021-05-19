class Instructor < ApplicationRecord
  has_one_attached :profile_picture, dependent: :destroy  

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
