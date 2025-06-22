class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all
  
    # Filter by author, category, or title
    @books = @books.where(author_id: params[:author_id]) if params[:author_id].present?
    @books = @books.where(category_id: params[:category_id]) if params[:category_id].present?
    @books = @books.where("title ILIKE ?", "%#{params[:title]}%") if params[:title].present?
  
    # Sorting logic
    if params[:sort].present?
      sort_column = params[:sort]
      sort_direction = params[:direction] == "desc" ? "desc" : "asc"
      @books = @books.order("#{sort_column} #{sort_direction}")
    end
  end
  
  def show
    @book = Book.find(params[:id])

    if @book.price.present? && @book.price > 0
      unless @book.book_purchases.exists?(user: current_user, paid: true)
        redirect_to books_path, alert: "You need to buy this book to view it."
      end
    end
  end

  def checkout
    @book = Book.find(params[:id])

    if @book.book_purchases.exists?(user: current_user, paid: true)
      redirect_to @book, notice: "You've already purchased this book."
    end
  end



  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    puts ">>>>>>>>>>>>>", book_params
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :genre, :synopsis, :rating, :cover_image, :file, :availability_status, :author_id, :category_id)
    end
end
