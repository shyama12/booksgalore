class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user.id, start_date: Date.today..).order("created_at DESC")
    @lapsed_bookings = Booking.where(user_id: current_user.id, start_date: ...Date.today, status: "requested").order("created_at DESC")
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
      redirect_to bookings_path, notice: "Request sent to #{@booking.book.user.first_name} #{@booking.book.user.last_name} for #{@booking.book.title}".html_safe
    else
      @review = Review.new(book: @book)
      render 'books/show', status: :unprocessable_entity
    end
  end

  def requested
    @bookings = Booking.joins(:book).where(books: { user_id: current_user.id }, bookings: { status: "requested", start_date: Date.today.. }).order("bookings.created_at DESC")
  end

  def confirm
    @booking = Booking.find(params[:id])
    @booking.status = "confirmed"
    @booking.save
    redirect_to requested_bookings_path, notice: "You have accepted booking request made by #{@booking.user.first_name} #{@booking.user.last_name}"
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.status = "declined"
    @booking.book.available = true
    @booking.book.save
    @booking.save
    redirect_to requested_bookings_path, notice: "You have rejected booking request made by #{@booking.user.first_name} #{@booking.user.last_name}"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
