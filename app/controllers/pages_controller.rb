class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @books = Book.where("price > ?", 1)
  end
end
