class Instructor < ApplicationRecord
  has_many :courses
  has_one_attached :profile_picture, dependent: :destroy  

  validates :name, :email, presence: true
  validates :email, uniqueness: true


  def display_name
    "#{name} - #{email}"
  end
end
