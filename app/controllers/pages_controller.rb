class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @books = Book.where("price > ? AND available = ?", 1, true)
  end
end
