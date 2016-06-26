class Stacks::BooksController < StacksController
  def index
    @books = Book.in_library.order(created_at: :desc).limit(5)
  end

  def show
    @book = Book.in_library.find(params[:id])
  end

  def search
    query = Book.in_library.ransack(search_params)
    @books = query.result.includes(:authors).page(params[:page])
  end

  def advanced_search

  end

  private

  def search_params
    params.fetch(:q).permit!.to_hash
  end
end