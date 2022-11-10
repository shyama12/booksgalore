class Book < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  has_many :reviews, dependent: :destroy
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :summary, presence: true, length: { minimum: 2, maximum: 2000 }
  validates :price, presence: true, numericality: true
  validates :photo, presence: true

  include PgSearch::Model

  pg_search_scope :search_by_title_and_author_and_genre,
    against: [ :title, :author, :genre ],
    using: {
      tsearch: { prefix: true }
    }
end
