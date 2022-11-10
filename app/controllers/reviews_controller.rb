class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @book = Book.find(params[:book_id])
    @review.book = @book
    if @review.save
      redirect_to book_path(@book)
    else
      @booking = Booking.new
      render 'books/show', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
