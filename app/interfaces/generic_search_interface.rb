# Provide an abstract interface for various types of search term

class GenericSearchInterface
  def by_isbn(term, *sources)
    available_sources = [:google_books]
    sources = sources.blank? ? available_sources : (available_sources & sources)
    book = Book.new(isbn13: term)
    sources.each do |s|
      interface = "#{s.to_s}_interface".camelize.constantize.new
      case interface
        when GoogleBooksInterface
          response = interface.by_isbn(term)
          book.build_from_google_books(response) if response
        else
          nil
      end
    end
    book
  end

  def by_title(term, *sources)

  end

  def by_text(term, *sources)

  end

  def by_author(term, *sources)

  end
end