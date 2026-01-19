class Course < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :distance, presence: true
  validates :duration, presence: true
  validates :description, presence: true

  # validate :image_presence

  private

  # def image_presence
    # errors.add(:image, "をアップロードしてください") unless image.attached?
  # end
end
