class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates :username,
            presence: true,
            length: { maximum: 30 },
            uniqueness: { case_sensitive: false }
end
