class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def create
    @book = Book.find(params[:book_id])
    @booking = Booking.new(booking_params)
    @booking.book = @book
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path, notice: "Booking request sent to #{@booking.book.user.first_name} #{@booking.book.user.last_name} for #{@booking.book.title}"
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
