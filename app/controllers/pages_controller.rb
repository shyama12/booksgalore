class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @books_of_the_week = Book.order(created_at: :desc).limit(3)
    @budget_books = Book.where("price < ?", 1).limit(3)
  end
end
