class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    if params[:query].present?
      @books = Book.is_available.search_by_title_and_author_and_genre(params[:query])
    else
      @books = Book.is_available
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.new
    @review = Review.new(book: @book)
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Your book has been updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  private

  def book_params
    params.require(:book).permit(:title, :genre, :author, :price, :summary, :photo)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
