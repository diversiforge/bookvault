class Stacks::BrowseController < StacksController
  def show
    @newest_books = Book.newest(5)
  end

  def by_tag

  end

  def by_author

  end
end