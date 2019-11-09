class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit]

  # GET /books
  # GET /books.json
  def index
    @books = Book.search(book_search_params)

    if current_user.student?
      university = University.find(current_user.university_id)
      @books = @books.where(library_id: university.libraries)
    elsif current_user.librerian?
      @books = @books.where(library_id: current_user.library_id)
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @can_order = @book.can_order_by?(current_user)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/all
  def all
    @books_all = Book.active
    render "all"
  end

  # GET /books/1/edit
  def edit
  end

  def show_book_by_library_id
    @books = Book.where(library_id: params[:id])
    render "index"
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.inactive!
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(
        :title,
        :isbn,
        :number_of_copies,
        :authors,
        :language,
        :published_date,
        :edition,
        :subject,
        :summary,
        :special_collection,
        :library_id,
        :avatar
      )
    end

    def book_search_params
      params.permit(:title, :authors, :published_date, :special_collection)
    end

    def authorize_user
      authorize @book
    end
end
