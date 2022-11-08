class Booking < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :start_date, comparison: { greater_than: Date.new, message: "can't be in the past." }
  validates :end_date, comparison: { greater_than: :start_date, message: "should be a date after start date." }
  validates :status, inclusion: { in: ["requested", "confirmed", "declined"] }
  validate :start_date_cannot_be_in_the_past

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date.present? && start_date < Date.today
  end
end
