class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def new
    @book = Book.find(params[:book_id])
    @booking = Booking.new
  end

  def create
    @book = Book.find(params[:book_id])
    @booking = Booking.new(booking_params)
    @booking.book = @book
    @booking.user = current_user
    @booking.status = "requested"
    @booking.book.available = false
    @booking.book.save
    if @booking.save
      redirect_to books_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def requested
    @bookings = Booking.joins(:book).where('book.user_id': current_user.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
