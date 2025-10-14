class HomeController < ApplicationController
  
  def index
    @authors_count = Author.count
    @books_count = Book.count
    @categories_count = Category.count
  end

  def root
  end
end
