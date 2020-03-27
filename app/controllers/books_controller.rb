class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy, :update_from_open_library]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all.order(created_at: :desc).limit(5)
    @tags = Book.tag_counts_on(:tags)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  def new_manual
    @book = Book.new
  end

  def new_by_isbn
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    isbn = !params[:book][:isbn13].blank? ? params[:book][:isbn13] : params[:book][:isbn10]
    @book = GenericSearchInterface.new.by_isbn(isbn)
    @book.in_library = true # for now...

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book.to_json, status: :created }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_by_isbn
    isbn = !params[:book][:isbn13].blank? ? params[:book][:isbn13] : params[:book][:isbn10]
    @book = GenericSearchInterface.new.by_isbn(isbn)
    @book.in_library = true # for now...

    respond_to do |format|
      if @book.save
        flash.now[:notice] = "#{@book.title} was successfully created"
        format.html { redirect_to new_by_isbn_books_path, notice: "#{@book.title} was successfully created." }
        format.json { render json: @book.to_json, status: :created }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_manual
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book.to_json, status: :created }
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
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    query = Book.ransack(search_params)
    @books = query.result.includes(:authors).page(params[:page])
  end

  def export
    BookExporter.new(Book.in_library).export
    AuthorExporter.new(Author.all).export
    flash[:notice] = 'Done exporting'
    redirect_to books_path
  end

  def update_from_google_books
    
  end

  def update_from_open_library
    new_book = GenericSearchInterface.new.by_isbn(@book.isbn13, :open_library)
    new_book.save
    redirect_to @book
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.fetch(:book).permit(:isbn13, :title, :subtitle, :published_date, :description, :page_count, :published_year, :published_month, :published_day)
    end

  def search_params
    params.fetch(:q).permit!.to_hash
  end
end
