class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments

  validates :title, presence: false
  validates :catch_copy, presence: false
  validates :concept, presence: false
  validates :image, presence: false
end