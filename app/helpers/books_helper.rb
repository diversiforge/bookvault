module BooksHelper
  def author_list_links(book)
    book.authors.map{|a| link_to a.name, author_path(a)}.join(',').html_safe
  end
end
