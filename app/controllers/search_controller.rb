class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def barcode
  end

  def title
  end

  def by_barcode
    @books = Book.where(isbn_13: params[:isbn_13])
    unless @books.any?
      flash[:error] = 'No books found with the scanned ISBN'
      redirect_to :index
      return
    end
  end

  def by_title
    query = Book.ransack(search_params)
    @books = query.result.includes(:authors).page(params[:page])
    unless @books.any?
      flash[:error] = 'No books found with that title'
      redirect_to :index
      return
    end
  end
end
