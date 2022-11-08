class Book < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :summary, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :price, presence: true, numericality: true
  validates :photo, presence: true
end
