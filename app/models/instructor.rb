class Instructor < ApplicationRecord
  has_one_attached :profile_picture, dependent: :destroy  

  validates :name, :email, presence: { message: 'não pode ficar em branco' }
  validates :email, uniqueness: { message: 'já está em uso' }
end
